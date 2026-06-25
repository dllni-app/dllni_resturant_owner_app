import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/fetch_activity_logs_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/profile_bloc.dart';
import '../widgets/activity_empty_state.dart';
import '../widgets/activity_error_state.dart';
import '../widgets/activity_log_card.dart';
import '../widgets/activity_log_filter_chips.dart';

class ActivityLogsScreenParams {
  final String title;
  final String description;
  final String? logName;

  const ActivityLogsScreenParams({required this.title, required this.description, this.logName});
}

@AutoRoutePage(path: '/employees/activity/logs')
class ActivityLogsScreen extends StatefulWidget {
  const ActivityLogsScreen({super.key, required this.params});

  final ActivityLogsScreenParams params;

  @override
  State<ActivityLogsScreen> createState() => _ActivityLogsScreenState();
}

class _ActivityLogsScreenState extends State<ActivityLogsScreen> {
  final ScrollController _scrollController = ScrollController();
  String? selectedLogName;

  @override
  void initState() {
    super.initState();
    selectedLogName = widget.params.logName;
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _reload());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  FetchActivityLogsParams _params({int page = 1}) => FetchActivityLogsParams(logName: selectedLogName, page: page, perPage: 15);

  void _reload() => context.read<ProfileBloc>().add(FetchActivityLogsEvent(params: _params(), isReload: true));

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels < _scrollController.position.maxScrollExtent - 220) return;
    final logsState = context.read<ProfileBloc>().state.activityLogs;
    if (logsState == null || logsState.status == BlocStatus.loading || logsState.isEndPage) return;
    context.read<ProfileBloc>().add(FetchActivityLogsEvent(params: _params(page: logsState.pageNumber)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            _Header(title: widget.params.title),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.all(16),
                decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(18)),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(color: context.primary.withAlpha(25), borderRadius: BorderRadius.circular(14)),
                      child: Icon(Icons.info_outline_rounded, color: context.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: AppText.bodyMedium(widget.params.description, color: const Color(0xff6B7280), textAlign: TextAlign.start)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ActivityLogFilterChips(
              selectedLogName: selectedLogName,
              onChanged: (value) {
                setState(() => selectedLogName = value);
                _reload();
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => _reload(),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    final logsState = state.activityLogs!;
                    return logsState.builder(
                      loadingWidget: const Center(child: SizedBox(width: 32, height: 32, child: FittedBox(child: CircularProgressIndicator.adaptive()))),
                      emptyWidget: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [ActivityEmptyState(title: 'لا يوجد نشاط حالياً', message: 'لم يتم تسجيل أي نشاط ضمن هذا التصنيف بعد.', onRefresh: _reload)],
                      ),
                      failedWidget: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [ActivityErrorState(message: logsState.errorMessage.isNotEmpty ? logsState.errorMessage : 'حدث خطأ أثناء تحميل سجل النشاط', onRetry: _reload)],
                      ),
                      successWidget: () {
                        final showBottomLoader = logsState.status == BlocStatus.loading && logsState.list.isNotEmpty;
                        return ListView.separated(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 24),
                          itemBuilder: (context, index) {
                            if (index >= logsState.list.length) {
                              return const Padding(
                                padding: EdgeInsetsDirectional.symmetric(vertical: 12),
                                child: Center(child: SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator.adaptive()))),
                              );
                            }
                            return ActivityLogCard(item: logsState.list[index]);
                          },
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemCount: logsState.list.length + (showBottomLoader ? 1 : 0),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.fromSTEB(24, 16 + MediaQuery.paddingOf(context).top, 24, 18),
      decoration: BoxDecoration(
        color: context.onPrimary,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: context.primaryContainer, width: 4)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.pop(),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(border: Border.all(color: const Color(0xffE5E7EB)), borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: AppText.headlineLarge(title, fontWeight: FontWeight.bold, textAlign: TextAlign.start)),
        ],
      ),
    );
  }
}
