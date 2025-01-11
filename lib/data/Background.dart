import 'package:flutter/material.dart';

enum Modes { dark, light }

class Mode {
  final Color primarycolor; 
  final Color secondarycolor; 
  final Color tertiarycolor;
  final Color contrastingcolor;

  const Mode(this.primarycolor, this.secondarycolor, this.tertiarycolor,
      this.contrastingcolor);
}

const modes = {
  Modes.dark: Mode(
    Color.fromARGB(255, 10, 9, 19),
    Color.fromARGB(255, 20, 19, 55),
    Color.fromARGB(255, 19, 17, 34),
    Colors.white,
  ),
  Modes.light: Mode(
    Color.fromARGB(255, 255, 228, 225),
    Color.fromARGB(255, 223, 125, 166),
    Color.fromARGB(255, 247, 178, 207),
    Colors.black,
  ),
};
