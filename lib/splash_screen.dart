import 'dart:async';
import 'package:flutter/material.dart';
import 'grid_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const GridData()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            margin: EdgeInsets.zero,
            width: 200,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    width: 200,
                    child: Text(
                      "Welcome to Word Search",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: 50,
                  height: 50,
                  child: const CircularProgressIndicator(),
                )
              ],
            )),
      ),
    );
  }
}
