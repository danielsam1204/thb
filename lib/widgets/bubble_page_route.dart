import 'dart:math';

import 'package:flutter/material.dart';

class BubblePageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  final Offset position;
  final Duration duration;

  BubblePageRoute({
    required this.builder,
    required this.position,
    this.duration = const Duration(milliseconds: 800),
  }) : super(
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         pageBuilder: (context, animation, secondaryAnimation) =>
             builder(context),
       );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final size = MediaQuery.of(context).size;
        final maxRadius = sqrt(
          size.width * size.width + size.height * size.height,
        );

        final radius = Tween<double>(begin: 0.0, end: maxRadius).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
            reverseCurve: Curves.easeInOutCubic,
          ),
        );

        return Stack(
          children: [
            ClipPath(
              clipper: CircleRevealClipper(
                center: position,
                radius: radius.value,
              ),
              child: child,
            ),
          ],
        );
      },
    );
  }
}

class CircleRevealClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  CircleRevealClipper({required this.center, required this.radius});

  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) =>
      radius != oldClipper.radius;
}
