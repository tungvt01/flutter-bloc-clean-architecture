import 'package:todos/core/error/exceptions.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/objectbox.g.dart';

abstract class TodoDAO {
  Future<List<TodoModel>> getAll();
  Future<List<TodoModel>> getTodoListByCondition({required bool isFinished});
  Future<void> insertOrUpdate({required TodoModel data});
}

class TodoDAOImpl extends TodoDAO {
  @override
  Future<List<TodoModel>> getAll() async {
    return _queryTodoList();
  }

  @override
  Future<List<TodoModel>> getTodoListByCondition(
      {required bool isFinished}) async {
    return _queryTodoList(isFinished: isFinished);
  }

  @override
  Future<void> insertOrUpdate({required TodoModel data}) async {
    final store = await openStore();
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
    final store = await openStore();
    try {
      final box = store.box<TodoModel>();
      Condition<TodoModel>? condition;
      if (isFinished != null) {
        condition = (TodoModel_.isFinished.equals(isFinished));
      }
      final builder = box.query(condition)
        ..order(TodoModel_.createdDate, flags: Order.descending);
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
}
