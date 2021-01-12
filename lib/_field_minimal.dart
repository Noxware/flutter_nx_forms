import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base.dart';

class NxTextFieldStatus extends NxFieldStatus<String> {
  String value;

  NxTextFieldStatus() {
    value = '';
  }
}

class NxTextField extends StatefulWidget {
  final String id;

  NxTextField({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  _NxTextFieldState createState() => _NxTextFieldState();
}

class _NxTextFieldState extends State<NxTextField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<NxFormStatus>(
      builder: (context, form, child) {
        if (!form.hasStatus(widget.id)) {
          form.initStatus(widget.id, NxTextFieldStatus());
        }

        final NxTextFieldStatus status = form.getStatus(widget.id);
        controller.text = status.value;

        return Text('Your component goes here');
      },
    );
  }
}
