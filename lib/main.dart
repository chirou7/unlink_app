import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart'; // Add this line
// 引入 Trae 帮你建好的欢迎页（确保你的 lib 下有 pages 文件夹）
import 'pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unlink App',
      debugShowCheckedModeBanner: false, // 关掉右上角红色的 DEBUG 标签
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // 设置默认背景色
      ),
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // 这里最关键：把 App 的首页指针，指向你生成的 WelcomePage
      home: const WelcomePage(),
    );
  }
}
