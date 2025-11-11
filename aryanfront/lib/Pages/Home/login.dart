import 'dart:async';

import 'package:aryanfront/Elements/Buttons/dynamic_button.dart';
import 'package:aryanfront/Elements/Commons/aryan_logo.dart';
import 'package:aryanfront/Models/Data/Auth/Login/dto.dart';
import 'package:aryanfront/Pages/Home/Blocs/LoginBloc/login_bloc.dart';
import 'package:aryanfront/Services/user_exist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Elements/Buttons/loading_button.dart';
import '../../Elements/Components/language_button.dart';
import '../../Elements/Inputs/verification.dart';
import '../../Models/Data/Auth/User/dto.dart';
import '../../Resources/Styles/styles.dart';
import '../../Resources/Theme/theme_manager.dart';
import '../../Services/login_service.dart';
import '../../l10n/app_localizations.dart';
import '../Main/main_layout.dart';

String _validationNullMsg = "";
String _validationMsg = "";
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final _passformKey = GlobalKey<FormState>();
final _passRecformKey = GlobalKey<FormState>();
final _userformKey = GlobalKey<FormState>();
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// Future<void> initNotifications() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher'); // آیکون نوتیف
//
//   const InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );
//
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onDidReceiveNotificationResponse: (NotificationResponse response) async {
//       print("User tapped notification: ${response.payload}");
//     },
//   );
// }

final Widget logo = Image.asset(
  'assets/images/aryan_app.png',
  width: 55,
  height: 55,
);

// final TextFormField _passwordRecoveryField = TextFormField(
//   controller: _passwordController,
//   obscureText: true,
//
//   validator: _passwordFieldValidator,
//   textAlign: TextAlign.right,
//   decoration: InputDecoration(
//     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//   ),
// );

String? _passwordFieldValidator(String? value) {
  String? validation = "false";
  try {
    if (value == null || value == '')
      validation = _validationNullMsg;
    else if (value != '12')
      validation = _validationMsg;
    else {}
  } catch (e) {}
  return validation;
}

String? _usernameFieldValidator(String? value) {
  String? validation = "false";
  try {
    if (value == null || value == '')
      validation = _validationNullMsg;
    else if (value != '12')
      validation = _validationMsg;
    else {}
    validation;
  } catch (e) {}
  return validation;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    try {
      super.initState();
      context.read<LoginBloc>().add(LoginInitialEvent());
    } catch (e) {
      // initNotifications();
    }
  }

  final loginService = GetIt.instance<LoginService>();
  final userExistService = GetIt.instance<UserExistService>();

  void loginPressed(BuildContext context, LoginStates state) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainLayoutPage()),
    );
  }

  Widget _buildPasswordTitle(BuildContext context) {
    return ListTile(
      title: Text(AppLocalizations.of(context)!.password),
      horizontalTitleGap: 20,
    );
  }

  Widget _buildUsernameTitle(BuildContext context) {
    return ListTile(
      title: Text(AppLocalizations.of(context)!.phoneNumber),
      horizontalTitleGap: 20,
    );
  }

  Widget _buildUsernameBody(String username, BuildContext context) {
    _usernameController.text = username;
    try {
      return Form(
        key: _userformKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildUsernameTitle(context),
            AryanText.secondaryUsernameTextForm(
              controller: _usernameController,
              hintText: AppLocalizations.of(context)!.phoneNumber,
              obscureText: false,
              validator: _usernameFieldValidator,
            ),
          ],
        ),
      );
    } catch (e) {
      // initNotifications();
      return SizedBox();
    }
  }

  Widget _buildPasswordBody(LoginPasswordState state, BuildContext context) {
    return Form(
      key: _passformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          _buildPasswordTitle(context),

          AryanText.secondaryPasswordTextFormWithToggle(
            controller: _passwordController,
            hintText: AppLocalizations.of(context)!.password,

            validator: _passwordFieldValidator,
          ),

          TextButton(
            onPressed: () {
              final bloc = context.read<LoginBloc>();
              bloc.add(LoginRecoveryPasswordEvent());
              return;
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppLocalizations.of(context)!.passwordForgot,
                style: AryanText.secondary(ThemeColorsManager(Brightness.dark)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoverPasswordBody(
    LoginRecoverPasswordState state,
    BuildContext context,
  ) {
    return Form(
      key: _passRecformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildPasswordTitle(context),
          AryanText.secondaryPasswordTextFormWithToggle(
            controller: _passwordController,
            hintText: AppLocalizations.of(context)!.passwordRecovery,

            validator: _passwordFieldValidator,
          ),

          const Divider(height: 20, color: Colors.transparent),
          ListTile(
            title: Text(AppLocalizations.of(context)!.passwordRecovery),
            horizontalTitleGap: 20,
            leading: const Icon(Icons.lock, color: Colors.black),
          ),

          AryanText.secondaryPasswordTextFormWithToggle(
            controller: _passwordController,
            hintText: AppLocalizations.of(context)!.password,
            validator: _passwordFieldValidator,
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildUsernameTitle(context),
        AryanText.secondaryUsernameTextForm(
          controller: _usernameController,
          hintText: AppLocalizations.of(context)!.phoneNumber,
          obscureText: false,
          validator: _usernameFieldValidator,
        ),
        const Divider(height: 20, color: Colors.transparent),
        _buildPasswordTitle(context),
        AryanText.secondaryPasswordTextFormWithToggle(
          controller: _passwordController,
          hintText: AppLocalizations.of(context)!.password,

          validator: _passwordFieldValidator,
        ),
      ],
    );
  }

  Widget _builLoginButton(BuildContext context) {
    _validationMsg = AppLocalizations.of(
      context,
    )!.passwordValidationMsg.toString();
    _validationNullMsg = AppLocalizations.of(
      context,
    )!.passwordValidationNullMsg;
    return LoadingButton(
      text: AppLocalizations.of(context)!.loginButtonText,

      onPressed: () async {
        final bloc = context.read<LoginBloc>();
        final state = bloc.state;

        if (state is LoginInitialState || state is LoginUsernameState) {
          await usernameStateClickEvent(bloc);
          return;
        } else if (state is LoginPasswordState) {
          await passwordStateClickEvent(bloc);
          return;
        } else if (state is LoginSignUpState) {
          await _sendUserToSignUp();
          return;
        } else if (state is LoginOtpValidationState) {}
      },
    );
  }

  Future<void> passwordStateClickEvent(LoginBloc bloc) async {
    try {
      if (_passformKey.currentState!.validate()) {
        if (_usernameController.value.isComposingRangeValid &&
            _passwordController.value.isComposingRangeValid) {
          if (_usernameController.value.isComposingRangeValid &&
              _passwordController.value.isComposingRangeValid) {
            bool? result = await _loginRequest(
              _usernameController.text,
              _passwordController.text,
            );

            if (result == true) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MainLayoutPage()),
              );
            } else {}
          }
        }
      } else {
        // AppLocalizations.of(context)!.passwordValidationMsg;
      }
    } catch (e) {
      // await initNotifications();
      AppLocalizations.of(context)!.passwordValidationMsg;
    }
  }

  Future<void> usernameStateClickEvent(LoginBloc bloc) async {
    bool? response = false;
    try {
      if (_userformKey.currentState!.validate()) {
        if (_usernameController.value.isComposingRangeValid) {
          response = await _isUsernameExist(_usernameController.text);
        }
      } else {}
    } catch (e) {}
    if (response == true) {
      bloc.add(LoginUsernameEvent());
    } else {
      bloc.add(LoginSignUpEvent());
    }
  }

  Future<bool> _isUsernameExist(String User) async {
    bool result = false;
    try {
      Request req = Request(userName: User);
      Response? response = await userExistService.CheckIfExist(req);
      if (response != null) {
        if (response.result != null && response.result!.contains("succes")) {
          result = true;
        } else {
          //دیالوگ خطا
        }
      }
    } catch (e) {}
    return result;
  }

  Future<bool?> _loginRequest(String? User, String Pass) async {
    bool? result = false;
    try {
      LoginResponse? response = LoginResponse();
      LoginRequest? request = LoginRequest(userName: User, password: Pass);
      response = await loginService.login(request);
      if (response != null) {
        if (response!.result != null && response!.result!.contains('success')) {
          result = true;
        } else {
          //دیالوگ خطا
        }
      }
    } catch (e) {}
    return result;
  }

  Future<bool?> _sendUserToSignUp() async {
    bool? result = false;
    try {
      await openUrl("https://github.com/");
      result = true;
    } catch (e) {}
    return result;
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // برای باز شدن در مرورگر نیتیو
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _getBody() {
    return Center(
      heightFactor: 1.5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: BlocBuilder<LoginBloc, LoginStates>(
            builder: (context, state) {
              Widget content;
              if (state is LoginUsernameState || state is LoginInitialState) {
                content = _buildUsernameBody('amir', context);
              } else if (state is LoginPasswordState) {
                content = _buildPasswordBody(state, context);
              } else if (state is LoginRecoverPasswordState) {
                content = _buildRecoverPasswordBody(state, context);
              } else if (state is LoginOtpValidationState) {
                content = VerificationWidget();
              } else if (state is LoginSignUpState) {
                content = _buildSignUpBody(context);
              } else {
                content = const SizedBox();
              }

              return SizedBox(
                child: Column(
                  key: ValueKey(state.runtimeType),
                  children: [
                    AryanLogo(),
                    SizedBox(height: 20),
                    content,
                    SizedBox(height: 50),
                    _builLoginButton(context),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  LoginEvents _getBackPressed(LoginStates currentState) {
    LoginEvents event = LoginUsernameEvent();
    if (currentState is LoginPasswordState) {
      event = LoginInitialEvent();
    } else if (currentState is LoginRecoverPasswordState) {
      event = LoginUsernameEvent();
    } else if (currentState is LoginSignUpState) {
      event = LoginUsernameEvent();
    } else if (currentState is LoginOtpValidationState) {
      event = LoginUsernameEvent();
    } else {
      event = LoginUsernameEvent();
    }

    return event;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: (state is LoginUsernameState || state is LoginInitialState)
              ? AppBar(
                  primary: true,
                  scrolledUnderElevation: 0.0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  animateColor: false,
                  title: LanguageMenuButton(),
                )
              : AppBar(
                  toolbarHeight: 50,
                  primary: true,
                  animateColor: false,
                  backgroundColor: Colors.white,
                  scrolledUnderElevation: 0.0,
                  leading: CustomDynamicButton(
                    icon: const Icon(Icons.arrow_back),
                    useDefaultAnimation: false,
                    onPressed: () =>
                        context.read<LoginBloc>().add(_getBackPressed(state)),
                  ),
                  actions: [LanguageMenuButton()],
                ),
          body: _getBody(), // بدنه صفحه‌ات اینجا میاد
        );
      },
    );
  }
}
