import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/application/application_page.dart';
import 'package:ulearning_app/pages/application/bloc/app_blocs.dart';
import 'package:ulearning_app/pages/register/bloc/register_blocs.dart';
import 'package:ulearning_app/pages/register/register.dart';
import 'package:ulearning_app/pages/sign_in/bloc/signin_blocs.dart';
import 'package:ulearning_app/pages/sign_in/sign_in.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:ulearning_app/pages/welcome/welcome.dart';
import 'package:ulearning_app/router/names.dart';

class AppPages {
  static List<PageEntiy> routes() {
    return [
      PageEntiy(
        route: AppRouter.initial,
        page: Welcome(),
        bloc: BlocProvider(create: (_) => WelcomeBlocs()),
      ),
      PageEntiy(
        route: AppRouter.signIn,
        page: SignIn(),
        bloc: BlocProvider(create: (_) => SigninBlocs()),
      ),
      PageEntiy(
        route: AppRouter.register,
        page: Register(),
        bloc: BlocProvider(create: (_) => RegisterBlocs()),
      ),
      PageEntiy(
        route: AppRouter.application,
        page: ApplicationPage(),
        bloc: BlocProvider(create: (_) => AppBlocs()),
      ),
    ];
  }

  // return all the bloc providers
  static List<BlocProvider> allBlocProviders(BuildContext context) {
    List<BlocProvider> blocProviders = [];
    for (var e in routes()) {
      if (e.bloc != null && e.bloc is BlocProvider) {
        blocProviders.add(e.bloc as BlocProvider);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (result.first.route == AppRouter.initial && deviceFirstOpen) {
          bool isLoggedin = Global.storageService.getIsLoggedIn();
          if (isLoggedin) {
            return MaterialPageRoute(
              builder: (_) => const ApplicationPage(),
              settings: settings,
            );
          }
          return MaterialPageRoute(
            builder: (_) => SignIn(),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => result.first.page,
          settings: settings,
        );
      }
    }
    return MaterialPageRoute(builder: (_) => SignIn(), settings: settings);
  }
}

//unify BlocProvider and routers and pages
class PageEntiy {
  String route;
  Widget page;
  dynamic bloc;

  PageEntiy({required this.route, required this.page, this.bloc});
}
