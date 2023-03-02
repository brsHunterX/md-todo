// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on _TaskStore, Store {
  late final _$inLoadingAtom =
      Atom(name: '_TaskStore.inLoading', context: context);

  @override
  bool get inLoading {
    _$inLoadingAtom.reportRead();
    return super.inLoading;
  }

  @override
  set inLoading(bool value) {
    _$inLoadingAtom.reportWrite(value, super.inLoading, () {
      super.inLoading = value;
    });
  }

  late final _$tasksAtom = Atom(name: '_TaskStore.tasks', context: context);

  @override
  List<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(List<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$listAsyncAction =
      AsyncAction('_TaskStore.list', context: context);

  @override
  Future<void> list() {
    return _$listAsyncAction.run(() => super.list());
  }

  late final _$createAsyncAction =
      AsyncAction('_TaskStore.create', context: context);

  @override
  Future<void> create(Map<String, dynamic> data) {
    return _$createAsyncAction.run(() => super.create(data));
  }

  late final _$completeAsyncAction =
      AsyncAction('_TaskStore.complete', context: context);

  @override
  Future<void> complete(String id) {
    return _$completeAsyncAction.run(() => super.complete(id));
  }

  late final _$deleteAsyncAction =
      AsyncAction('_TaskStore.delete', context: context);

  @override
  Future<void> delete(String id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  @override
  String toString() {
    return '''
inLoading: ${inLoading},
tasks: ${tasks}
    ''';
  }
}
