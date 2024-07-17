import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

class CustomOutlineGradientCircleButton extends StatelessWidget {
  const CustomOutlineGradientCircleButton({super.key, required this.iconData, required this.onPressed});
  final IconData iconData;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return  OutlineGradientButton(
      onTap:  onPressed,
      child:  SizedBox(
          width: 45,
          height: 45,
          child: Center(
            child: Icon(
              iconData,
              color: Colors.white,
              size: 30,
            ),
          )),
      gradient: LinearGradient(
        colors: List.generate(360, _generator),
      ),
      strokeWidth: 4,
      padding: EdgeInsets.zero,
      radius: const Radius.circular(26),
    );
  }
  static Color _generator(int h) {
    return HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5).toColor();
  }
}
