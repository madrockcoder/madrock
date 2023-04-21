import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CustomTabIndicator extends Decoration {
  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(this, onChanged!);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    double indicatorHeight = 25;
    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.

    final Rect rect = Offset(offset.dx,
            (configuration.size!.height / 2) - (indicatorHeight / 2)) &
        Size(configuration.size!.width, indicatorHeight);
    final Paint paint = Paint();
    paint.color = AppColor.kSecondaryColor.withOpacity(.3);
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10.0)), paint);
  }
}

class WalletTabIndicator extends Decoration {
  @override
  _WalletCustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _WalletCustomPainter(this, onChanged!);
  }
}

class _WalletCustomPainter extends BoxPainter {
  final WalletTabIndicator decoration;

  _WalletCustomPainter(this.decoration, VoidCallback onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    double indicatorHeight = 30;
    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.

    final Rect rect = Offset(offset.dx,
            (configuration.size!.height / 2) - (indicatorHeight / 2)) &
        Size(configuration.size!.width, indicatorHeight);
    final Paint paint = Paint();
    paint.color = AppColor.kSecondaryColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(34.0)), paint);
  }
}
