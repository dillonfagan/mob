import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/models/mobber.dart';
import 'package:mob_app/providers/mob.dart';

void main() {
  test('MobProvider.turnLength', () {
    final mob = MobProvider();
    expect(mob.turnLength, equals(0));

    mob.mobbers.add(Mobber(name: 'Bart'));
    expect(mob.turnLength, equals(900));

    mob.mobbers.add(Mobber(name: 'Lisa'));
    expect(mob.turnLength, equals(480));

    mob.mobbers.add(Mobber(name: 'Maggie'));
    mob.mobbers.add(Mobber(name: 'Homer'));
    expect(mob.turnLength, equals(420));

    mob.mobbers.add(Mobber(name: 'Marge'));
    expect(mob.turnLength, equals(420));
  });
}
