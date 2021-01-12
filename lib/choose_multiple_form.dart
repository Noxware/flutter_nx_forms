import 'package:flutter/material.dart';
import 'common.dart';
import 'package:provider/provider.dart';
import 'base.dart';
import 'package:smart_select/smart_select.dart';

class NxChooseMultipleFieldStatus extends NxFieldStatus<Set<NxChooseOption>> {
  var value = Set<NxChooseOption>();
}

class NxChooseMultipleField extends StatefulWidget {
  final String label;
  final String id;
  final List<NxChooseOption> optionList;
  final String dialogTitle;

  NxChooseMultipleField({
    Key key,
    this.label,
    @required this.id,
    @required this.optionList,
    @required this.dialogTitle,
  }) : super(key: key);

  @override
  _NxChooseMultipleFieldState createState() => _NxChooseMultipleFieldState();
}

class _NxChooseMultipleFieldState extends State<NxChooseMultipleField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<NxFormStatus>(
      builder: (context, form, child) {
        if (!form.hasStatus(widget.id)) {
          form.initStatus(widget.id, NxChooseMultipleFieldStatus());
        }

        final NxChooseMultipleFieldStatus status = form.getStatus(widget.id);
        Set<NxChooseOption> value = status.value;
        controller.text = widget.optionList
            .where((o) => value.contains(o))
            .map((o) => o.name)
            .join(', ');

        return SmartSelect<NxChooseOption>.multiple(
          title: widget.dialogTitle,
          value: value.toList(),
          modalType: S2ModalType.bottomSheet,
          onChange: (state) {
            status.value = state.value.toSet();
            form.notify();
          },
          choiceItems: widget.optionList
              .map(
                (o) => S2Choice(value: o, title: o.name),
              )
              .toList(),
          tileBuilder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  readOnly: true,
                  showCursor: false,
                  onTap: () => state.showModal(),
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
      },
    );
  }
}
