import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/themes/app_color.dart';
import 'package:ulearning_app/firebase_options.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/welcome/welcome.dart';
import 'package:ulearning_app/router/pages.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: ScreenUtilInit(
        builder:
            (context, child) => MaterialApp(
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: AppColors.primaryText),
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
              ),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppPages.GenerateRouteSettings,
              home: Welcome(),
            ),
      ),
    );
  }
}
