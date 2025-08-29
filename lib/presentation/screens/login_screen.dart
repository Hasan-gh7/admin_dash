import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_dashboard/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_estate_dashboard/logic/blocs/auth_bloc/auth_event.dart';
import 'package:real_estate_dashboard/logic/blocs/auth_bloc/auth_state.dart';

import 'admin_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
                    );
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.home_work, size: 64, color: Colors.blueAccent),
                      const SizedBox(height: 16),
                      Text("تسجيل الدخول", style: theme.textTheme.titleLarge),
                      const SizedBox(height: 24),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "البريد الإلكتروني",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "كلمة المرور",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      state is AuthLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.login),
                                label: const Text("دخول"),
                                onPressed: () {
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();
                                  context.read<AuthBloc>().add(LoginRequested(email, password));
                                },
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}