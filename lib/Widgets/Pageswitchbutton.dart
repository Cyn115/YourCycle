import 'package:flutter/material.dart';

class Pagebutton extends StatefulWidget {
  const Pagebutton({
    super.key,
    required this.iconbefore,
    required this.pageIndex,
    required this.buttonfunction,
    required this.page,
    required this.iconafter,
  });

  final Icon iconbefore;
  final int pageIndex;
  final Function buttonfunction;
  final int page;
  final Icon iconafter;

  @override
  State<Pagebutton> createState() => _PagebuttonState();
}

class _PagebuttonState extends State<Pagebutton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        enableFeedback: false,
        onPressed: () {
          setState(() {
            widget.buttonfunction();
          });
        },
        icon: widget.pageIndex == widget.page
            ? widget.iconafter
            : widget.iconbefore);
  }
}
