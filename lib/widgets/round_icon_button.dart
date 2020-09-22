// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final double size;
  final bool isActive;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color activeBackgroundColor;
  final Color inactiveBackgroundColor;
  RoundIconButton(
      {@required this.iconData,
      @required this.onPressed,
      this.size = 40,
      this.isActive = false,
      this.activeIconColor = Colors.white,
      this.inactiveIconColor = Colors.black,
      this.activeBackgroundColor = Colors.green,
      this.inactiveBackgroundColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: isActive ? activeBackgroundColor : inactiveBackgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[400])),
        child: IconButton(
          iconSize: 20,
          color: isActive ? activeIconColor : inactiveIconColor,
          icon: Icon(iconData),
          onPressed: onPressed,
        ));
  }
}
