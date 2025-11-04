import 'package:aryanfront/Pages/List/Com/Person/person_list_page.dart';
import 'package:aryanfront/Pages/List/ListBlocs/Com/PersonBloc/person_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (con) => PersonListBloc())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('fa'); // پیش‌فرض

  void toggleLanguage() {
    setState(() {
      _locale = (_locale.languageCode == 'fa')
          ? const Locale('en', 'US')
          : const Locale('fa', 'IR');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aryan Front',
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
      theme: ThemeData(
        fontFamily: 'IRanSans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: MyHomePage(toggleLanguage: toggleLanguage),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final VoidCallback toggleLanguage;
  const MyHomePage({super.key, required this.toggleLanguage});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.loginPageTitle),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.toggleLanguage,
            icon: const Icon(Icons.language, color: Colors.white, size: 15),

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var username = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 320,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.phoneNumber),
                style: ListTileStyle.list,
                horizontalTitleGap: 20,
                leading: const Icon(Icons.phone, color: Colors.black),
              ),
              customUsernameField,
              const Divider(height: 20, color: Colors.transparent),
              ListTile(
                title: Text(AppLocalizations.of(context)!.password),
                horizontalTitleGap: 20,
                leading: const Icon(Icons.add_alarm_sharp, color: Colors.black),
              ),
              customPasswordField,
              const Divider(height: 10, color: Colors.transparent),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setCustomState(),
        backgroundColor: Colors.red,
        child: Icon(Icons.login, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  final TextField customUsernameField = TextField(
    textAlign: TextAlign.right,
    decoration: InputDecoration(
      hintText: 'نام کاربری',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  final TextField customPasswordField = TextField(
    obscureText: true,
    textAlign: TextAlign.right,
    decoration: InputDecoration(
      hintText: 'رمز عبور',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  void setCustomState() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PersonListPage()),
    );
  }
}
