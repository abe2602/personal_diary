import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_diary/presentation/common/adaptive_app.dart';
import 'package:personal_diary/presentation/common/personal_diary_colors.dart';
import 'package:personal_diary/presentation/common/personal_diary_general_provider.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  //Quando provemos Streams pelo provider uma exceção é lançada. Há duas
  //maneiras de contornar a exceção:
  //1. Utilizando ListenableProvider/StreamProvider;
  //2. Settar debugCheckInvalidValueType, do Provider, para nulo.
  //No meu caso, a solução 1 não funciona, já que eu preciso expor um
  //PublishSubject, e não somente a Stream.
  //Ambas soluções são dadas na documentação dos providers.
  //https://pub.flutter-io.cn/documentation/provider/3.0.0+1/
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();

  Hive..init((await getApplicationDocumentsDirectory()).path);

  runApp(MainWidget());
}

//Transformei o MainWidget em Statefull para ter acesso ao dispose
class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) => PersonalDiaryGeneralProvider(
        child: AdaptiveApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: S.delegate.supportedLocales,
          primaryColor: PersonalDiaryColors.primaryColor,

          //Precisamos usar o onGenerateTitle para ter certeza que teremos um
          //context com o Locale já pronto para uso
          onGenerateTitle: (context) => S.of(context).appName,
        ),
      );

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
