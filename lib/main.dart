import 'package:auth_flutter/core/app/app.dart';
import 'package:auth_flutter/core/di/init_dependencies.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const AuthApp());
}
