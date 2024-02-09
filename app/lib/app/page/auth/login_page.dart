import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:swipetivity_app/app/bloc/login/login_bloc.dart';
import 'package:swipetivity_app/app/routing/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => _onBackButtonPressed(context),
          ),
        ),
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authRepository: context.read(),
            authBloc: context.read(),
          ),
          child: const _AuthLoginView(),
        ));
  }

  void _onBackButtonPressed(BuildContext context) {
    context.pop();
  }
}

class _AuthLoginView extends StatelessWidget {
  const _AuthLoginView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: _handleLoginStateChange,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
        ),
        child: const _LoginForm(),
      ),
    );
  }

  void _handleLoginStateChange(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.success) {
      DashboardRoute().go(context);
    } else if (state.status == LoginStatus.failed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Anmeldung fehlgeschlagen"),
        ),
      );
    }
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: FormBuilder(
        key: context.read<LoginBloc>().formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Anmelden",
              style: themeData.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Text(
              "Bitte melde dich an.",
              style: themeData.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            FormBuilderTextField(
              name: "email",
              decoration: const InputDecoration(
                labelText: "E-Mail",
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            FormBuilderTextField(
              name: "password",
              decoration: const InputDecoration(
                labelText: "Passwort",
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
              obscureText: true,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            TextButton(
              onPressed: () => _onForgotPasswordButtonPressed(context),
              child: Text(
                "Passwort vergessen?",
                style: themeData.textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return ElevatedLoadingButton(
                  onPressed: () => _onLoginButtonPressed(context),
                  isLoading: state.status == LoginStatus.loading,
                  child: Text(
                    "Anmelden",
                    style: themeData.textTheme.titleLarge,
                  ),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            TextButton(
              onPressed: () => _onRegisterButtonPressed(context),
              child: Text(
                "Noch keinen Account? Registrieren",
                style: themeData.textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onForgotPasswordButtonPressed(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onLoginButtonPressed(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<LoginBloc>().add(const LoginButtonPressedEvent());
  }

  void _onRegisterButtonPressed(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    AuthRegisterRoute().push(context);
  }
}
