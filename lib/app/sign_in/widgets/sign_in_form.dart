import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../infrastructure/di/injections.dart';
import '../../alert/__.dart';
import '../../app_root/__.dart';
import '../../auth/__.dart';
import '../../shared/widgets/rounded_c_button.dart';
import '../../sign_up/widgets/f_builder_c_t_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool _canSubmit = false;

  void validateFields() => setState(
      () => _canSubmit = _formKey.currentState?.saveAndValidate() ?? false);

  @override
  void dispose() {
    if (get<AuthCubit>().state == null) {
      get<AuthService>().provider.signInAnonymously();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void goProfileRoute() {
      context.go('/');
    }

    Future<void> handleSubmit() async {
      setState(() => _isLoading = true);
      if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;

      try {
        final credential = EmailAuthProvider.credential(
            email: _formKey.currentState?.instantValue['email'],
            password: _formKey.currentState?.instantValue['password']);

        await get<AuthService>().provider.currentUser?.delete();
        await get<AuthService>().provider.signInWithCredential(credential);

        goProfileRoute();
      } on FirebaseAuthException catch (e) {
        get<AlertCubit>().showAlertDialog(BasicAlert(
            alert: const Text("Sorry!"), content: Text(e.message ?? e.code)));
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
            const Spacer(),

            // TODO: Remove this in production
            if (kDebugMode)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: RoundedCButton(
                    filled: true,
                    text: 'Drop app',
                    onPressed: () => get<AppRootService>().resetApp(context)),
              ),
            RoundedCButton(
              padding: null,
              onPressed: _canSubmit && !_isLoading ? handleSubmit : null,
              icon: FluentIcons.arrow_enter_20_regular,
              text: _isLoading ? 'Signing in...' : 'Sign in',
            ),
          ],
        ),
      ),
    );
  }
}
