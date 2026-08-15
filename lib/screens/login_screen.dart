import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/custom/custom_text_form_field.dart';
import 'package:assignment_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:assignment_tracker/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super
        .dispose(); // dispose the state of the parent class after disposing the controllers
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return; // validate the form fields
    }

    final auth = context.read<AuthProvider>();
    final success = await auth.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted) {
      return;
    } // check if the widget is still mounted before navigating
    /* mount is a property of the State class that indicates whether the widget is currently in the widget tree. 
    If the widget is not mounted, it means that it has been removed from the widget tree and any attempt to 
    navigate to another screen will result in an error. Therefore, we check if the widget is still mounted before
    navigating to another screen.
    */

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(text: auth.errorMessage ?? 'Login Failed'),
        ),
      );
    }
    Navigator.pushReplacement(
      context,

      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: "Track Assignments"),
              SizedBox(height: 20),
              CustomText(text: "Welcome back"),
              SizedBox(height: 10),
              CustomText(
                text: "Please enter your details to sign in.",
                fontSize: 16,
              ),
              SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Email", fontSize: 18),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        icon: Icons.email,
                        hintText: "Enter your email",
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      CustomText(text: "Password", fontSize: 18),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        icon: Icons.visibility_off,
                        isPassword: true,
                        hintText: "**********",
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16),
                          ),
                        ),
                        onPressed: isLoading ? null : _submit,
                        child: isLoading
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : CustomText(text: "Login"),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "Don't have an account?", fontSize: 16),
                  SizedBox(width: 10),
                  CustomText(text: "Create account", fontSize: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
