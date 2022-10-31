import 'package:flutter/material.dart';
import 'package:mob_app/models/mobber.dart';

class MobbersListView extends StatelessWidget {
  const MobbersListView({
    super.key,
    required this.mobbers,
    this.onMobberRemoved,
  });

  final List<Mobber> mobbers;
  final Function(int)? onMobberRemoved;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: mobbers.length,
        itemBuilder: ((context, index) {
          return Card(
            child: ListTile(
              title: Text(
                mobbers[index].name,
                style: const TextStyle(fontSize: 24),
              ),
              trailing: IconButton(
                onPressed: () => onMobberRemoved?.call(index),
                icon: const Icon(Icons.close_rounded),
              ),
            ),
          );
        }),
      ),
    );
  }
}
