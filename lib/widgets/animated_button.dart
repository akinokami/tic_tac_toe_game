// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AnimatedButton extends StatefulWidget {
//   final String text;
//   final VoidCallback onPressed;
//
//   const AnimatedButton({Key? key, required this.text, required this.onPressed})
//       : super(key: key);
//
//   @override
//   _AnimatedButtonState createState() => _AnimatedButtonState();
// }
//
// class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
//         CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
//     );
//
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _controller.reverse();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _controller.forward();
//         widget.onPressed();
//       },
//       child: ScaleTransition(
//         scale: _animation,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('assets/button.webp'),
//                   fit: BoxFit.cover
//               )
//           ),
//           child: Text(
//               widget.text,
//               style: GoogleFonts.gamjaFlower(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               )
//           ),
//         ),
//       ),
//     );
//   }
// }