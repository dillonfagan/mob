import 'package:flutter/material.dart';
import 'package:mob_app/pages/setup/setup.dart';
import 'package:mob_app/providers/mob.dart';

class AppBarFactory {
  static AppBar build({
    required BuildContext context,
    required MobProvider mob,
  }) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          mob.reset();
          Navigator.of(context).pop(MaterialPageRoute(
            builder: (_) => const SetupPage(),
          ));
        },
        icon: const Icon(Icons.close_rounded),
      ),
    );
  }
}
