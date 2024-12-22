import 'package:dartz/dartz.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/repository/todo_repository.dart';
import '../../core/error/failures.dart';
import 'base_usecase.dart';

abstract class RemoveTodoUseCase {
  Future<Either<Failure, bool>> removeTodo({required TodoModel todoModel});
}

class RemoveTodoUseCaseImpl extends BaseUseCase<bool, TodoModel>
    implements RemoveTodoUseCase {
  TodoRepository todoRepository;
  RemoveTodoUseCaseImpl(
    this.todoRepository,
  );

  @override
  Future<Either<Failure, bool>> removeTodo(
      {required TodoModel todoModel}) async {
    return execute(todoModel);
  }

  @override
  Future<bool> main(TodoModel? arg) async {
    await todoRepository.remove(id: arg!.id);
    return true;
  }
}
