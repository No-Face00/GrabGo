import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../components/colors/colors.dart';

import '../bloc/user_cubit.dart';
import '../bloc/user_state.dart';
import 'otp_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state.status == UserStatus.otpSent && state.email != null) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => OtpPage(email: state.email!)),
            );
          }
          if (state.status == UserStatus.error && state.message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        builder: (context, state) {
          final isLoading = state.status == UserStatus.authenticating;
          return Container(
            decoration: BoxDecoration(

            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Card(
                      surfaceTintColor: secondaryColor,
                      shadowColor: primaryColor,
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      'assets/image/logo_2.png',
                                      fit: BoxFit.cover,
                                      height: 150
                                      ,

                                      errorBuilder:
                                          (_, __, ___) =>
                                      const SizedBox(height: 80),
                                    ),
                                  ),

                                  Text(
                                    'Welcome to GrabGo',
                                     style: TextStyle(
                                       fontSize: 30,
                                       fontWeight: FontWeight.bold,
                                       fontFamily: 'Outfit',
                                       color: textPrimary,
                                     ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Login with your email to continue',
                                    style: TextStyle(
                                      color: textPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Outfit',
                                ),
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  focusColor: primaryColor,

                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Outfit',
                                  ),

                                  hintText: 'you@example.com',
                                  hintStyle:
                                  TextStyle(
                                    color: textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Outfit',
                                  ),
                                  prefixIcon: Icon(Icons.alternate_email),

                                  enabledBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey, width: 1.2),
                                  ),

                                  // 🔹 Border when field is focused
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: primaryColor, width: 1.8),
                                  ),

                                  // 🔹 Border when there’s an error
                                  errorBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
                                  ),

                                  // 🔹 Border when focused and error present
                                  focusedErrorBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.redAccent, width: 1.8),
                                  ),

                                ),

                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 48,
                                child: FilledButton.icon(
                                  icon: const Icon(Icons.lock_open),
                                  onPressed:
                                  isLoading
                                      ? null
                                      : () {
                                    if (_formKey.currentState
                                        ?.validate() ??
                                        false) {
                                      context
                                          .read<UserCubit>()
                                          .requestOtp(
                                        _emailController.text
                                            .trim(),
                                      );
                                    }
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(16),
                                    ),
                                  ) ,
                                  label:
                                  isLoading
                                      ? const SizedBox(

                                    height: 20,
                                    width: 20,

                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                      : const Text('Send OTP',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Outfit',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'We will send a 6-digit code to your email',
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Outfit',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
