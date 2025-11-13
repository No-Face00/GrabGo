import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabgo/presentation/components/colors/colors.dart';
import 'package:pinput/pinput.dart';


import '../bloc/user_cubit.dart';
import '../bloc/user_state.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.email});

  final String email;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final pinTheme = PinTheme(
      width: 50,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),

      decoration: BoxDecoration(
        color: backgroundColor ,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color:primaryColor ),
      ),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(

        padding: const EdgeInsets.all(16),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state.status == UserStatus.authenticated) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
            if (state.status == UserStatus.error && state.message != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message!)));
            }
          },
          builder: (context, state) {
            final isLoading = state.status == UserStatus.authenticating;
            return Center(
              child: SingleChildScrollView(
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
                                    height: 150,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (_, __, ___) =>
                                    const SizedBox(height: 64),
                                  ),
                                ),

                                Text(
                                  'Verify Code',
                                 style: TextStyle(
                                   fontSize: 35,
                                   fontWeight: FontWeight.bold,
                                   fontFamily: 'Outfit',
                                   color: textPrimary,
                                 )
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'We sent a 6-digit code to ${widget.email}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Outfit',

                                  ) ,
                                  ),


                              ],
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: Pinput(
                                length: 6,
                                controller: _otpController,
                                defaultPinTheme: pinTheme,
                                focusedPinTheme: pinTheme.copyWith(
                                  decoration: pinTheme.decoration?.copyWith(
                                    border: Border.all(
                                      color: primaryColor ,
                                    ),
                                  ),
                                ),
                                submittedPinTheme: pinTheme.copyWith(
                                  decoration: pinTheme.decoration?.copyWith(
                                    color: backgroundColor,
                                    border: Border.all(
                                      color: primaryColor ,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.length != 6) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 48,
                              child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(16),
                                    ),
                                  ),

                                onPressed:
                                isLoading
                                    ? null
                                    : () {
                                  if ((_formKey.currentState
                                      ?.validate() ??
                                      false) &&
                                      _otpController.text.length == 6) {
                                    context.read<UserCubit>().verifyOtp(
                                      email: widget.email,
                                      otp: _otpController.text,
                                    );
                                  }
                                },
                                child:
                                isLoading
                                    ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                                    : const Text('Verify',
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
                              'Didn\'t receive the code? Check spam or try again.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Outfit',

                              ) ,
                              ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
