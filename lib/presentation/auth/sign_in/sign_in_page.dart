import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_diary/generated/l10n.dart';
import 'package:personal_diary/presentation/auth/sign_in/sign_in_bloc.dart';
import 'package:personal_diary/presentation/common/adaptative_scaffold.dart';
import 'package:personal_diary/presentation/common/adaptive_filled_button.dart';
import 'package:personal_diary/presentation/common/adaptive_flat_button.dart';
import 'package:personal_diary/presentation/common/form_text_field.dart';
import 'package:personal_diary/presentation/common/personal_diary_action_listener.dart';
import 'package:personal_diary/presentation/common/personal_diary_colors.dart';
import 'package:domain/use_case/validate_password_format_uc.dart';
import 'package:domain/use_case/validate_username_format_uc.dart';
import 'package:domain/use_case/sign_in_uc.dart';
import 'package:provider/provider.dart';
import 'package:personal_diary/presentation/common/view_utils.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    @required this.bloc,
  }) : assert(bloc != null);

  final SignInBloc bloc;

  static Widget create() => ProxyProvider3<ValidateUsernameFormatUC,
          ValidatePasswordFormatUC, SignInUC, SignInBloc>(
        update: (_, validateUsernameFormatUC, validatePasswordFormatUC,
                signInUC, bloc) =>
            bloc ??
            SignInBloc(
              validateUsernameFormatUC: validateUsernameFormatUC,
              validatePasswordFormatUC: validatePasswordFormatUC,
              signInUC: signInUC,
            ),
        dispose: (_, bloc) => bloc.dispose,
        child: Consumer<SignInBloc>(
          builder: (_, bloc, __) => SignInPage(
            bloc: bloc,
          ),
        ),
      );

  @override
  State<StatefulWidget> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
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
  Widget build(BuildContext context) => AdaptiveScaffold(
    backgroundColor: PersonalDiaryColors.lightBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: PersonalDiaryActionListener(
                actionStream: widget.bloc.onNewAction,
                onReceived: (event) {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height/10,
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
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/10,
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
                        height: MediaQuery.of(context).size.height/10,
                      ),
                      Column(
                        children: [
                          AdaptiveFilledButton(
                            width: MediaQuery.of(context).size.width,
                            onPressed: () {},
                            child: Text(
                              S.of(context).signInLabel,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AdaptiveFlatButton(
                            width: MediaQuery.of(context).size.width,
                            onPressed: () {},
                            child: Text(
                              S.of(context).signInFirstAccess,
                              style: TextStyle(
                                color: PersonalDiaryColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
