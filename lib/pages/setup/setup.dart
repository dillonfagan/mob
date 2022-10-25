import 'package:flutter/material.dart';
import 'package:mob_app/pages/timer/timer.dart';
import 'package:mob_app/providers/mob.dart';
import 'package:provider/provider.dart';

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
    final mob = Provider.of<MobProvider>(context);
    final mobbers = mob.mobbers;

    return Scaffold(
      body: ListView.builder(
        itemCount: mobbers.length,
        itemBuilder: ((context, index) {
          return Card(
            child: ListTile(
              title: Text(mobbers[index].name),
              trailing: IconButton(
                onPressed: () {
                  mobbers.removeAt(index);
                  mob.mobbers = mobbers;
                },
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
              return const TimerPage();
            }),
          ));
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.timer_outlined),
      ),
    );
  }
}
