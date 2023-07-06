import 'package:get_it/get_it.dart';

import 'package:md_todo/data/datasources/auth_datasource.dart';
import 'package:md_todo/data/datasources/task_datasource.dart';
import 'package:md_todo/data/datasources/client_datasource.dart';

import 'package:md_todo/domain/blocs/auth_bloc.dart';
import 'package:md_todo/domain/blocs/task_bloc.dart';
import 'package:md_todo/domain/repositories/auth_repository.dart';
import 'package:md_todo/domain/repositories/task_repository.dart';

class LocatorService {
  static final GetIt locator = GetIt.instance;

  static void setup() {
    locator.registerFactory<ClientDataSource>(() => ClientDataSourceImpl());
    locator.registerFactory<AuthDataSource>(() => AuthDataSourceImpl(locator<ClientDataSource>()));
    locator.registerFactory<TaskDataSource>(() => TaskDataSourceImpl(locator<ClientDataSource>()));
    locator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(locator<AuthDataSource>()));
    locator.registerFactory<TaskRepository>(() => TaskRepositoryImpl(locator<TaskDataSource>()));
    locator.registerLazySingleton<AuthBloc>(() => AuthBloc(locator<AuthRepository>()));
    locator.registerLazySingleton<TaskBloc>(() => TaskBloc(locator<TaskRepository>()));
  }
}