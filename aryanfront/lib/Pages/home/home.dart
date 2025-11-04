import 'package:aryanfront/Pages/home/home_bloc.dart';
import 'package:aryanfront/Pages/home/settings_bloc.dart';
import 'package:aryanfront/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (con) => HomeBloc()),
        BlocProvider(create: (con) => SettingsBloc()),
      ],
      child: const MyApp(),
    ),

  );
}
