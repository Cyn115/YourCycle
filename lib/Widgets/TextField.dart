import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.obscuretext,
    required this.icon,
  });

  final IconData icon;
  final TextEditingController controller;
  final String hinttext;
  final bool obscuretext;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.8,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 228, 225),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: Colors.black,
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            height: 26,
            width: 2,
            color: Colors.grey,
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: widget.hinttext,
                hintStyle: const TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 17,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: widget.obscuretext,
              controller: widget.controller,
            ),
          ),
        ],
      ),
    );
  }
}
