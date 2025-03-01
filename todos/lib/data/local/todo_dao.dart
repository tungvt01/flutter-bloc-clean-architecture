import 'package:injectable/injectable.dart';
import 'package:todos/core/error/exceptions.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/objectbox.g.dart' as database;

abstract class TodoDAO {
  Future<List<TodoModel>> getAll();

  Future<List<TodoModel>> getTodoListByCondition({required bool isFinished});

  Future<void> insertOrUpdate({required TodoModel data});

  Future<bool> remove({required int id});
}

@injectable
class StoreProvider {
  database.Store? store;

  Future<database.Store> getStore() async {
    if (store == null || store!.isClosed()) {
      store = await database.openStore();
    }

    return store!;
  }
}

@Injectable(as: TodoDAO, env: [Environment.prod, Environment.dev])
class TodoDAOImpl extends TodoDAO {
  StoreProvider storeProvider;

  TodoDAOImpl({required this.storeProvider});

  @override
  Future<List<TodoModel>> getAll() async {
    return _queryTodoList();
  }

  @override
  Future<List<TodoModel>> getTodoListByCondition({required bool isFinished}) async {
    return _queryTodoList(isFinished: isFinished);
  }

  @override
  Future<void> insertOrUpdate({required TodoModel data}) async {
    final store = await storeProvider.getStore();
    try {
      final box = store.box<TodoModel>();
      box.put(data);
    } catch (ex) {
      throw IOException(errorCode: ioException, errorMessage: ex.toString());
    } finally {
      store.close();
    }
  }

  Future<List<TodoModel>> _queryTodoList({bool? isFinished}) async {
    List<TodoModel> result = [];
    final store = await storeProvider.getStore();
    try {
      final box = store.box<TodoModel>();
      database.Condition<TodoModel>? condition;
      if (isFinished != null) {
        condition = (database.TodoModel_.isFinished.equals(isFinished));
      }
      final builder = box.query(condition)..order(database.TodoModel_.createdDate, flags: database.Order.descending);
      final query = builder.build();
      result = query.find();
      query.close();
    } catch (ex) {
      throw IOException(errorCode: ioException, errorMessage: ex.toString());
    } finally {
      store.close();
    }
    return result;
  }

  @override
  Future<bool> remove({required int id}) async {
    final store = await storeProvider.getStore();
    try {
      final box = store.box<TodoModel>();
      return box.remove(id);
    } catch (ex) {
      throw IOException(errorCode: ioException, errorMessage: ex.toString());
    } finally {
      store.close();
    }
  }
}
