// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/local/todo_dao.dart' as _i520;
import '../data/repository/todo_repository_impl.dart' as _i509;
import '../domain/repository/todo_repository.dart' as _i806;
import '../domain/usecase/add_new_todo_usecase.dart' as _i966;
import '../domain/usecase/get_all_todo_usecase.dart' as _i65;
import '../domain/usecase/get_todo_by_condition_usecase.dart' as _i270;
import '../domain/usecase/index.dart' as _i872;
import '../domain/usecase/remove_todo_usecase.dart' as _i552;
import '../domain/usecase/update_todo_usecase.dart' as _i1037;
import '../presentation/page/main/main_bloc.dart' as _i835;
import '../presentation/page/todo_list/todo_list_bloc.dart' as _i394;

const String _prod = 'prod';
const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i520.StoreProvider>(() => _i520.StoreProvider());
    gh.factory<_i520.TodoDAO>(
      () => _i520.TodoDAOImpl(storeProvider: gh<_i520.StoreProvider>()),
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.factory<_i806.TodoRepository>(
      () => _i509.TodoRepositoryImpl(gh<_i520.TodoDAO>()),
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.factory<_i65.GetAllTodoUseCase>(
      () => _i65.GetAllTodoUseCaseImpl(gh<_i806.TodoRepository>()),
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.factory<_i966.AddNewTotoUseCase>(
      () => _i966.AddNewTotoUseCaseImpl(gh<_i806.TodoRepository>()),
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.factory<_i1037.UpdateTodoUseCase>(
      () => _i1037.UpdateTodoUseCaseImpl(gh<_i806.TodoRepository>()),
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.factory<_i552.RemoveTodoUseCase>(
      () => _i552.RemoveTodoUseCaseImpl(gh<_i806.TodoRepository>()),
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.factory<_i270.GetTodoListByConditionUseCase>(
      () => _i270.GetTodoListByConditionUseCaseImpl(gh<_i806.TodoRepository>()),
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.factory<_i835.MainBloc>(
      () => _i835.MainBloc(gh<_i966.AddNewTotoUseCase>()),
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.factory<_i394.TodoListBloc>(
      () => _i394.TodoListBloc(
        gh<_i872.GetAllTodoUseCase>(),
        gh<_i872.UpdateTodoUseCase>(),
        gh<_i872.GetTodoListByConditionUseCase>(),
        gh<_i872.RemoveTodoUseCase>(),
      ),
      registerFor: {
        _prod,
        _dev,
      },
    );
    return this;
  }
}
