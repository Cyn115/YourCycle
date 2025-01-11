import 'package:flutter/material.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/Widgets/Switchbutton.dart';
import 'package:new2/data/TextSize.dart';

class AppTitle extends StatefulWidget {
  const AppTitle(
      {super.key, required this.apptitletext, required this.textsize});

  final String apptitletext;
  final Size textsize;

  @override
  State<AppTitle> createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle> {
  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;
    return Text(
      widget.apptitletext,
      style: TextStyle(
        color: colors.contrastingcolor,
        fontSize: widget.textsize.titlesize.toDouble(),
        fontWeight: FontWeight.w600,
        fontFamily: 'Calligraphy',
      ),
    );
  }
}

//Heading
class Heading extends StatefulWidget {
  const Heading({super.key, required this.headingtext, required this.textsize});

  final String headingtext;
  final Size textsize;

  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;
    return Text(
      widget.headingtext,
      style: TextStyle(
        color: colors.contrastingcolor,
        fontSize: widget.textsize.headingsize.toDouble(),
        fontWeight: FontWeight.w600,
        fontFamily: 'Bold',
      ),
    );
  }
}

//SubHeading
class SubHeading extends StatefulWidget {
  const SubHeading(
      {super.key, required this.subheadingtext, required this.textsize});

  final String subheadingtext;
  final Size textsize;

  @override
  State<SubHeading> createState() => _SubHeadingState();
}

class _SubHeadingState extends State<SubHeading> {
  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;
    return Text(
      widget.subheadingtext,
      style: TextStyle(
        color: colors.contrastingcolor,
        fontSize: widget.textsize.subheadingsize.toDouble(),
        fontWeight: FontWeight.w600,
        fontFamily: 'Bold',
      ),
    );
  }
}

//SmallBodyText
class SmallBodyText extends StatefulWidget {
  const SmallBodyText(
      {super.key, required this.smallbodytext, required this.textsize});

  final String smallbodytext;
  final Size textsize;

  @override
  State<SmallBodyText> createState() => _SmallBodyTextState();
}

class _SmallBodyTextState extends State<SmallBodyText> {
  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;
    return Text(
      widget.smallbodytext,
      style: TextStyle(
        color: colors.contrastingcolor,
        fontSize: widget.textsize.smallbodytextsize.toDouble(),
        fontWeight: FontWeight.w600,
        fontFamily: 'Regular',
      ),
    );
  }
}

//BigBodyText
class BigBodyText extends StatefulWidget {
  const BigBodyText(
      {super.key, required this.bigbodytext, required this.textsize});

  final String bigbodytext;
  final Size textsize;

  @override
  State<BigBodyText> createState() => _BigBodyTextState();
}

class _BigBodyTextState extends State<BigBodyText> {
  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;
    return Text(widget.bigbodytext,
        style: TextStyle(
          color: colors.contrastingcolor,
          fontSize: widget.textsize.bigbodytextsize.toDouble(),
          fontWeight: FontWeight.w600,
          fontFamily: 'Regular',
        ),
        textAlign: TextAlign.left);
  }
}

class ProgressText extends StatefulWidget {
  const ProgressText(
      {super.key, required this.smallbodytext, required this.textsize});

  final String smallbodytext;
  final Size textsize;

  @override
  State<ProgressText> createState() => _ProgressTextState();
}

class _ProgressTextState extends State<ProgressText> {
  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;
    return Text(
      widget.smallbodytext,
      style: TextStyle(
        color: colors.contrastingcolor,
        fontSize: widget.textsize.smallbodytextsize.toDouble(),
        fontWeight: FontWeight.w600,
        fontFamily: 'Regular',
      ),
      textAlign: TextAlign.center,
    );
  }
}