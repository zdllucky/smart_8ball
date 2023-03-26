import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool _canSubmit = false;

  @override
  Widget build(BuildContext context) {
    Future<void> handleSubmit() async {
      setState(() => _isLoading = true);
      if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _formKey.currentState?.instantValue['email'],
              password: _formKey.currentState?.instantValue['password']);

      print(userCredential);

      setState(() => _isLoading = true);
    }

    return FormBuilder(
      key: _formKey,
      onChanged: () => setState(
          () => _canSubmit = _formKey.currentState?.saveAndValidate() ?? false),
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            FormBuilderField(
              name: "email",
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email()
              ]),
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
                  child: CupertinoTextField(
                      placeholder: "Email",
                      onChanged: (value) => field.didChange(value)),
                );
              },
            ),
            FormBuilderField(
              name: "password",
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(8),
                FormBuilderValidators.maxLength(64),
              ]),
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
                  child: CupertinoTextField(
                      placeholder: "Password",
                      obscureText: true,
                      onChanged: (value) => field.didChange(value)),
                );
              },
            ),
            FormBuilderField(
              name: "password_confirm",
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.equal(
                    _formKey.currentState?.instantValue['password'] ?? '',
                    errorText: 'Passwords do not match.')
              ]),
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
                  child: CupertinoTextField(
                      placeholder: "Confirm password",
                      obscureText: true,
                      onChanged: (value) => field.didChange(value)),
                );
              },
            ),
            // TODO: Offer term of use to user
            const Spacer(),
            FormBuilderField<bool>(
              name: 'terms',
              initialValue: false,
              onChanged: (val) => debugPrint(val.toString()),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.equal(true)
              ]),
              builder: (FormFieldState field) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CupertinoSwitch(
                      value: field.value,
                      onChanged: (value) => field.didChange(value),
                    ),
                    const Expanded(
                      child: Text(
                        'I have read will accept terms and conditions when they arrive here as link.\n',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                        ),
                        softWrap: true,
                      ),
                    )
                  ],
                );
              },
            ),
            CupertinoButton.filled(
                borderRadius: BorderRadius.circular(100),
                onPressed: _canSubmit ? handleSubmit : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(FluentIcons.person_add_20_regular),
                    SizedBox(width: 4),
                    Text('Sign up'),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
