import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NxFormException implements Exception {
  final String _message;
  NxFormException(this._message);

  @override
  String toString() {
    return _message;
  }
}

abstract class NxFieldStatus<T> {
  T get value;
  set value(T v);
}

class NxFormStatus extends ChangeNotifier {
  final _idToStatus = Map<String, NxFieldStatus>();

  NxFieldStatus<V> getStatusOrNull<V>(String id) {
    return _idToStatus[id];
  }

  NxFieldStatus<V> getStatus<V>(String id) {
    var status = getStatusOrNull<V>(id);

    if (status == null) throw NxFormException('"$id" does not have an status');

    return status;
  }

  T get<T>(String id) {
    return getStatus<T>(id).value;
  }

  void set(String id, dynamic value) {
    var status = getStatus(id);
    status.value = value;
    notifyListeners();
  }

  bool hasStatus(String id) {
    return getStatusOrNull(id) != null;
  }

  void initStatus(String id, NxFieldStatus status) {
    if (hasStatus(id)) {
      throw NxFormException('"$id" already has an status');
    } else {
      _idToStatus[id] = status;
    }
  }

  void notify() {
    notifyListeners();
  }

  void debug() {
    _idToStatus.forEach((k, s) => print('$k - ${s.value}'));
  }
}

class NxFormProvider extends StatelessWidget {
  final NxFormStatus form;
  final Widget child;

  const NxFormProvider({Key key, @required this.form, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => form,
      child: child,
    );
  }
}
