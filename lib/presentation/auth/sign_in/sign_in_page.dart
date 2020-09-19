import 'package:domain/use_case/get_user_name_uc.dart';
import 'package:domain/use_case/sign_in_uc.dart';
import 'package:domain/use_case/validate_password_uc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_diary/generated/l10n.dart';
import 'package:personal_diary/presentation/auth/sign_in/sign_in_bloc.dart';
import 'package:personal_diary/presentation/auth/sign_in/sign_in_models.dart';
import 'package:personal_diary/presentation/common/adaptative_scaffold.dart';
import 'package:personal_diary/presentation/common/adaptive_filled_button.dart';
import 'package:personal_diary/presentation/common/adaptive_flat_button.dart';
import 'package:personal_diary/presentation/common/alert_dialog/generic_error_alert_dialog.dart';
import 'package:personal_diary/presentation/common/alert_dialog/single_action_alert_dialog.dart';
import 'package:personal_diary/presentation/common/form_text_field.dart';
import 'package:personal_diary/presentation/common/personal_diary_action_listener.dart';
import 'package:personal_diary/presentation/common/personal_diary_colors.dart';
import 'package:personal_diary/presentation/common/route_name_builder.dart';
import 'package:personal_diary/presentation/common/view_utils.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    @required this.bloc,
  }) : assert(bloc != null);

  final SignInBloc bloc;

  static Widget create() =>
      ProxyProvider3<ValidatePasswordUC, SignInUC, GetUserNameUC, SignInBloc>(
        update: (_, validatePasswordFormatUC, signInUC, getUserNameUC, bloc) =>
            bloc ??
            SignInBloc(
              validatePasswordFormatUC: validatePasswordFormatUC,
              signInUC: signInUC,
              getUserNameUC: getUserNameUC,
            ),
        dispose: (_, bloc) => bloc.dispose,
        child: Consumer<SignInBloc>(
          builder: (_, bloc, __) => SignInPage(
            bloc: bloc,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: AdaptiveScaffold(
      backgroundColor: PersonalDiaryColors.lightBackground,
      body: PersonalDiaryActionListener<SignInAction>(
        actionStream: bloc.onNewAction,
        onReceived: (event) async {
          if (event is ShowMainContent) {
            await Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamedAndRemoveUntil(
              RouteNameBuilder.home(),
                  (_) => false,
            );
          } else if (event is ShowInvalidCredentialsError) {
            await _InvalidCredentialsAlertDialog().showAsDialog(context);
          } else if (event is NoUserCreatedError) {
            await _NoUserCreatedAlertDialog().showAsDialog(context);
          } else {
            await GenericErrorAlertDialog().showAsDialog(context);
          }
        },
        child: StreamBuilder<SignInState>(
          stream: bloc.onNewState,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data is SignInFlow) {
              final SignInFlow flow = snapshot.data;

              return _SignIn(
                bloc: bloc,
                userName: flow.userName,
              );
            } else {
              return LoadingIndicator();
            }
          },
        ),
      ),
    ),
  );
}

class _SignIn extends StatefulWidget {
  const _SignIn({
    @required this.bloc,
    this.userName,
  }) : assert(bloc != null);

  final SignInBloc bloc;
  final String userName;

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<_SignIn> {
  final _passwordFocusNode = FocusNode();
  final _passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _passwordFocusNode.addFocusLostListener(
      () => widget.bloc.onPasswordFocusLostSink.add(null),
    );
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Column(
                  children: [
                    Image.asset('images/ic_logo.png'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      S.of(context).appTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: PersonalDiaryColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      S.of(context).secondaryTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: PersonalDiaryColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.userName == null
                          ? ''
                          : S
                              .of(context)
                              .signInPageWelcomeMessage(widget.userName),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: PersonalDiaryColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
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
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    widget.bloc.onSignInSink.add(null);
                  },
                  onChanged: (_) => widget.bloc.onPasswordChangedSink
                      .add(_passwordTextController.text),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Column(
                  children: [
                    AdaptiveFilledButton(
                      width: MediaQuery.of(context).size.width,
                      onPressed: () => widget.bloc.onSignInSink.add(null),
                      child: Text(
                        S.of(context).signInLabel,
                        style: const TextStyle(
                          color: PersonalDiaryColors.lightBackground,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (widget.userName == null)
                      AdaptiveFlatButton(
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RouteNameBuilder.signUp());
                        },
                        child: Text(
                          S.of(context).signInFirstAccess,
                          style: TextStyle(
                            color: PersonalDiaryColors.primaryColor,
                          ),
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class _InvalidCredentialsAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleActionAlertDialog(
        title: S.of(context).signInPageInvalidCredentialsError,
        message: S.of(context).signInPageTryAgainText,
        buttonText: S.of(context).signInPageOkLabel,
      );
}

class _NoUserCreatedAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleActionAlertDialog(
        title: S.of(context).signInPageNoUserCreatedError,
        message: S.of(context).signInPageNoUserCreatedErrorTryAgainText,
        buttonText: S.of(context).signInPageOkLabel,
      );
}
