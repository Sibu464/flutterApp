import 'package:flutter/material.dart';
import 'package:get_data/screens/graph%20screen.dart';

class TabletWelcome extends StatelessWidget {
  const TabletWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
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
                    debugPrint('Card tapped.');
                  },
                  child: const SizedBox(
                    width: 350,
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Welcome user, Tap to proceed!'),
                          Text('Tablet')
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
