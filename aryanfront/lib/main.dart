import 'package:aryanfront/Pages/Home/Blocs/ProfileBloc/profile_bloc.dart';
import 'package:aryanfront/Pages/List/Blocs/Com/PersonBloc/person_list_bloc.dart';
import 'package:aryanfront/Services/setup_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Classes/static_datas.dart';
import 'Models/Base/base_request.dart';
import 'Pages/Home/Blocs/LanguageBloc/language_cubit.dart';
import 'Pages/Home/splash_screen.dart';
import 'Services/Interfaces/apiclient_middleware_service.dart';
import 'Services/api_client_service.dart';
import 'Services/login_service.dart';
import 'Services/storage_service.dart';
import 'l10n/app_localizations.dart';

void main() {
  AryanConfigs(
    apiSetting: ApiSettings(
      baseUrl: 'https://216.65.200.215/',
      loginUrl: 'api/auth/login',
      appDefaults: Defaults(),
    ),
  );

  try {
    setupServices();
    ApiClient apiClient = getIt.get<ApiClient>();
    ApiClientMiddlewareService apiMiddleware = ApiClientMiddlewareService(
      apiClient: apiClient,
    );

    // final apiClient = ApiClient(
    //   storage: istorage_service.StorageService(),
    //   appSettings: apiSettings,
    // );

    // final loginService = LoginService(
    //   client: apiClient,
    //   storage: istorage_service.StorageService(),
    // );

    // final apiMiddleware = ApiClientMiddlewareService(apiClient: apiClient);

    runApp(
      MultiBlocProvider(
        providers: [
          Provider<LoginService>(
            create: (_) =>
                LoginService(client: apiClient, storage: StorageService()),
          ),
          BlocProvider(create: (context) => ProfileBloc()),
          BlocProvider(
            create: (context) => PersonListBloc(apiMiddleware: apiMiddleware),
          ),
          BlocProvider(create: (_) => LanguageCubit()),
        ],
        child: MyApp(),
      ),
    );
  } catch (e) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Aryan Front',
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
          theme: ThemeData(
            fontFamily: 'IRanSans',
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          ),
          home: const StartLoadingPage(),
        );
      },
    );
  }
}
