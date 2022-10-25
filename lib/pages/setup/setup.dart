import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mob_app/models/mobber.dart';
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
  final mobberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mob = Provider.of<MobProvider>(context);
    final mobbers = mob.mobbers;
    final turnLength = mob.turnLength;

    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: min(MediaQuery.of(context).size.width, 500),
          ),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Card(
                child: TextField(
                  controller: mobberController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add a mobber...',
                  ),
                  onSubmitted: (value) {
                    mobberController.clear();
                    mobbers.add(Mobber(name: value));
                    mob.mobbers = mobbers;
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: mobbers.isNotEmpty,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => TimerPage(seconds: turnLength)),
            ));
          },
          backgroundColor: Colors.amber,
          child: const Icon(Icons.timer_outlined),
        ),
      ),
    );
  }
}
