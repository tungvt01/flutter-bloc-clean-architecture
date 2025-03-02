import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/repository/todo_repository.dart';
import '../../core/error/failures.dart';
import 'base_usecase.dart';

abstract class AddNewTotoUseCase {
  Future<Either<Failure, bool>> addNewTodo({required TodoModel todoModel});
}

@Injectable(as: AddNewTotoUseCase, env: [Environment.prod, Environment.dev])
class AddNewTotoUseCaseImpl extends BaseUseCase<bool, TodoModel>
    implements AddNewTotoUseCase {
  TodoRepository todoRepository;

  AddNewTotoUseCaseImpl(
    this.todoRepository,
  );

  @override
  Future<Either<Failure, bool>> addNewTodo(
      {required TodoModel todoModel}) async {
    return execute(todoModel);
  }

  @override
  Future<bool> main(TodoModel? arg) async {
    await todoRepository.addNewTodo(todo: arg!);
    return true;
  }
}
