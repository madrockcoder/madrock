import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CustomDropDown<T> extends StatefulWidget {
  final List<CustDropdownMenuItem> items;
  final Function onChanged;
  final String hintText;
  final double maxListHeight;
  final int defaultSelectedIndex;
  final bool enabled;
  final BoxDecoration? decoration;
  final TextStyle? selectedValueTextStyle;
  final Widget suffixIcon;
  final Widget? itemBuilder;
  final Color dropdownBackgroundColor;

  const CustomDropDown(
      {required this.items,
      required this.onChanged,
      this.hintText = "",
      this.maxListHeight = 200,
      this.defaultSelectedIndex = -1,
      Key? key,
      this.enabled = true,
      this.decoration,
      this.selectedValueTextStyle,
      this.suffixIcon = const Icon(
        Icons.keyboard_arrow_down_outlined,
        color: AppColor.kSecondaryColor,
        size: 8,
      ),
      required this.dropdownBackgroundColor,
      this.itemBuilder})
      : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> with WidgetsBindingObserver {
  bool _isOpen = false, _isAnyItemSelected = false, _isReverse = false;
  late OverlayEntry _overlayEntry;
  late RenderBox? _renderBox;
  Widget? _itemSelected;
  late Offset dropDownOffset;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          dropDownOffset = getOffset();
        });
      }
      if (widget.defaultSelectedIndex > -1) {
        if (widget.defaultSelectedIndex < widget.items.length) {
          if (mounted) {
            setState(() {
              _isAnyItemSelected = true;
              _itemSelected = widget.items[widget.defaultSelectedIndex];
              widget.onChanged(widget.items[widget.defaultSelectedIndex].value);
            });
          }
        }
      }
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void _addOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = true;
      });
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayEntry);
  }

  void _removeOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
      _overlayEntry.remove();
    }
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    _renderBox = context.findRenderObject() as RenderBox?;

    var size = _renderBox!.size;

    dropDownOffset = getOffset();

    return OverlayEntry(
        maintainState: false,
        builder: (context) => Align(
              alignment: Alignment.center,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: dropDownOffset,
                child: SizedBox(
                  height: widget.maxListHeight,
                  width: size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: _isReverse ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          constraints: BoxConstraints(maxHeight: widget.maxListHeight - 10, maxWidth: size.width),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            child: Material(
                              elevation: 0,
                              shadowColor: Colors.black54,
                              child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                children: widget.items
                                    .map((item) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            color: widget.dropdownBackgroundColor,
                                            child: GestureDetector(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: item.child,
                                              ),
                                              onTap: () {
                                                if (mounted) {
                                                  setState(() {
                                                    _isAnyItemSelected = true;
                                                    _itemSelected = item.child;
                                                    _removeOverlay();
                                                    widget.onChanged(item.value);
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Offset getOffset() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    double y = renderBox!.localToGlobal(Offset.zero).dy;
    double spaceAvailable = _getAvailableSpace(y + renderBox.size.height);
    if (spaceAvailable > widget.maxListHeight) {
      _isReverse = false;
      return Offset(0, renderBox.size.height);
    } else {
      _isReverse = true;
      return Offset(0, renderBox.size.height - (widget.maxListHeight + renderBox.size.height));
    }
  }

  double _getAvailableSpace(double offsetY) {
    double safePaddingTop = MediaQuery.of(context).padding.top;
    double safePaddingBottom = MediaQuery.of(context).padding.bottom;

    double screenHeight = MediaQuery.of(context).size.height - safePaddingBottom - safePaddingTop;

    return screenHeight - offsetY;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.enabled
            ? () {
                _isOpen ? _removeOverlay() : _addOverlay();
              }
            : null,
        child: Container(
          decoration: widget.decoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: <Widget>[
                widget.itemBuilder != null
                    ? widget.itemBuilder!
                    : _isAnyItemSelected
                        ? _itemSelected!
                        : Text(
                            widget.hintText,
                            style: widget.selectedValueTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                const SizedBox(
                  width: 2,
                ),
                widget.suffixIcon
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustDropdownMenuItem<T> extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const CustDropdownMenuItem(this.text,
      {Key? key, this.textStyle = const TextStyle(color: AppColor.kSecondaryColor, fontSize: 10)})
      : super(key: key);

  Text get child => Text(
        text,
        style: textStyle,
      );

  get value => text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: child.style,
    );
  }
}
