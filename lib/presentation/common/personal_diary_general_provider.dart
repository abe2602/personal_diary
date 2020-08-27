import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart' hide Router;
import 'package:personal_diary/data/remote/personal_diary_dio.dart';
import 'navigation_utils.dart';
import 'package:personal_diary/presentation/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';

class PizzaCounterGeneralProvider extends StatelessWidget {
  const PizzaCounterGeneralProvider({
    @required this.child,
  }) : assert(child != null);

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ..._buildStreamProviders(),
          ..._buildCDSProviders(),
          ..._buildRDSProviders(),
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
//            ..define(
//              RouteNameBuilder.pizzaCounterResource,
//              handler: Handler(
//                handlerFunc: (context, params) =>
//                    PizzaCounterPage.create(context),
//              ),
//            )
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

  List<SingleChildWidget> _buildCDSProviders() => [
      ];

  List<SingleChildWidget> _buildRDSProviders() => [
        Provider<Dio>(
          create: (context) {
            final options = BaseOptions(
              baseUrl: '',
            );
            return PizzaCounterDio(options);
          },
        ),
      ];

  List<SingleChildWidget> _buildRepositoryProviders() => [
      ];

  List<SingleChildWidget> _buildUseCaseProviders() => [
      ];
}
