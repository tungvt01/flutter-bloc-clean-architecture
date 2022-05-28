import 'package:get_it/get_it.dart';
import 'package:todos/data/local/index.dart';
import 'package:todos/data/repository/todo_repository_impl.dart';
import 'package:todos/domain/repository/todo_repository.dart';
import 'package:todos/domain/usecase/index.dart';
import 'package:todos/presentation/page/main/index.dart';
import 'package:todos/presentation/page/todo_list/todo_list_bloc.dart';
import 'mock_todo_dao.dart';

enum RunMode {
  success,
  failure,
}

GetIt mockInjector = GetIt.asNewInstance();

initMockInjector({RunMode runMode = RunMode.success}) {
//Data- MOCK
  mockInjector.registerLazySingleton<TodoDAO>(() => runMode == RunMode.success
      ? MockTodoDaoSuccessImpl()
      : MockTodoDaoFailureImpl());

// Repository
  mockInjector.registerFactory<TodoRepository>(
      () => TodoRepositoryImpl(mockInjector()));

//Usecase
  mockInjector.registerFactory<AddNewTotoUseCase>(
      () => AddNewTotoUseCaseImpl(mockInjector()));
  mockInjector.registerFactory<GetAllTodoUseCase>(
      () => GetAllTodoUseCaseImpl(mockInjector()));
  mockInjector.registerFactory<UpdateTodoUseCase>(
      () => UpdateTodoUseCaseImpl(mockInjector()));
  mockInjector.registerFactory<GetTodoListByConditionUseCase>(
      () => GetTodoListByConditionUseCaseImpl(mockInjector()));

//Bloc
  mockInjector.registerFactory<MainBloc>(() => MainBloc(mockInjector()));
  mockInjector.registerFactory<TodoListBloc>(
      () => TodoListBloc(mockInjector(), mockInjector(), mockInjector()));
}
