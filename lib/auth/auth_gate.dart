import 'package:assignment_tracker/provider/auth_provider.dart';
import 'package:assignment_tracker/screens/login_screen.dart';
import 'package:assignment_tracker/screens/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final auth = context.read<AuthProvider>();
    final result = await auth.isLoggedIn();

    if (!mounted) return;

    setState(() {
      isLoggedIn = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (isLoggedIn == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (auth.userToken == null) {
      return const LoginScreen();
    }
    return const MainShell();
  }
}