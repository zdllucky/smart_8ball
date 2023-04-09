import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FBuilderCTField extends StatelessWidget {
  const FBuilderCTField(
      {super.key,
      this.validator,
      required this.name,
      this.placeholder,
      this.obscureText = false,
      this.decoration,
      this.minLines,
      this.maxLines});
  final String? Function(String?)? validator;
  final String name;
  final String? placeholder;
  final bool obscureText;
  final BoxDecoration? decoration;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<String?> field) {
        return CupertinoFormRow(
          padding: const EdgeInsets.symmetric(vertical: 6),
          error: field.errorText != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(field.errorText!),
                )
              : null,
          child: decoration != null
              ? CupertinoTextField(
                  placeholder: placeholder,
                  obscureText: obscureText,
                  minLines: minLines,
                  maxLines: maxLines,
                  decoration: decoration,
                  onChanged: (value) => field.didChange(value))
              : CupertinoTextField(
                  placeholder: placeholder,
                  minLines: minLines,
                  maxLines: maxLines,
                  obscureText: obscureText,
                  onChanged: (value) => field.didChange(value)),
        );
      },
    );
  }
}
