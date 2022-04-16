import 'package:flutter/material.dart';

class AnimatedOpacityWidget extends StatelessWidget {
  final Widget child;

  const AnimatedOpacityWidget(this.child);
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: child,
      ),
      duration: Duration(milliseconds: 200),
      child: child,
    );
  }
}
