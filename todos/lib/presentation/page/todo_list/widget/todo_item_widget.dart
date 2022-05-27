import 'package:todos/core/utils/index.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/presentation/base/base_page_mixin.dart';
import 'package:todos/presentation/widgets/round_container.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoModel todo;
  final Function(TodoModel) onUpdateClicked;
  const TodoItemWidget({
    required this.onUpdateClicked,
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundContainer(
      allRadius: 15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: titleMedium.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    todo.description,
                    style: bodySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    todo.createdDate.formatDateAndTime(),
                    style: bodySmall.copyWith(
                        color: AppColors.gray[400],
                        fontSize: 11,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  onUpdateClicked(todo);
                },
                icon: Icon(
                  todo.isFinished ? Icons.done : Icons.radio_button_unchecked,
                  color: AppColors.primaryColor,
                ))
          ],
        ),
      ),
    );
  }
}
