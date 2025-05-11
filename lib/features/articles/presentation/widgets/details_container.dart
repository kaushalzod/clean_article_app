import 'package:flutter/material.dart';

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({
    super.key,
    required this.title,
    required this.desc,
    this.descTextStyle,
  });
  final String title;
  final String desc;
  final TextStyle? descTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: Colors.grey[300],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: Colors.grey[300],
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            desc,
            style:
                descTextStyle ??
                TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
