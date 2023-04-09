import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FBuilderCTField extends StatefulWidget {
  const FBuilderCTField({
    super.key,
    this.validator,
    required this.name,
    this.placeholder,
    this.obscureText = false,
    this.decoration,
    this.minLines,
    this.maxLines,
    this.autofocus = false,
    this.unFocusOnSwipe = false,
  });
  final String? Function(String?)? validator;
  final String name;
  final String? placeholder;
  final bool obscureText;
  final BoxDecoration? decoration;
  final int? minLines;
  final int? maxLines;
  final bool autofocus;
  final bool unFocusOnSwipe;

  @override
  State<FBuilderCTField> createState() => _FBuilderCTFieldState();
}

class _FBuilderCTFieldState extends State<FBuilderCTField> {
  late FocusNode _focusNode;
  bool _isFocusedInitially = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.autofocus && !_isFocusedInitially) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_focusNode);
        setState(() => _isFocusedInitially = true);
      });
    }

    return Listener(
      onPointerMove: widget.unFocusOnSwipe
          ? (e) {
              if (e.down) FocusScope.of(context).unfocus();
            }
          : null,
      child: FormBuilderField(
        name: widget.name,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (FormFieldState<String?> field) => CupertinoFormRow(
          padding: const EdgeInsets.symmetric(vertical: 6),
          error: field.errorText != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(field.errorText!),
                )
              : null,
          child: widget.decoration != null
              ? CupertinoTextField(
                  focusNode: _focusNode,
                  placeholder: widget.placeholder,
                  obscureText: widget.obscureText,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  decoration: widget.decoration,
                  onChanged: (value) => field.didChange(value))
              : CupertinoTextField(
                  focusNode: _focusNode,
                  placeholder: widget.placeholder,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  obscureText: widget.obscureText,
                  onChanged: (value) => field.didChange(value)),
        ),
      ),
    );
  }
}
