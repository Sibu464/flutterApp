import 'package:flutter/material.dart';
import 'package:get_data/screens/graph%20screen.dart';

class DesktopWelcome extends StatelessWidget {
  const DesktopWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(71, 59, 240, 66),
      body: Center(
          child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SawtoothGraph()),
            );
          },
          child: const SizedBox(
            width: 400,
            height: 220,
            child: const Center(
              child: Text('Welcome user, Tap to proceed!'),
            ),
          ),
        ),
      )),
    );
  }
}
