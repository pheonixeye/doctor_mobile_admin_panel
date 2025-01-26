import 'dart:math';

import 'package:doctor_mobile_admin_panel/assets/assets.dart';
import 'package:doctor_mobile_admin_panel/router/router.dart';
import 'package:doctor_mobile_admin_panel/utils/util_keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' show Vector3;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController rotcont;

  @override
  void initState() {
    super.initState();
    waitThenNavigate();
    rotcont = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..forward();
  }

  @override
  void dispose() {
    rotcont.dispose();
    super.dispose();
  }

  Future<void> waitThenNavigate() async {
    await Future.delayed(const Duration(seconds: 5));
    if (navigatorKey.currentContext != null) {
      navigatorKey.currentContext!.goNamed(AppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppAssets.icon),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: AnimatedBuilder(
                animation: rotcont,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(rotcont.value * (-pi) * 5),
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppAssets.arc,
                      width: 490,
                      height: 500,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: AnimatedBuilder(
                animation: rotcont,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(rotcont.value * (-pi) * 6),
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppAssets.arc,
                      width: 490,
                      height: 500,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: AnimatedBuilder(
                animation: rotcont,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotate(Vector3(90, 90, 0), rotcont.value * (-pi) * 7),
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppAssets.arc,
                      width: 490,
                      height: 500,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: AnimatedBuilder(
                animation: rotcont,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotate(Vector3(90, -90, 0), rotcont.value * (-pi) * 8),
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppAssets.arc,
                      width: 490,
                      height: 500,
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 64.0,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Admin Panel',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 32.0,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('Designed by Dr. Kareem Zaher'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
