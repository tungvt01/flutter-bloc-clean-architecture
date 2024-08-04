import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/domain/repository/todo_repository.dart';
import 'package:todos/domain/usecase/base_usecase.dart';

@GenerateNiceMocks([MockSpec<TodoRepository>()])
main() {}

class MockBaseUseCase extends Mock implements BaseUseCase {}
