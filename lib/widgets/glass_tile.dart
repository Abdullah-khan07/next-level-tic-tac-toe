import 'dart:ui';
import 'package:flutter/material.dart';

class GlassTile extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const GlassTile({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}