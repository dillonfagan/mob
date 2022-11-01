import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mob_app/models/mobber.dart';
import 'package:mob_app/pages/timer/timer.dart';
import 'package:mob_app/providers/mob.dart';
import 'package:provider/provider.dart';

import 'widgets/mobber_field.dart';
import 'widgets/mobbers_listview.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: mobbers.length > 1
            ? IconButton(
                onPressed: () {
                  mob.shuffleMobbers();
                },
                icon: const Icon(Icons.rotate_left_rounded),
                tooltip: 'Shuffle mobbers',
              )
            : null,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: min(MediaQuery.of(context).size.width, 500),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: MobberField(
                  controller: mobberController,
                  onSubmitted: (value) {
                    if (value.isEmpty) return;
                    mobberController.clear();
                    mobbers.add(Mobber(name: value));
                    mob.mobbers = mobbers;
                  },
                ),
              ),
              MobbersListView(
                mobbers: mobbers,
                onMobberRemoved: (index) {
                  mobbers.removeAt(index);
                  mob.mobbers = mobbers;
                },
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
          child: const Icon(
            Icons.play_arrow_rounded,
            size: 36,
          ),
        ),
      ),
    );
  }
}
