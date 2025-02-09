import 'package:flutter/material.dart';
import 'package:get_data/core/widgets/responsive.dart';
import 'package:get_data/screens/welcome_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            //         child: Row(
            //   children: [
            //     if (Responsive.isDesktop(context))
            //       const Expanded(flex: 5, child: WelcomeScreen()),
            //   ],
            // )
            child: WelcomeScreen()));
  }
}
