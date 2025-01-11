import 'package:flutter/material.dart';
import 'package:new2/data/Background.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light1 = currentMode == Modes.dark;

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.dark_mode);
      }
      return const Icon(Icons.light_mode);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Switch(
      thumbIcon: thumbIcon,
      value: light1,
      onChanged: (bool value) {
        setState(() {
          light1 = value;
          currentMode = light1 ? Modes.dark : Modes.light;
        });
      },
    );
  }
}

Modes currentMode = Modes.light;
