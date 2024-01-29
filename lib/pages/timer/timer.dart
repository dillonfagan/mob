import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mob_app/providers/driver_provider.dart';
import 'package:mob_app/providers/mob_controller_provider.dart';
import 'package:mob_app/providers/mob_state_provider.dart';
import 'package:mob_app/providers/timer_provider.dart';

import 'widgets/appbar_factory.dart';
import 'widgets/break_button.dart';
import 'widgets/display.dart';
import 'widgets/next_button.dart';

class TimerPage extends ConsumerStatefulWidget {
  const TimerPage({super.key});

  @override
  ConsumerState<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends ConsumerState<TimerPage> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.read(mobControllerProvider);
    final mobState = ref.watch(mobStateProvider);
    final driver = ref.watch(driverProvider);
    final navigator = ref.watch(navigatorProvider);

    String title = mobState == MobState.onBreak ? 'Break' : driver.name;

    return Scaffold(
      appBar: AppBarFactory.build(
        context: context,
        controller: controller,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimerDisplay(seconds: ref.watch(timerProvider)),
            const SizedBox(height: 16),
            if (mobState == MobState.initialLoad)
              StartButton(
                onPressed: () => controller.start(),
              ),
            if (mobState == MobState.mobbing || mobState == MobState.onBreak)
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36),
              ),
            if (mobState == MobState.timeToBreak)
              BreakButton(
                onPressed: () => controller.startBreak(),
              ),
            if (mobState == MobState.waiting)
              NextButton(
                labelText: navigator.name,
                onPressed: () => controller.startNextTurn(),
              ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: ref.watch(newTimerProvider).isActive,
        child: FloatingActionButton(
          onPressed: () => controller.endTurn(),
          backgroundColor: Colors.amber,
          child: const Icon(
            Icons.skip_next_rounded,
            size: 36,
          ),
        ),
      ),
    );
  }
}
