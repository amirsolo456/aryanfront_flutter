// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'آریان فرانت';

  @override
  String get profileTitle => 'حساب کاربری';

  @override
  String get loginPageTitle => 'صفحه ورود';

  @override
  String get phoneNumber => 'شماره تلفن';

  @override
  String get password => 'رمز عبور';

  @override
  String get passwordValidationNullMsg => 'رمز عبور وارد شده درست نمی باشد.';

  @override
  String get passwordValidationMsg => 'رمز عبور خود را وارد کنید.';

  @override
  String get passwordForgot => 'فراموشی رمز عبور';

  @override
  String get passwordRecovery => 'تکرار رمز عبور';

  @override
  String get personList => 'اشخاص شرکت ها';

  @override
  String get userInfo => 'مشخصات کاربری';

  @override
  String get userPasswordChange => 'تغییر رمز عبور';

  @override
  String get userWallet => 'کیف پول';

  @override
  String get userSettings => 'تنظیمات حساب';

  @override
  String get userOtherAccounts => 'حساب های دیگر';

  @override
  String get usersTitle => 'عنوان حساب';

  @override
  String get usersDevices => 'دستگاه های من';

  @override
  String get usersSignOut => 'خروج از حساب کاربری';

  @override
  String get loginButtonText => 'ورود';

  @override
  String get loginButtonLoadingText => 'لطفا صبر کنید';

  @override
  String languagesDisplayName(String userName) {
    return '';
  }
}
