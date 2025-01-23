import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).goNamed('login');
            },
            child: Text('nav'),
          ),
        ],
      ),
    );
  }
}
