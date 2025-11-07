import 'package:flutter/material.dart';
import 'package:aryanfront/Pages/Home/profile.dart';
import 'package:aryanfront/Pages/List/Com/Person/person_list_page.dart';


import '../../Elements/Components/list_appbar.dart';
import '../../Elements/Components/list_pagination.dart';

import '../../Elements/Headers/list_head_actionbar.dart';
import '../../l10n/app_localizations.dart';

class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  int _selectedIndex = 0;

  final Map<int, Widget> _pageCache = {};

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
            style: TextStyle(color: Color(0xFF585858)),
          ),
          centerTitle: false,
        );
      default:
        return AppBar(title: Text("صفحه ${index + 1}"),
          elevation: 0.0,
          primary: true,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final Widget accountIcon = Image.asset('assets/images/account.png');
  final Widget activeAccountIcon = Image.asset(
    'assets/images/activeaccount.png',
  );

  final Widget defaultIcon = Image.asset('assets/images/defaults.png');
  final Widget activeDefaultIcon = Image.asset(
    'assets/images/activedefaults.png',
  );

  final Widget menuIcon = Image.asset('assets/images/menu.png');
  final Widget activeMenuIcon = Image.asset('assets/images/activemenu.png');

  final Widget openedIcon = Image.asset('assets/images/opened.png');
  final Widget activeOpenedIcon = Image.asset('assets/images/activeopened.png');

  final Widget newIcon = Image.asset('assets/images/new.png');
  final Widget activeNewIcon = Image.asset('assets/images/activenew.png');

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
            useLegacyColorScheme: true,
            selectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            iconSize: 20,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
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
