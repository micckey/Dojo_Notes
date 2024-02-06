import 'package:dojonotes/auth_pages/login_page.dart';
import 'package:dojonotes/auth_pages/register_page.dart';
import 'package:flutter/material.dart';

class SwitchAuthPage extends StatefulWidget {
  const SwitchAuthPage({super.key, required this.authPage});

  final String authPage;

  @override
  State<SwitchAuthPage> createState() => _SwitchAuthPageState();
}

class _SwitchAuthPageState extends State<SwitchAuthPage> {
  bool isLogin = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String page = widget.authPage;
    if (page == 'register') {
      isLogin = false;
    }
  }

  void switchAuthPage() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginScreen(
        switchAuthPageFunction: switchAuthPage,
      );
    }
    return RegisterScreen(
      switchAuthPageFunction: switchAuthPage,
    );
  }
}
