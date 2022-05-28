import 'package:get_it/get_it.dart';
import 'package:todos/data/local/index.dart';
import 'package:todos/data/local/todo_dao.dart';
import 'package:todos/data/repository/todo_repository_impl.dart';
import 'package:todos/domain/repository/todo_repository.dart';
import 'package:todos/domain/usecase/index.dart';
import 'package:todos/presentation/page/todo_list/index.dart';
import 'presentation/page/main/index.dart';

GetIt injector = GetIt.asNewInstance();

initInjector() {
//Data
  injector.registerLazySingleton<TodoDAO>(() => TodoDAOImpl());

// Repository
  injector
      .registerFactory<TodoRepository>(() => TodoRepositoryImpl(injector()));

//Usecase
  injector.registerFactory<AddNewTotoUseCase>(
      () => AddNewTotoUseCaseImpl(injector()));
  injector.registerFactory<GetAllTodoUseCase>(
      () => GetAllTodoUseCaseImpl(injector()));
  injector.registerFactory<UpdateTodoUseCase>(
      () => UpdateTodoUseCaseImpl(injector()));
  injector.registerFactory<GetTodoListByConditionUseCase>(
      () => GetTodoListByConditionUseCaseImpl(injector()));

//Bloc
  injector.registerFactory<MainBloc>(() => MainBloc(injector()));
  injector.registerFactory<TodoListBloc>(
      () => TodoListBloc(injector(), injector(), injector()));
}
