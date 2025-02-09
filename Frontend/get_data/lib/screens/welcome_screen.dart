import 'package:flutter/material.dart';
import 'package:get_data/core/widgets/responsive.dart';
import 'package:get_data/screens/Tablet/tablet.dart';
import 'package:get_data/screens/desktop/desktop.dart';
import 'package:get_data/screens/mobile/mobile.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        desktop: DesktopWelcome(),
        mobile: MobileWelcome(),
        tablet: TabletWelcome());
  }
}
