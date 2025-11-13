import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/Appbar/Appbar.dart';
import '../../components/colors/colors.dart';
import '../bloc/user_cubit.dart';
import '../bloc/user_state.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.status == UserStatus.unauthenticated ||
            state.status == UserStatus.unknown) {
          return _LoginPrompt();
        }
        if (state.status == UserStatus.authenticated && state.profile != null) {
          final p = state.profile!;

          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppbarWidget(title: "Profile"),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  surfaceTintColor: secondaryColor,
                  shadowColor: primaryColor,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: backgroundColor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                            child: Image.asset(
                              'assets/image/Profile.jpg',
                              fit: BoxFit.contain,
                              height: 100,
                              errorBuilder: (_, __, ___) =>
                                  Icon(Icons.person, color: textPrimary),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          p.customerName.isEmpty ? 'User' : p.customerName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit',
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p.email,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                _SectionCard(
                  title: 'Contact',
                  children: [
                    _kv('Phone', p.customerPhone),
                    _kv('Fax', p.customerFax),
                  ],
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'Billing Address',
                  children: [
                    _kv('Address', p.customerAddress),
                    _kv('City', p.customerCity),
                    _kv('State', p.customerState),
                    _kv('Postcode', p.customerPostcode),
                    _kv('Country', p.customerCountry),
                  ],
                ),
                const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.4), // shadow color
                    blurRadius: 12, // how soft the shadow is
                    spreadRadius: 2, // how far the shadow spreads
                    offset: const Offset(0, 6), // move shadow down
                  ),
                ],
              ),
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: () => context.read<UserCubit>().logout(),
                child: const Text('Logout'),
              ),
            )
              ],
            ),
          );
        }

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppbarWidget(title: "Profile"),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: LoadingAnimationWidget.flickr(
                leftDotColor: secondaryColor,
                rightDotColor: primaryColor,

                size: 60,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _kv(String k, String v) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(k, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(v.isEmpty ? '-' : v),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({Key? key, required this.title, required this.children})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // same as first card's background
      surfaceTintColor: secondaryColor,
      shadowColor: primaryColor,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppbarWidget(title: "Profile"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_outline, size: 72, color: textPrimary),
              const SizedBox(height: 12),
              const Text(
                'You are not logged in !',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2), // shadow color
                      blurRadius: 8, // how soft the shadow is
                       // how far the shadow spreads
                      offset: const Offset(0, 6), // move shadow down
                    ),
                  ],
                ),
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => const LoginPage()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
