import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../l10n/app_localizations.dart';
import 'home_page.dart';

class EmailPage extends StatefulWidget {
  final dynamic mode;
  final dynamic device;

  const EmailPage({super.key, this.mode, this.device});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = _emailController.text;
    final isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    setState(() {
      _isEmailValid = isValid;
    });
  }

  void _onNextStep() {
    if (_isEmailValid) {
      // 模拟登录/注册成功，直接跳转首页，并清空导航栈
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = widget.mode == 'login';
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isLogin ? l10n.welcomeBack : l10n.createAccount,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
                cursorColor: AppColors.primaryYellow,
                decoration: InputDecoration(
                  hintText: l10n.emailHint,
                  hintStyle: const TextStyle(
                    color: AppColors.textHint,
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: AppColors.backgroundLight,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryYellow,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryYellow,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isEmailValid ? _onNextStep : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryYellow,
                    disabledBackgroundColor: AppColors.primaryYellowLighter,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.nextStep,
                    style: TextStyle(
                      color: _isEmailValid
                          ? AppColors.textPrimary
                          : AppColors.textHint,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: l10n.termsPrefix,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                    children: [
                      TextSpan(
                        text: l10n.termsOfService,
                        style: const TextStyle(color: AppColors.infoBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // TODO: 导航到服务条款页面
                          },
                      ),
                      TextSpan(text: l10n.andText),
                      TextSpan(
                        text: l10n.privacyPolicy,
                        style: const TextStyle(color: AppColors.infoBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // TODO: 导航到隐私政策页面
                          },
                      ),
                      TextSpan(text: l10n.period),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
