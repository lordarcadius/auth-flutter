import 'package:auth_flutter/core/app/app.dart';
import 'package:auth_flutter/core/di/init_dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  await initDependencies();
  runApp(const AuthApp());
}
