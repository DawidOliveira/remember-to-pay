import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remember_to_pay/app/core/app_route.dart';
import 'package:remember_to_pay/app/core/config.dart';
import 'package:remember_to_pay/app/modules/home/home_module.dart';
import 'package:remember_to_pay/app/modules/login/login_module.dart';
import 'package:remember_to_pay/app/modules/setting/setting_module.dart';
import 'package:remember_to_pay/app/modules/signup/signup_module.dart';
import 'package:remember_to_pay/app/modules/splash/splash_module.dart';
import 'package:remember_to_pay/app/repositories/note/note_repository.dart';
import 'package:remember_to_pay/app/repositories/user/user_repository.dart';
import 'package:remember_to_pay/app/services/auth/auth_service.dart';
import 'package:remember_to_pay/app/services/notification/notification_service.dart';
import 'package:remember_to_pay/app/shared/widgets/drawer_widget/drawer_widget_controller.dart';

import 'services/note/note_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => Config()),
    Bind.singleton((i) => NotificationService(FirebaseMessaging.instance)),
    Bind.singleton((i) => NoteService(Connectivity(), i())),
    Bind.lazySingleton((i) => DrawerWidgetController()),
    Bind.singleton((i) =>
        UserRepository(FirebaseAuth.instance, FirebaseFirestore.instance)),
    Bind.singleton(
        (i) => AuthService(GoogleSignIn(), i(), FirebaseAuth.instance)),
    Bind.singleton((i) =>
        NoteRepository(FirebaseFirestore.instance, i(), Connectivity(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(AppRoute.SPLASH, module: SplashModule()),
    ModuleRoute(AppRoute.SETTINGS, module: SettingModule()),
    ModuleRoute(AppRoute.HOME, module: HomeModule()),
    ModuleRoute(AppRoute.LOGIN, module: LoginModule()),
    ModuleRoute(AppRoute.SIGNUP, module: SignupModule()),
  ];
}
