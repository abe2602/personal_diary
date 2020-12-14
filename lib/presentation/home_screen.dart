import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_diary/presentation/common/bottom_navigation/adaptive_bottom_navigation_scaffold.dart';
import 'package:personal_diary/presentation/common/bottom_navigation/bottom_navigation_tab.dart';
import 'package:personal_diary/presentation/common/route_name_builder.dart';

/// Não devemos instanciar os itens da BottomNavigation dentro do build, uma vez
/// que - ao chamar um modal - a tela é recriada e as GlobalKeys mudam, fazendo
/// com o estado de todas as telas sejam perdidos
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BottomNavigationTab> _navigationBarItems;

  @override
  void didChangeDependencies() {
    _navigationBarItems ??= [
      BottomNavigationTab(
        bottomNavigationBarItem: BottomNavigationBarItem(
          title: Text('Posts'),
          icon: Icon(Icons.movie),
        ),
        navigatorKey: GlobalKey<NavigatorState>(),
        initialRouteName: RouteNameBuilder.postList(),
      ),
      BottomNavigationTab(
        bottomNavigationBarItem: BottomNavigationBarItem(
          title: Text('Perfil'),
          icon: Icon(Icons.star_border),
        ),
        navigatorKey: GlobalKey<NavigatorState>(),
        initialRouteName: RouteNameBuilder.postList(),
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => AdaptiveBottomNavigationScaffold(
        navigationBarItems: _navigationBarItems,
      );
}
