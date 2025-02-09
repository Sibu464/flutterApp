import 'package:flutter/material.dart';
import 'package:get_data/screens/graph%20screen.dart';

class MobileWelcome extends StatelessWidget {
  const MobileWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(155, 158, 206, 58),
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
                width: 300,
                height: 100,
                child: const Center(
                  child: Text('Welcome user, Tap to proceed!'),
                ),
              ),
            ),
          ),
        ));
  }
}
