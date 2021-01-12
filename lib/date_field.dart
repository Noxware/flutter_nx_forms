import 'package:flutter/material.dart';
import 'common.dart';
import 'package:provider/provider.dart';
import 'base.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NxDateFieldStatus extends NxFieldStatus<DateTime> {
  DateTime value;

  NxDateFieldStatus() {
    //value = '';
  }
}

class NxDateField extends StatefulWidget {
  final String label;
  final String id;
  final DateTime minDate;
  final DateTime maxDate;

  NxDateField({
    Key key,
    @required this.id,
    this.label,
    this.minDate,
    this.maxDate,
  }) : super(key: key);

  @override
  _NxDateFieldState createState() => _NxDateFieldState();
}

class _NxDateFieldState extends State<NxDateField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<NxFormStatus>(
      builder: (context, form, child) {
        if (!form.hasStatus(widget.id)) {
          form.initStatus(widget.id, NxDateFieldStatus());
        }

        final NxDateFieldStatus status = form.getStatus(widget.id);
        DateTime value = status.value;
        controller.text =
            value != null ? '${value.day}/${value.month}/${value.year}' : '';

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              readOnly: true,
              showCursor: false,
              onTap: () => showPicker(
                  context: context,
                  form: form,
                  status: status,
                  minDate: widget.minDate,
                  maxDate: widget.maxDate),
              focusNode: AlwaysDisabledFocusNode(),
              controller: controller,
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

  showPicker({
    BuildContext context,
    NxDateFieldStatus status,
    NxFormStatus form,
    DateTime minDate,
    DateTime maxDate,
  }) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: false,
      minTime: minDate != null ? minDate : DateTime(1800, 1, 1),
      maxTime: maxDate != null ? maxDate : DateTime(2200, 1, 1),
      onChanged: (date) {
        status.value = date;
        form.notify();
      },
      onConfirm: (date) {},
      currentTime: DateTime.now(),
    );
  }
}
