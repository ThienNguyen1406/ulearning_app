// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/service/storage_service.dart';
import 'package:ulearning_app/firebase_options.dart';
import 'package:ulearning_app/router/bloc_observer.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyGlobalObserver();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // await FirebaseAuth.instance.setLanguageCode('vi'); // 'en' cho English
    storageService = await StorageService().init();
  }
}
