import 'dart:math';

import 'package:flutter/material.dart';

class HorizontalPicker extends StatefulWidget {
  const HorizontalPicker({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.divisions,
    required this.height,
    required this.onChanged,
    this.initialPosition = 4,
    this.backgroundColor = Colors.white,
    this.showCursor = true,
    this.cursorColor = Colors.black,
    this.activeItemTextColor = Colors.black,
    this.passiveItemsTextColor = Colors.black45,
    this.suffix = "",
  })  : assert(minValue < maxValue),
        super(key: key);

  final double minValue, maxValue;
  final int divisions;
  final double height;
  final Function(double) onChanged;
  final int initialPosition;
  final Color backgroundColor;
  final bool showCursor;
  final Color cursorColor;
  final Color activeItemTextColor;
  final Color passiveItemsTextColor;
  final String suffix;

  @override
  _HorizontalPickerState createState() => _HorizontalPickerState();
}

class _HorizontalPickerState extends State<HorizontalPicker> {
  late FixedExtentScrollController _scrollController;
  late int curItem;
  List<Map<dynamic, dynamic>> valueMap = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i <= widget.divisions; i++) {
      valueMap.add({
        'value': widget.minValue +
            ((widget.maxValue - widget.minValue) / widget.divisions) * i,
        'color': i % 4 == 0
            ? widget.activeItemTextColor
            : widget.passiveItemsTextColor,
        'height': i % 4 == 0 ? 20.0 : 10.0
      });
    }
    setScrollController();
  }

  void setScrollController() {
    int initialItem;
    initialItem = widget.initialPosition;
    _scrollController = FixedExtentScrollController(initialItem: initialItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: widget.height,
      alignment: Alignment.center,
      color: widget.backgroundColor,
      child: Stack(
        children: <Widget>[
          RotatedBox(
            quarterTurns: 3,
            child: ListWheelScrollView(
                controller: _scrollController,
                itemExtent: 30,
                diameterRatio: 5,
                onSelectedItemChanged: (item) {
                  curItem = item;
                  const decimalCount = 1;
                  final fac = pow(10, decimalCount);
                  valueMap[item]['value'] =
                      (valueMap[item]['value']! * fac).round() / fac;
                  widget.onChanged(valueMap[item]['value'] as double);
                  // for (var i = 0; i < valueMap.length; i++) {
                  //   if (i % 4 == 0) {
                  //     valueMap[item]["color"] = widget.activeItemTextColor;
                  //     valueMap[item]["height"] = 20.0;
                  //   } else {
                  //     valueMap[i]["color"] = widget.passiveItemsTextColor;
                  //     valueMap[item]["height"] = 10.0;
                  //   }
                  // }
                  setState(() {});
                },
                children: valueMap.map((Map curValue) {
                  return ItemWidget(
                    curValue,
                    widget.backgroundColor,
                    widget.suffix,
                  );
                }).toList()),
          ),
          Visibility(
            visible: widget.showCursor,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RotatedBox(
                      quarterTurns: 2,
                      child: CustomPaint(
                          size: const Size(10, 10), painter: DrawTriangle())),
                  CustomPaint(size: const Size(2, 70), painter: DrawLine()),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(10),
                  //     ),
                  //     color: widget.cursorColor.withOpacity(0.3),
                  //   ),
                  //   width: 3,
                  // ),
                  RotatedBox(
                      quarterTurns: 0,
                      child: CustomPaint(
                          size: const Size(10, 10), painter: DrawTriangle())),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemWidget extends StatefulWidget {
  final Map<dynamic, dynamic> curItem;
  final Color backgroundColor;
  final String suffix;

  const ItemWidget(
    this.curItem,
    this.backgroundColor,
    this.suffix, {
    Key? key,
  }) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 1,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: RotatedBox(
          quarterTurns: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: widget.curItem['height'] as double,
                width: 0.6,
                color: widget.curItem['color'] as Color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(size.width / 2, 0);
    final p2 = Offset(size.width / 2, size.height);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = size.width;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
