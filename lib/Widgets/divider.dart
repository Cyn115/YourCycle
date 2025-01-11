import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
    );
  }
}

class SmallSpace extends StatelessWidget {
  const SmallSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
      width: 10,
    );
  }
}
