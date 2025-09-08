import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/application/bloc/app_blocs.dart';
import 'package:ulearning_app/pages/register/bloc/register_blocs.dart';
import 'package:ulearning_app/pages/sign_in/bloc/signin_blocs.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';

class AppBlocProviders {
  static get allBlocProviders => [
    BlocProvider(lazy: false, create: (context) => WelcomeBlocs()),
    BlocProvider(create: (context) => SigninBlocs()),
    BlocProvider(create: (context) => RegisterBlocs()),
    BlocProvider(create: (context) => AppBlocs()),
  ];
}
