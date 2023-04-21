import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../util/constants.dart';
import '../../util/enums.dart';

class AnimatedColumnWidget extends StatelessWidget {
  final List<Widget> children;
  final AnimateType animateType;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final int duration;

  const AnimatedColumnWidget(
      {Key? key,
      required this.children,
      this.animateType = AnimateType.slideLeft,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max,
      this.duration = 400,
      this.crossAxisAlignment = CrossAxisAlignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (animateType == AnimateType.slideUp) {
      return AnimationLimiter(
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: AnimationConfiguration.toStaggeredList(
            duration: Duration(milliseconds: duration),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: fiftyDp,
              child: SlideAnimation(
                child: widget,
              ),
            ),
            children: children,
          ),
        ),
      );
    } else {
      return AnimationLimiter(
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: AnimationConfiguration.toStaggeredList(
            duration: Duration(milliseconds: duration),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: fiftyDp,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: children,
          ),
        ),
      );
    }
  }
}
