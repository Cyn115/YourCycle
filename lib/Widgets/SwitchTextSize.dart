import 'package:flutter/material.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/data/TextSize.dart';
import 'package:new2/Widgets/Switchbutton.dart';

class SwitchTextSize extends StatefulWidget {
  final ValueChanged<Sizes>? onSizeChange; // Made optional

  const SwitchTextSize({super.key, this.onSizeChange});

  @override
  _SwitchTextSizeState createState() => _SwitchTextSizeState();
}

class _SwitchTextSizeState extends State<SwitchTextSize> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(Sizes.values.length, (index) {
      return Sizes.values[index] == currentSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ToggleButtons(
            color: colors.contrastingcolor,
            fillColor: colors.secondarycolor,
            borderRadius: BorderRadius.circular(15),
            constraints: BoxConstraints(
              minWidth: 0.275 * screenWidth,
              minHeight: 50,
            ),
            isSelected: isSelected,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
                currentSize = Sizes.values[index];
                widget.onSizeChange?.call(currentSize);
              });
            },
            children: const <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.text_fields, size: 15),
                  Text(
                    'Small',
                    style: TextStyle(fontSize: 15, fontFamily: 'Regular'),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.text_fields, size: 20),
                  Text(
                    'Medium',
                    style: TextStyle(fontSize: 15, fontFamily: 'Regular'),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.text_fields, size: 25),
                  Text(
                    'Large',
                    style: TextStyle(fontSize: 15, fontFamily: 'Regular'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Sizes currentSize = Sizes.medium;
