import 'package:flutter/cupertino.dart';
import 'package:personal_diary/generated/l10n.dart';
import 'package:personal_diary/presentation/auth/sign_up/sign_up_bloc.dart';
import 'package:personal_diary/presentation/auth/sign_up/sign_up_models.dart';
import 'package:personal_diary/presentation/common/adaptative_scaffold.dart';
import 'package:personal_diary/presentation/common/adaptive_filled_button.dart';
import 'package:personal_diary/presentation/common/alert_dialog/generic_error_alert_dialog.dart';
import 'package:personal_diary/presentation/common/form_text_field.dart';
import 'package:personal_diary/presentation/common/route_name_builder.dart';
import 'package:provider/provider.dart';
import 'package:domain/use_case/validate_password_format_uc.dart';
import 'package:domain/use_case/validate_username_format_uc.dart';
import 'package:domain/use_case/validate_confirm_password_format_uc.dart';
import 'package:domain/use_case/sign_up_uc.dart';
import 'package:personal_diary/presentation/common/personal_diary_action_listener.dart';
import 'package:personal_diary/presentation/common/personal_diary_colors.dart';
import 'package:personal_diary/presentation/common/view_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    @required this.bloc,
  }) : assert(bloc != null);

  final SignUpBloc bloc;

  static Widget create() => ProxyProvider4<
          ValidatePasswordFormatUC,
          ValidateUsernameFormatUC,
          ValidateConfirmPasswordFormatUC,
          SignUpUC,
          SignUpBloc>(
        update: (_, validatePasswordFormatUC, validateUsernameFormatUC,
                validateConfirmPasswordFormatUC, signUpUC, bloc) =>
            bloc ??
            SignUpBloc(
              validatePasswordFormatUC: validatePasswordFormatUC,
              validateUsernameFormatUC: validateUsernameFormatUC,
              validateConfirmPasswordFormatUC: validateConfirmPasswordFormatUC,
              signUpUC: signUpUC,
            ),
        dispose: (_, bloc) => bloc.dispose,
        child: Consumer<SignUpBloc>(
          builder: (_, bloc, __) => SignUpPage(
            bloc: bloc,
          ),
        ),
      );

  @override
  State<StatefulWidget> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _nameFocusNode = FocusNode();
  final _nameTextController = TextEditingController();

  final _passwordFocusNode = FocusNode();
  final _passwordTextController = TextEditingController();

  final _confirmPasswordFocusNode = FocusNode();
  final _confirmPasswordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addFocusLostListener(
      () => widget.bloc.onPasswordFocusLostSink.add(null),
    );

    _nameFocusNode.addFocusLostListener(
      () => widget.bloc.onNameFocusLostSink.add(null),
    );

    _confirmPasswordFocusNode.addFocusLostListener(
      () => widget.bloc.onConfirmPasswordFocusLostSink.add(null),
    );
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AdaptiveScaffold(
          title: 'Sign Up',
          body: PersonalDiaryActionListener<SignUpAction>(
            actionStream: widget.bloc.onNewAction,
            onReceived: (receivedAction) async {
              if (receivedAction is ShowMainContent) {
                await Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamedAndRemoveUntil(
                  RouteNameBuilder.home(),
                  (_) => false,
                );
              } else {
                await GenericErrorAlertDialog().showAsDialog(context);
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        S.of(context).signUpAttentionText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Text(
                      S.of(context).signUpRememberPasswordText,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      S.of(context).signUpMaxNameLengthText,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      S.of(context).signUpMaxPasswordLengthText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    FormTextField(
                      focusNode: _nameFocusNode,
                      textInputAction: TextInputAction.done,
                      statusStream: widget.bloc.nameInputStatusStream,
                      labelText: S.of(context).signUpUsernameFieldLabel,
                      keyboardType: TextInputType.emailAddress,
                      invalidErrorMessage:
                          S.of(context).signUpInvalidUsernameErrorLabel,
                      emptyErrorMessage:
                          S.of(context).signUpEmptyUsernameErrorLabel,
                      textEditingController: _nameTextController,
                      onEditingComplete: _passwordFocusNode.requestFocus,
                      onChanged: (_) => widget.bloc.onNameChangedSink
                          .add(_nameTextController.text),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    FormTextField(
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      statusStream: widget.bloc.passwordInputStatusStream,
                      labelText: S.of(context).signInPasswordFieldLabel,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      invalidErrorMessage:
                          S.of(context).signInInvalidPasswordErrorLabel,
                      emptyErrorMessage:
                          S.of(context).signInEmptyPasswordErrorLabel,
                      textEditingController: _passwordTextController,
                      onEditingComplete: _confirmPasswordFocusNode.requestFocus,
                      onChanged: (_) => widget.bloc.onPasswordChangedSink
                          .add(_passwordTextController.text),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    FormTextField(
                      focusNode: _confirmPasswordFocusNode,
                      textInputAction: TextInputAction.done,
                      statusStream:
                          widget.bloc.confirmPasswordInputStatusStream,
                      labelText: S.of(context).signUpConfirmPasswordFieldLabel,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      invalidErrorMessage:
                          S.of(context).signUpPasswordsDifferErrorLabel,
                      textEditingController: _confirmPasswordTextController,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        widget.bloc.onSignUpSink.add(null);
                      },
                      onChanged: (_) => widget.bloc.onConfirmPasswordChangedSink
                          .add(_confirmPasswordTextController.text),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    AdaptiveFilledButton(
                      width: MediaQuery.of(context).size.width,
                      onPressed: () => widget.bloc.onSignUpSink.add(null),
                      child: Text(
                        S.of(context).signUpFinalizeLabel,
                        style: const TextStyle(
                          color: PersonalDiaryColors.lightBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
