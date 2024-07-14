import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbutomy/feature/authentication/screens/phonescreen.dart';

import '../controllor/authcontrollor.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthController(auth_repository: authRepository, ref: ref);
});

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset('assets/images/authlogo.png'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            InkWell(
              onTap: () {
                ref.watch(authControllerProvider.notifier).signInWithGoogle(context);
                print('************* pressed ********');
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                ),
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.03,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset('assets/images/google.png'),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    Text(
                      'Google',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneScreen(),));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                ),
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Icon(Icons.phone, color: Colors.white),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    Text(
                      'Phone',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
