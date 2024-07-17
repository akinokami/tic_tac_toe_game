import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

class CustomOutlineGradientButton extends StatelessWidget {
  const CustomOutlineGradientButton({super.key, required this.data, required this.onPressed,  this.buttonStyle, required this.horizon, required this.vertical, required this.padding});
final Widget data;
final VoidCallback onPressed;
final TextStyle? buttonStyle;
final double horizon ;
final double vertical ;
final double padding;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: padding),
      child: OutlineGradientButton(
        onTap:  onPressed,
        child: Center(child: data),
        gradient: LinearGradient(
          colors: List.generate(360, _generator),
        ),
        strokeWidth: 2,
        padding:  EdgeInsets.symmetric(horizontal: horizon, vertical: vertical),
        radius: const Radius.circular(8),
      ),
    );
  }
  static Color _generator(int h) {
    return HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5).toColor();
  }
}
