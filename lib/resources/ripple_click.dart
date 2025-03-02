import 'package:flutter/material.dart';

class RippleClick extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  const RippleClick({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color(0xFF919BB3),
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
