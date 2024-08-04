import 'package:auth_flutter/core/network/connection_checker.dart';
import 'package:auth_flutter/core/routes/routes_provider.dart';
import 'package:auth_flutter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth_flutter/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:auth_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:auth_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:auth_flutter/features/auth/domain/usecases/user_login.dart';
import 'package:auth_flutter/features/auth/domain/usecases/user_signup.dart';
import 'package:auth_flutter/features/auth/presentation/pages/login/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'init_dependencies.main.dart';