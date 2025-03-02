// import 'package:flutter/material.dart';
// import 'package:wallet_parking/resources/color_code.dart';
// import 'package:wallet_parking/resources/custom_style.dart';

// class CustomButtonNew extends StatelessWidget {
//   final String text;
//   final VoidCallback? onPressed;
//   final double? width;
//   final double? height;
//   final Color? borderColor;
//   final Color? backgroundColor;
//   final Widget? suffix;
//   final TextStyle? style;

//   const CustomButtonNew(
//       {super.key,
//       required this.text,
//       this.onPressed,
//       this.width,
//       this.height,
//       this.style,
//       this.borderColor,
//       this.backgroundColor,
//       this.suffix});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width ?? double.infinity,
//       height: height ?? 60,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: backgroundColor ?? ColorCode.orangeButton,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           minimumSize: Size(width ?? double.infinity, height ?? 65),
//           shape: RoundedRectangleBorder(
//               side: BorderSide(
//                   color: borderColor ?? ColorCode.orangeButtonBorder),
//               borderRadius: BorderRadius.circular(15)),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (suffix != null) suffix!,
//             Text(
//               text,
//               style: style ?? CustomStyle.buttonText,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
