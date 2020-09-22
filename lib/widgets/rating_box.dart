// Flutter imports:
import 'package:flutter/material.dart';

class RatingBox extends StatelessWidget {
  final num rating;
  final EdgeInsets margin;

  RatingBox(this.rating, {this.margin = const EdgeInsets.only(right: 10)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      margin: margin,
      child: Center(
          child: Text(rating?.toStringAsFixed(1) ?? '0',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600))),
      decoration: BoxDecoration(
          color: (rating ?? 0) <= 2
              ? Colors.red
              : (rating < 4 ? Color(0xFFD7A50C) : Colors.green),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
