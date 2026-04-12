import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/add_employee_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/widgets/employee_management_card.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/widgets/employees_management_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/fetch_employees_use_case.dart';
import '../manager/bloc/profile_bloc.dart';

@AutoRoutePage(path: '/employeesmanagement')
class EmployeesManagementScreen extends StatefulWidget {
  const EmployeesManagementScreen({super.key});

  @override
  State<EmployeesManagementScreen> createState() => _EmployeesManagementScreenState();
}

class _EmployeesManagementScreenState extends State<EmployeesManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => getIt<ProfileBloc>()..add(FetchEmployeesEvent(params: FetchEmployeesParams())),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const EmployeesManagementAppBar(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    context.pushRoute('/employeesmanagement/new', arguments: AddEmployeeScreenParams());
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: context.primaryContainer),
                    width: context.width,
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 11,
                          backgroundColor: context.onPrimaryContainer.withAlpha(40),
                          child: Icon(Icons.add, color: context.onPrimaryContainer, size: 16),
                        ),
                        const SizedBox(width: 8),
                        AppText.labelLarge('إضافة موظف جديد', color: context.onPrimaryContainer, fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 16),
              // EmployeeManagementFilterCard(
              //   searchController: _searchController,
              // ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    switch (state.employeesStatus) {
                      case null:
                        return const SizedBox.shrink();
                      case BlocStatus.failed:
                        return Center(
                          child: AppText.labelLarge(state.errorMessage ?? 'حدث خطا ما', color: context.error, fontWeight: FontWeight.bold),
                        );
                      case BlocStatus.success:
                        return ListView.separated(
                          padding: const EdgeInsetsDirectional.only(start: 20, end: 20, bottom: 20),
                          itemBuilder: (context, index) => EmployeeManagementCard(item: state.employees!.data![index]),
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemCount: state.employees!.data!.length,
                        );
                      case BlocStatus.loading:
                        return Center(child: CircularProgressIndicator.adaptive());
                      case BlocStatus.init:
                        return Center(child: CircularProgressIndicator.adaptive());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
