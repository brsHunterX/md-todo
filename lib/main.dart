import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import 'package:md_todo/data/datasources/task_datasource.dart';
import 'package:md_todo/data/datasources/auth_datasource.dart';
import 'package:md_todo/data/datasources/client_datasource.dart';

import 'package:md_todo/domain/blocs/auth_bloc.dart';
import 'package:md_todo/domain/blocs/task_bloc.dart';
import 'package:md_todo/domain/repositories/auth_repository.dart';
import 'package:md_todo/domain/repositories/task_repository.dart';

import 'package:md_todo/app.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  // Comment this line if you want your app to accept screen rotation.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  GetIt.instance.registerFactory<ClientDataSource>(() => ClientDataSourceImpl());
  GetIt.instance.registerFactory<AuthDataSource>(() => AuthDataSourceImpl(GetIt.instance<ClientDataSource>()));
  GetIt.instance.registerFactory<TaskDataSource>(() => TaskDataSourceImpl(GetIt.instance<ClientDataSource>()));
  GetIt.instance.registerFactory<AuthRepository>(() => AuthRepositoryImpl(GetIt.instance<AuthDataSource>()));
  GetIt.instance.registerFactory<TaskRepository>(() => TaskRepositoryImpl(GetIt.instance<TaskDataSource>()));
  GetIt.instance.registerLazySingleton<AuthBloc>(() => AuthBloc(GetIt.instance<AuthRepository>()));
  GetIt.instance.registerLazySingleton<TaskBloc>(() => TaskBloc(GetIt.instance<TaskRepository>()));

  runApp(const App());
}

