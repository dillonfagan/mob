import 'package:flutter/material.dart';
import 'package:mob_app/pages/timer/timer.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SetupPageState();
  }
}

class _SetupPageState extends State<SetupPage> {
  @override
  Widget build(BuildContext context) {
    final mobbers = ['Mobber 1', 'Mobber 2', 'Mobber 3'];

    return Scaffold(
      body: ListView.builder(
        itemCount: mobbers.length,
        itemBuilder: ((context, index) {
          return Card(
            child: ListTile(
              title: Text(mobbers[index]),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close_rounded),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) {
              return TimerPage();
            }),
          ));
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
