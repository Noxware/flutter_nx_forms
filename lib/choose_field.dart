import 'package:flutter/material.dart';
import 'common.dart';
import 'package:provider/provider.dart';
import 'base.dart';
import 'package:smart_select/smart_select.dart';

class NxChooseFieldStatus extends NxFieldStatus<NxChooseOption> {
  NxChooseOption value;
}

class NxChooseField extends StatefulWidget {
  final String label;
  final String id;
  final List<NxChooseOption> optionList;
  final String dialogTitle;

  NxChooseField({
    Key key,
    this.label,
    @required this.id,
    @required this.optionList,
    @required this.dialogTitle,
  }) : super(key: key);

  @override
  _NxChooseFieldState createState() => _NxChooseFieldState();
}

class _NxChooseFieldState extends State<NxChooseField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<NxFormStatus>(
      builder: (context, form, child) {
        if (!form.hasStatus(widget.id)) {
          form.initStatus(widget.id, NxChooseFieldStatus());
        }

        final NxChooseFieldStatus status = form.getStatus(widget.id);
        NxChooseOption value = status.value;
        controller.text = value != null ? value.name : '';

        return SmartSelect<NxChooseOption>.single(
          title: widget.dialogTitle,
          value: value,
          modalType: S2ModalType.bottomSheet,
          onChange: (state) {
            status.value = state.value;
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
