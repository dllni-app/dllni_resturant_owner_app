import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

@AutoRoutePage(path: '/support')
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  Future<void> _open(BuildContext context, Uri uri, String errorMessage) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      AppToast.showToast(context: context, message: errorMessage, type: ToastificationType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            _Header(title: 'الدعم الفني'),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                children: [
                  _SupportCard(
                    icon: Icons.phone_in_talk_rounded,
                    title: 'اتصال مباشر',
                    subtitle: 'تواصل مع فريق الدعم عبر الهاتف',
                    onTap: () => _open(context, Uri(scheme: 'tel', path: '+963000000000'), 'تعذر فتح تطبيق الاتصال'),
                  ),
                  const SizedBox(height: 12),
                  _SupportCard(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: 'واتساب',
                    subtitle: 'أرسل رسالة للدعم الفني',
                    onTap: () => _open(context, Uri.parse('https://wa.me/963000000000'), 'تعذر فتح واتساب'),
                  ),
                  const SizedBox(height: 12),
                  _SupportCard(
                    icon: Icons.email_outlined,
                    title: 'البريد الإلكتروني',
                    subtitle: 'support@dllni.app',
                    onTap: () => _open(context, Uri(scheme: 'mailto', path: 'support@dllni.app'), 'تعذر فتح البريد الإلكتروني'),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsetsDirectional.all(16),
                    decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(18)),
                    child: AppText.bodyMedium(
                      'سيتم ربط بيانات الدعم الرسمية من الإعدادات عند توفرها من لوحة التحكم. حالياً هذه الصفحة تمنع بقاء خيار الدعم الفني بدون إجراء وتوفر قنوات تواصل قابلة للتعديل.',
                      color: const Color(0xff6B7280),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  const _SupportCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(18)),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: context.primary.withAlpha(25), borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: context.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodyLarge(title, fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                  const SizedBox(height: 4),
                  AppText.bodyMedium(subtitle, color: const Color(0xff6B7280), textAlign: TextAlign.start),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xff9CA3AF)),
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
