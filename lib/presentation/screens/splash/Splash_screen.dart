import 'dart:async';

import 'package:community/bussines_logic/app_cubit.dart';
import 'package:community/core/my_cache_keys.dart';
import 'package:community/core/screens.dart' as screens;
import 'package:community/data/local/my_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    Timer(const Duration(milliseconds: 5000), () {
      _auth.authStateChanges().listen((user) {
        if (user == null) {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, screens.loginScreen, (route) => false);
          }
        } else {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, screens.homeScreen, (route) => false);
          }
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: _animation,
            child: Center(
              child: Image.asset('assets/splash.png'),
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Text(
            'Community',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22.sp,
                fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}
