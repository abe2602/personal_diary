import 'package:domain/use_case/sign_in_uc.dart';
import 'package:domain/use_case/sign_up_uc.dart';
import 'package:domain/use_case/validate_username_format_uc.dart';
import 'package:domain/use_case/validate_password_format_uc.dart';
import 'package:domain/use_case/validate_confirm_password_format_uc.dart';
import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:personal_diary/data/repository/auth_repository.dart';
import 'package:personal_diary/data/secure/auth_sds.dart';
import 'package:personal_diary/presentation/auth/sign_up/sign_up_page.dart';
import 'package:personal_diary/presentation/common/route_name_builder.dart';
import 'package:personal_diary/presentation/home_screen.dart';
import 'package:personal_diary/presentation/post_list/post_list_page.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';

import 'navigation_utils.dart';

class PizzaCounterGeneralProvider extends StatelessWidget {
  const PizzaCounterGeneralProvider({
    @required this.child,
  }) : assert(child != null);

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<FlutterSecureStorage>(
            create: (_) => const FlutterSecureStorage(),
          ),
          ..._buildStreamProviders(),
          ..._buildCDSProviders(),
          ..._buildSDSProviders(),
          ..._buildRepositoryProviders(),
          ..._buildUseCaseProviders(),
          ..._buildRouteFactory(),
        ],
        child: child,
      );

  List<SingleChildWidget> _buildRouteFactory() => [
        Provider<Router>(
          create: (context) => Router()
            ..define(
              '/',
              handler: Handler(
                handlerFunc: (context, params) => HomeScreen(),
              ),
            )
            ..define(
              RouteNameBuilder.signUp(),
              transitionType: TransitionType.native,
              handler: Handler(
                handlerFunc: (context, params) => SignUpPage.create(),
              ),
            )..define(
              RouteNameBuilder.home(),
              transitionType: TransitionType.native,
              handler: Handler(
                handlerFunc: (context, params) => PostListPage(),
              ),
            ),
        ),
        //Com a atualização do Flutter, o método "generator" do Router ficou com
        //bugs. Para resolver isso, criei uma extension chamada
        // routeGeneratorFactory, com isso eu posso utilizar o meu generator
        // sempre que precisar.
        ProxyProvider<Router, RouteFactory>(
          update: (context, router, _) =>
              (settings) => router.routeGeneratorFactory(context, settings),
        ),
      ];

  List<SingleChildWidget> _buildStreamProviders() => [
        Provider<PublishSubject<void>>(
          create: (_) => PublishSubject<void>(),
          dispose: (context, playersSubject) => playersSubject.close(),
        ),
      ];

  List<SingleChildWidget> _buildCDSProviders() => [];

  List<SingleChildWidget> _buildSDSProviders() => [
        ProxyProvider<FlutterSecureStorage, AuthSDS>(
          update: (_, secureStorage, __) =>
              AuthSDS(secureStorage: secureStorage),
        ),
      ];

  List<SingleChildWidget> _buildRepositoryProviders() => [
        ProxyProvider<AuthSDS, AuthDataRepository>(
          update: (_, authSDS, __) => AuthRepository(
            authSDS: authSDS,
          ),
        ),
      ];

  List<SingleChildWidget> _buildUseCaseProviders() => [
        Provider<ValidateUsernameFormatUC>(
          create: (_) => ValidateUsernameFormatUC(),
        ),
        Provider<ValidatePasswordFormatUC>(
          create: (_) => ValidatePasswordFormatUC(),
        ),
        Provider<ValidateConfirmPasswordFormatUC>(
          create: (_) => ValidateConfirmPasswordFormatUC(),
        ),
        ProxyProvider<AuthDataRepository, SignInUC>(
          update: (_, authRepository, __) => SignInUC(
            authRepository: authRepository,
          ),
        ),
        ProxyProvider<AuthDataRepository, SignUpUC>(
          update: (_, authRepository, __) => SignUpUC(
            authRepository: authRepository,
          ),
        ),
      ];
}
