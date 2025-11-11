import 'package:aryanfront/Pages/Home/login.dart';
import 'package:flutter/material.dart';

import '../../Elements/Commons/aryan_logo.dart';

class StartLoadingPage extends StatefulWidget {
  const StartLoadingPage({super.key});

  @override
  State<StartLoadingPage> createState() => _StartLoadingPageState();
}

class _StartLoadingPageState extends State<StartLoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _translateY;
  late Animation<double> _opacity;

  bool _loaderVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _translateY = Tween<double>(begin: 0, end: -200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(const Duration(milliseconds: 500), () async {
      await _controller.forward();
      setState(() => _loaderVisible = true);

      // await flutterLocalNotificationsPlugin
      //     .resolvePlatformSpecificImplementation<
      //       AndroidFlutterLocalNotificationsPlugin
      //     >()
      //     ?.requestNotificationsPermission();

      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, _translateY.value),
                  child: Opacity(opacity: _opacity.value, child: AryanLogo()),
                ),
                const SizedBox(height: 40),
                if (_loaderVisible)
                  const CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 3,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
