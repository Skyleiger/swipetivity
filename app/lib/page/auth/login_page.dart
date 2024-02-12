import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:swipetivity_app/bloc/login/login_bloc.dart';
import 'package:swipetivity_app/localization/translations.g.dart';
import 'package:swipetivity_app/routing/routes.dart';

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
          child: const _LoginView(),
        ));
  }

  void _onBackButtonPressed(BuildContext context) {
    context.pop();
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

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
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..hideCurrentSnackBar();

      const HomePageRoute().go(context);
    } else if (state.status == LoginStatus.failed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.translations.loginPage.loginFailed),
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
              context.translations.loginPage.title,
              style: themeData.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Text(
              context.translations.loginPage.subtitle,
              style: themeData.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            const _EmailAddressField(),
            SizedBox(
              height: size.height * 0.015,
            ),
            const _PasswordField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            TextButton(
              onPressed: () => _onForgotPasswordButtonPressed(context),
              child: Text(
                context.translations.loginPage.forgotPasswordButton,
                style: themeData.textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            const _LoginButton(),
            SizedBox(
              height: size.height * 0.03,
            ),
            TextButton(
              onPressed: () => _onRegisterButtonPressed(context),
              child: Text(
                context.translations.loginPage.registerButton,
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

  void _onRegisterButtonPressed(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    const RegisterPageRoute().push(context);
  }
}

class _EmailAddressField extends StatelessWidget {
  const _EmailAddressField();

  @override
  Widget build(BuildContext context) {
    var translations = context.translations.loginPage.input.email;

    return FormBuilderTextField(
      name: "email",
      decoration: InputDecoration(
        labelText: translations.label,
        border: const OutlineInputBorder(),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
            errorText: translations.validations.required),
        FormBuilderValidators.email(errorText: translations.validations.email),
      ]),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    var translations = context.translations.loginPage.input.password;

    return FormBuilderTextField(
      name: "password",
      decoration: InputDecoration(
        labelText: translations.label,
        border: const OutlineInputBorder(),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
            errorText: translations.validations.required),
      ]),
      obscureText: true,
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedLoadingButton(
          onPressed: () => _onLoginButtonPressed(context),
          isLoading: state.status == LoginStatus.loading,
          child: Text(
            context.translations.loginPage.loginButton,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      },
    );
  }

  void _onLoginButtonPressed(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<LoginBloc>().add(const LoginButtonPressedEvent());
  }
}
