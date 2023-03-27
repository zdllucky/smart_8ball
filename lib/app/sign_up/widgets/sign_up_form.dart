import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_8ball/app/shared/functions/showDialog.dart';

import 'f_builder_c_t_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool _canSubmit = false;

  void validateFields() => setState(
      () => _canSubmit = _formKey.currentState?.saveAndValidate() ?? false);

  @override
  Widget build(BuildContext context) {
    void popLocal() {
      context.go('/');
    }

    Future<T?> sDialog<T>(
            {required Text alert,
            Widget? content,
            bool? barrierDismissible,
            List<CupertinoDialogAction>? actions}) =>
        showAlertDialog<T>(context,
            alert: alert,
            content: content,
            barrierDismissible: barrierDismissible,
            actions: actions);

    Future<void> handleSubmit() async {
      setState(() => _isLoading = true);
      if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;

      try {
        final credential = EmailAuthProvider.credential(
            email: _formKey.currentState?.instantValue['email'],
            password: _formKey.currentState?.instantValue['password']);

        await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);

        sDialog(
          alert: const Text("Registration success!"),
          content: Text(
              "We need to ensure this email belongs to you. We've sent you a message to \"${_formKey.currentState?.instantValue['email']}\", please check it."),
        ).whenComplete(popLocal);
      } on FirebaseAuthException catch (e) {
        sDialog(
            alert: const Text("Sorry!"), content: Text(e.message ?? e.code));
      } finally {
        setState(() => _isLoading = false);
      }
    }

    return FormBuilder(
      key: _formKey,
      onChanged: validateFields,
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            FBuilderCTField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email()
              ]),
              name: 'email',
              placeholder: 'Email',
            ),
            FBuilderCTField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(8),
                FormBuilderValidators.maxLength(64),
              ]),
              name: 'password',
              obscureText: true,
              placeholder: 'Password',
            ),
            FBuilderCTField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.equal(
                    _formKey.currentState?.instantValue['password'] ?? '',
                    errorText: 'Passwords do not match.')
              ]),
              name: 'password_confirm',
              obscureText: true,
              placeholder: 'Confirm password',
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
                onPressed: _canSubmit && !_isLoading ? handleSubmit : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FluentIcons.person_add_20_regular),
                    const SizedBox(width: 4),
                    Text(_isLoading ? 'Creating user' : 'Sign up'),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}