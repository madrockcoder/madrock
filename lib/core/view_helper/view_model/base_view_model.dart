import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;
  Object? errorType;
  void setBusy({required bool value}) {
    _busy = value;
    notifyListeners();
  }

  void setError(Object error) {
    errorType = error;
  }
}

enum BaseModelState { loading, success, error }
