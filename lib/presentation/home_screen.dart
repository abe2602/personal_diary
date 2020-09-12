import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_diary/presentation/auth/sign_in/sign_in_page.dart';

/// Não devemos instanciar os itens da BottomNavigation dentro do build, uma vez
/// que - ao chamar um modal - a tela é recriada e as GlobalKeys mudam, fazendo
/// com o estado de todas as telas sejam perdidos
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => SignInPage.create();
}
