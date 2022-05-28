import 'package:todos/core/error/exceptions.dart';
import 'package:todos/data/local/index.dart';
import 'package:todos/domain/model/todo_model.dart';

class MockTodoDaoSuccessImpl extends TodoDAO {
  final List<TodoModel> mockTodos = [
    TodoModel(
        title: "Learning English",
        description: "Need spend 3 hours for English",
        createdDate: DateTime.now(),
        isFinished: false)
      ..id = 0,
    TodoModel(
        title: "Meeting with customer",
        description: "Finish tasks firstly",
        createdDate: DateTime.now(),
        isFinished: true)
      ..id = 1,
  ];

  @override
  Future<List<TodoModel>> getAll() async {
    return mockTodos;
  }

  @override
  Future<List<TodoModel>> getTodoListByCondition(
      {required bool isFinished}) async {
    return mockTodos
        .where((element) => element.isFinished == isFinished)
        .toList();
  }

  @override
  Future<void> insertOrUpdate({required TodoModel data}) async {
    int index = mockTodos.indexWhere((element) => element.id == data.id);
    if (index >= 0) {
      mockTodos[index] = data;
    } else {
      mockTodos.add(data);
    }
  }
}

class MockTodoDaoFailureImpl extends TodoDAO {
  @override
  Future<List<TodoModel>> getAll() async {
    throw IOException(
        errorCode: ioException, errorMessage: 'error in getting all data');
  }

  @override
  Future<List<TodoModel>> getTodoListByCondition(
      {required bool isFinished}) async {
    throw IOException(
        errorCode: ioException,
        errorMessage: 'error in getting todo list by condition');
  }

  @override
  Future<void> insertOrUpdate({required TodoModel data}) async {
    throw IOException(
        errorCode: ioException,
        errorMessage: 'error in inserting or updating todo');
  }
}
