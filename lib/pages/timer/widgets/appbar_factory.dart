import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mob_app/pages/setup/setup.dart';
import 'package:mob_app/pages/timer/widgets/end_mob_alert.dart';
import 'package:mob_app/providers/mob.dart';

class AppBarFactory {
  static AppBar build({required BuildContext context}) {
    final mob = Provider.of<MobProvider>(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          mob.reset();
          showDialog(
            context: context,
            builder: (context) {
              return EndMobAlertDialog(
                onConfirm: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(MaterialPageRoute(
                    builder: (_) => const SetupPage(),
                  ));
                },
              );
            },
          );
        },
        icon: const Icon(Icons.close_rounded),
      ),
    );
  }
}
