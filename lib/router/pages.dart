import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/application/application_page.dart';
import 'package:ulearning_app/pages/application/bloc/app_blocs.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:ulearning_app/pages/course/course_detail/course_detail.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_blocs.dart';
import 'package:ulearning_app/pages/home/home_page.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/setting_blocs.dart';
import 'package:ulearning_app/pages/profile/settings/settings_page.dart';
import 'package:ulearning_app/pages/register/bloc/register_blocs.dart';
import 'package:ulearning_app/pages/register/register.dart';
import 'package:ulearning_app/pages/sign_in/bloc/signin_blocs.dart';
import 'package:ulearning_app/pages/sign_in/sign_in.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:ulearning_app/pages/welcome/welcome.dart';
import 'package:ulearning_app/router/names.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRouter.initial,
        page: Welcome(),
        bloc: BlocProvider(create: (_) => WelcomeBlocs()),
      ),
      PageEntity(
        route: AppRouter.signIn,
        page: SignIn(),
        bloc: BlocProvider(create: (_) => SigninBlocs()),
      ),
      PageEntity(
        route: AppRouter.register,
        page: Register(),
        bloc: BlocProvider(create: (_) => RegisterBlocs()),
      ),
      PageEntity(
        route: AppRouter.application,
        page: ApplicationPage(),
        bloc: BlocProvider(create: (_) => AppBlocs()),
      ),
      PageEntity(
        route: AppRouter.homepage,
        page: HomePage(),
        bloc: BlocProvider(create: (_) => HomePageBlocs()),
      ),
      PageEntity(
        route: AppRouter.settings,
        page: SettingsPage(),
        bloc: BlocProvider(create: (_) => SettingBlocs()),
      ),
      PageEntity(
        route: AppRouter.courseDetail,
        page: CourseDetail(),
        bloc: BlocProvider(create: (_) => CourseDetailBlocs()),
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
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}
