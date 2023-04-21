import 'package:flutter/cupertino.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  /// Call back to trigger once view is built
  final Function(T)? onModelReady;

  // ignore: sort_constructors_first, use_key_in_widget_constructors
  const BaseView({
    required this.builder,
    this.onModelReady,
  });
  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = sl<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      // ignore: prefer_null_aware_method_calls
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      // create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}
