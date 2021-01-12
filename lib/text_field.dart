import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'form_base.dart';

class NxTextFieldStatus extends NxFieldStatus<String> {
  String value;

  NxTextFieldStatus() {
    value = '';
  }
}

class NxTextField extends StatefulWidget {
  final String label;
  final String id;
  final bool readOnly;
  final bool showCursor;
  final FocusNode focusNode;
  final void Function() onTap;

  NxTextField({
    Key key,
    @required this.id,
    this.label,
    this.onTap,
    this.readOnly = false,
    this.showCursor = true,
    this.focusNode,
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

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              readOnly: widget.readOnly,
              showCursor: widget.showCursor,
              onTap: widget.onTap,
              focusNode: widget.focusNode,
              controller: controller,
              onChanged: (v) => status.value = v,
              decoration: InputDecoration(
                labelText: widget.label,
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
