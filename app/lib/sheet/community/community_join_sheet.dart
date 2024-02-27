import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/bloc/community/join/community_join_bloc.dart';
import 'package:swipetivity_app/localization/translations.g.dart';

class CommunityJoinSheet extends StatelessWidget {
  const CommunityJoinSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CommunityJoinBloc(
          authBloc: context.read(),
          repository: context.read(),
        );
      },
      child: const _JoinCommunityView(),
    );
  }
}

class _JoinCommunityView extends StatelessWidget {
  const _JoinCommunityView();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Title(),
          SizedBox(height: 20),
          _CommunityJoinForm(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        child: Text(
          context.translations.communityJoinSheet.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class _CommunityJoinForm extends StatefulWidget {
  const _CommunityJoinForm();

  @override
  State<_CommunityJoinForm> createState() => _CommunityJoinFormState();
}

class _CommunityJoinFormState extends State<_CommunityJoinForm> {
  final GlobalKey<FormBuilderState> formState = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formState,
      autovalidateMode: AutovalidateMode.disabled,
      child: _CommunityPinTextField(
        formState: formState,
      ),
    );
  }
}

class _CommunityPinTextField extends StatelessWidget {
  final GlobalKey<FormBuilderState> formState;

  const _CommunityPinTextField({
    required this.formState,
  });

  @override
  Widget build(BuildContext context) {
    var translations = context.translations.communityJoinSheet.input.pin;

    return BlocListener<CommunityJoinBloc, CommunityJoinState>(
      listener: (context, state) {
        if (state is CommunityJoinSuccessState) {
          context.pop();
        } else if (state is CommunityJoinErrorState) {
          var translations =
              context.translations.communityJoinSheet.input.pin.error;
          String errorText = switch (state.errorType) {
            ErrorType.communityNotFound => translations.communityNotFound,
            ErrorType.userAlreadyInCommunity =>
              translations.userAlreadyInCommunity,
            ErrorType.unknown => translations.unknown,
          };

          formState.currentState!.fields["pin"]!.invalidate(errorText);
        }
      },
      child: BlocBuilder<CommunityJoinBloc, CommunityJoinState>(
        builder: (context, state) {
          return FormBuilderTextField(
            name: "pin",
            autofocus: true,
            decoration: InputDecoration(
              labelText: translations.label,
              border: const OutlineInputBorder(),
              suffixIcon: _getSuffixIcon(context, state),
            ),
            validator: FormBuilderValidators.required(
              errorText: translations.validations.required,
            ),
            onChanged: (value) {
              context
                  .read<CommunityJoinBloc>()
                  .add(CommunityPinChangedEvent(pin: value!));
            },
            onSubmitted: (value) {
              _onButtonPressed(context);
            },
          );
        },
      ),
    );
  }

  Widget _getSuffixIcon(BuildContext context, CommunityJoinState state) {
    Widget suffixIcon;

    if (state is CommunityJoinLoadingState) {
      suffixIcon = const UnconstrainedBox(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      suffixIcon = IconButton(
        icon: const Icon(Icons.send),
        onPressed: () => _onButtonPressed(context),
      );
    }
    return suffixIcon;
  }

  void _onButtonPressed(BuildContext context) {
    if (!formState.currentState!.validate()) {
      return;
    }

    context
        .read<CommunityJoinBloc>()
        .add(const CommunityJoinButtonPressedEvent());
  }
}
