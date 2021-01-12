import 'package:flutter/material.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class NxChooseOption<T> {
  final T id;
  final String name;
  NxChooseOption({this.id, this.name});

  @override
  String toString() {
    return 'NxChooseOption($id)';
  }
}
