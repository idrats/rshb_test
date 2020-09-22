// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:dotted_line/dotted_line.dart';

class DetailsTile extends StatelessWidget {
  final String title;
  final String value;
  DetailsTile(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        height: 32,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("$title ", style: TextStyle(color: Colors.grey)),
            Expanded(
                child: DottedLine(
                    dashColor: Colors.grey, dashLength: 1, dashGapLength: 1)),
            Text(
              ' $value',
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ));
  }
}
