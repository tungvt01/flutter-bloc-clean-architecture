import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/repository/todo_repository.dart';
import '../../core/error/failures.dart';
import 'base_usecase.dart';

abstract class UpdateTodoUseCase {
  Future<Either<Failure, bool>> updateTodo({required TodoModel todoModel});
}

@Injectable(as: UpdateTodoUseCase, env: [Environment.prod, Environment.dev])
class UpdateTodoUseCaseImpl extends BaseUseCase<bool, TodoModel>
    implements UpdateTodoUseCase {
  TodoRepository todoRepository;
  UpdateTodoUseCaseImpl(
    this.todoRepository,
  );

  @override
  Future<Either<Failure, bool>> updateTodo(
      {required TodoModel todoModel}) async {
    return execute(todoModel);
  }

  @override
  Future<bool> main(TodoModel? arg) async {
    await todoRepository.updateTodo(todo: arg!);
    return true;
  }
}
