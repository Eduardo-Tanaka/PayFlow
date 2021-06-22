import 'package:flutter/material.dart';
import 'package:nlw2021/modules/login/login_page.dart';
import 'package:nlw2021/modules/splash/splash_page.dart';
import 'package:nlw2021/shared/themes/app_colors.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      theme: ThemeData(primaryColor: AppColors.primary),
      home: LoginPage(),
    );
  }
}
