import 'package:flutter/material.dart';

class PostText extends StatelessWidget {
  final String txt;
  final AlignmentGeometry alignment;
  const PostText({super.key, required this.txt, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(
        txt,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
