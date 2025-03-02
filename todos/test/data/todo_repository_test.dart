import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/data/local/index.dart';
import 'package:todos/data/repository/todo_repository_impl.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/repository/todo_repository.dart';

class MockTodoDAO extends Mock implements TodoDAO {}

main() {
  late TodoRepository todoRepository;
  late TodoDAO totoDAO;
  final todo = TodoModel(
    id: 1,
    title: 'title',
    description: 'description',
    createdDate: DateTime.now(),
    isFinished: true,
  );

  setUp(() {
    totoDAO = MockTodoDAO();
    todoRepository = TodoRepositoryImpl(totoDAO);
  });

  test('addNewTodo()', () {
    when(() => totoDAO.insertOrUpdate(data: todo))
        .thenAnswer((_) => Future<void>.value());

    todoRepository.addNewTodo(todo: todo);

    verify(() => totoDAO.insertOrUpdate(data: todo)).called(1);
  });

  test('getAll()', () async {
    final todoList = [todo];
    when(totoDAO.getAll).thenAnswer((_) => Future.value(todoList));

    final result = await todoRepository.getAll();

    verify(totoDAO.getAll).called(1);
    expect(result, todoList);
  });

  test('getAll()', () async {
    const condition = false;
    final todoList = [todo];
    when(() => totoDAO.getTodoListByCondition(isFinished: condition))
        .thenAnswer((_) => Future.value(todoList));

    final result =
        await todoRepository.getTodoListByCondition(isFinished: condition);

    verify(() => totoDAO.getTodoListByCondition(isFinished: condition))
        .called(1);
    expect(result, todoList);
  });
}
