import 'package:dartz/dartz.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/repository/todo_repository.dart';
import '../../core/error/failures.dart';
import 'base_usecase.dart';

abstract class GetTodoListByConditionUseCase {
  Future<Either<Failure, List<TodoModel>>> getTodoListByCondition(
      {required bool isFinished});
}

class GetTodoListByConditionUseCaseImpl extends BaseUseCase<List<TodoModel>, bool>
    implements GetTodoListByConditionUseCase {
  TodoRepository todoRepository;

  GetTodoListByConditionUseCaseImpl(
    this.todoRepository,
  );

  @override
  Future<Either<Failure, List<TodoModel>>> getTodoListByCondition(
      {required bool isFinished}) {
    return execute(isFinished);
  }

  @override
  Future<List<TodoModel>> main(bool? arg) async {
    final todos =
        await todoRepository.getTodoListByCondition(isFinished: arg!);
    return todos;
  }
}
