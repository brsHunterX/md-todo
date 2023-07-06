import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:md_todo/app.dart';
import 'package:md_todo/domain/services/locator_service.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  // Comment this line if you want your app to accept screen rotation.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  LocatorService.setup();

  runApp(const App());
}

