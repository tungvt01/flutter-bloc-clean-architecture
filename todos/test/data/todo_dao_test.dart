import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/core/error/exceptions.dart';
import 'package:todos/data/local/index.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/objectbox.g.dart';

class MockStoreProvider extends Mock implements StoreProvider {}

class MockStore extends Mock implements Store {}

class MockBox extends Mock implements Box<TodoModel> {}

class MockQueryBuilder extends Mock implements QueryBuilder<TodoModel> {}

class MockQuery extends Mock implements Query<TodoModel> {}

main() async {
  late TodoDAO totoDAO;
  late StoreProvider storeProvider;
  late Store store;
  late Box<TodoModel> box;

  setUp(() {
    storeProvider = MockStoreProvider();
    box = MockBox();
    store = MockStore();
    when(store.box<TodoModel>).thenReturn(box);
    when(storeProvider.getStore).thenAnswer((_) => Future.value(store));
    totoDAO = TodoDAOImpl(storeProvider: storeProvider);
  });

  tearDown(() {
    reset(store);
    reset(box);
  });

  group('getAll()', () {
    test('get all todos list', () async {
      final List<TodoModel> totoList = [TodoModel(id: 1, title: '1', createdDate: DateTime.now(), isFinished: true, description: '')];
      final builder = MockQueryBuilder();
      final query = MockQuery();

      when(box.query).thenReturn(builder);
      when(() => builder.order(TodoModel_.createdDate, flags: Order.descending)).thenReturn(builder);
      when(builder.build).thenReturn(query);
      when(query.find).thenReturn(totoList);

      final result = await totoDAO.getAll();

      expect(result, totoList);
      verify(store.box<TodoModel>).called(1);
      verify(box.query).called(1);
      verify(() => builder.order(TodoModel_.createdDate, flags: Order.descending)).called(1);
      verify(builder.build).called(1);
      verify(query.find).called(1);
      verify(query.close).called(1);
    });

    test('should throw exception', () async {
      final exception = Exception('error message');
      when(store.box<TodoModel>).thenThrow(exception);

      // expect(() => totoDAO.getAll(), throwsA(isA<IOException>()));// option 1
      try {
        await totoDAO.getAll();
      } catch (ex) {
        verify(store.box<TodoModel>).called(1);
        expect(ex, isInstanceOf<IOException>()); // option 2
      }
    });
  });

  group('insertOrUpdate()', () {
    final insertTodo = TodoModel(id: 1, title: 'title', description: 'description', createdDate: DateTime.now(), isFinished: true);

    test('should insert or update successfully', () async {
      when(() => box.put(insertTodo)).thenAnswer((_) => 1);

      await totoDAO.insertOrUpdate(data: insertTodo);

      verify(() => box.put(insertTodo)).called(1);
    });

    test('should throw error', () async {
      when(() => box.put(insertTodo)).thenThrow(IOException(errorMessage: ioException));
      try {
        await totoDAO.insertOrUpdate(data: insertTodo);
      } catch (ex) {
        verify(() => box.put(insertTodo)).called(1);
        expect(ex, isInstanceOf<IOException>());
      }
    });
  });

  group('remove()', () {
    const removeId = 1;
    test('should remove successfully', () async {
      when(() => box.remove(removeId)).thenAnswer((_) => true);

      await totoDAO.remove(id: removeId);

      verify(() => box.remove(removeId)).called(1);
    });

    test('should throw error', () async {
      when(() => box.remove(removeId)).thenThrow(IOException(errorMessage: ioException));
      try {
        await totoDAO.remove(id: removeId);
      } catch (ex) {
        verify(() => box.remove(removeId)).called(1);
        expect(ex, isInstanceOf<IOException>());
      }
    });
  });
}
