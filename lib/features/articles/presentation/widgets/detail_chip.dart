import 'package:flutter/material.dart';

class DetailChip extends StatelessWidget {
  const DetailChip({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(text, style: TextStyle(fontSize: 14, color: Colors.black)),
    );
  }
}
