import 'package:flutter/material.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/Widgets/Switchbutton.dart';
import 'package:new2/Widgets/Text.dart';
import 'package:new2/data/TextSize.dart';

class InputButton extends StatefulWidget {
  const InputButton({
    super.key,
    required this.label,
    required this.iconsize,
    required this.iconcolor,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final double iconsize;
  final Color iconcolor;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<InputButton> createState() => _InputButtonState();
}

class _InputButtonState extends State<InputButton> {
  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;
    final sizesbt = sizes[Sizes.medium]!;

    return SizedBox(
      height: 80,
      width: 110,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          backgroundColor:
              widget.selected ? colors.secondarycolor : colors.primarycolor,
        ),
        onPressed: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.icon, size: widget.iconsize, color: widget.iconcolor),
            SmallBodyText(smallbodytext: widget.label, textsize: sizesbt),
          ],
        ),
      ),
    );
  }
}

class TimelineButton extends StatefulWidget {
  const TimelineButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<TimelineButton> createState() => _TimelineButtonState();
}

class _TimelineButtonState extends State<TimelineButton> {
  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;
    final sizesbt = sizes[Sizes.medium]!;

    return SizedBox(
      height: 50,
      width: 110,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          backgroundColor:
              widget.selected ? colors.secondarycolor : colors.primarycolor,
        ),
        onPressed: widget.onTap,
        child: Center(
            child:
                ProgressText(smallbodytext: widget.label, textsize: sizesbt)),
      ),
    );
  }
}
