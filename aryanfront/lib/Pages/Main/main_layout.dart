import 'package:aryanfront/Pages/Home/profile.dart';
import 'package:aryanfront/Pages/List/Com/Person/person_list_page.dart';
import 'package:flutter/material.dart';

import '../../Elements/Components/list_appbar.dart';
import '../../l10n/app_localizations.dart';

class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  int _selectedIndex = 0;
  final Map<int, Widget> _pageCache = {};

  static double size = 40;
  static double topPadding = 10;

  Widget paddedIcon(String assetPath) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Image.asset(assetPath, width: size, height: size),
    );
  }

  // آیکون‌ها
  late final Widget accountIcon = paddedIcon('assets/images/account.png');
  late final Widget activeAccountIcon = paddedIcon(
    'assets/images/activeaccount.png',
  );

  late final Widget defaultIcon = paddedIcon('assets/images/defaults.png');
  late final Widget activeDefaultIcon = paddedIcon(
    'assets/images/activedefaults.png',
  );

  late final Widget menuIcon = paddedIcon('assets/images/menu.png');
  late final Widget activeMenuIcon = paddedIcon('assets/images/activemenu.png');

  late final Widget openedIcon = paddedIcon('assets/images/opened.png');
  late final Widget activeOpenedIcon = paddedIcon(
    'assets/images/activeopened.png',
  );

  late final Widget newIcon = paddedIcon('assets/images/new.png');
  late final Widget activeNewIcon = paddedIcon('assets/images/activenew.png');

  Widget _getPage(int index) {
    if (_pageCache.containsKey(index)) {
      return _pageCache[index]!;
    }

    late Widget page;
    switch (index) {
      case 0:
        page = const PersonListPage(refreshData: true);
        break;
      case 4:
        page = const ProfilePage(refreshData: true);
        break;
      default:
        page = Center(child: Text("صفحه ${index + 1}"));
    }

    _pageCache[index] = page;
    return page;
  }

  PreferredSizeWidget _getAppBar(int index) {
    switch (index) {
      case 0:
        return buildPersonListAppBar(context);
      case 4:
        return AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          primary: true,
          title: Text(
            AppLocalizations.of(context)!.profileTitle,
            style: const TextStyle(color: Color(0xFF585858)),
          ),
          centerTitle: false,
        );
      default:
        return AppBar(
          title: Text("صفحه ${index + 1}"),
          elevation: 0.0,
          primary: true,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
        );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(_selectedIndex),
      body: IndexedStack(
        index: _selectedIndex,
        alignment: Alignment.center,
        children: List.generate(
          5,
          (i) => i == _selectedIndex
              ? _getPage(i)
              : _pageCache[i] ?? const SizedBox(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            iconSize: 50,
            elevation: 0,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: menuIcon,
                activeIcon: activeMenuIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: newIcon,
                activeIcon: activeNewIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: openedIcon,
                activeIcon: activeOpenedIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: defaultIcon,
                activeIcon: activeDefaultIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: accountIcon,
                activeIcon: activeAccountIcon,
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
