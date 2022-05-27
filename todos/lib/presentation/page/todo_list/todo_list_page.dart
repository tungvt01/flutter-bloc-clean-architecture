import 'dart:async';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/presentation/app/index.dart';
import 'package:todos/presentation/base/base_page_mixin.dart';
import 'package:todos/presentation/base/index.dart';
import 'package:todos/presentation/widgets/no_data_message_widget.dart';
import '../../utils/index.dart';
import '../main/index.dart';
import 'index.dart';
import 'widget/todo_item_widget.dart';

class TodoListPage extends BasePage {
  const TodoListPage({required PageTag pageTag, Key? key})
      : super(tag: pageTag, key: key);

  @override
  State<StatefulWidget> createState() => TodoListPageState();
}

class TodoListPageState extends BasePageState<TodoListBloc, TodoListPage> {
  final RefreshController _controller =
      RefreshController(initialRefresh: false);
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    bloc.dispatchEvent(OnOnFetchingTodoListEvent(widget.tag));
    _subscription?.cancel();
    _subscription = applicationBloc.broadcastEventStream.listen((event) {
      if (event is OnAddNewTodoSuccessEvent &&
          (widget.tag == PageTag.allTodo || widget.tag == PageTag.doingTodo)) {
        bloc.dispatchEvent(OnOnFetchingTodoListEvent(widget.tag));
      }
      if (event is UpdateTotoSuccessEvent) {
        bloc.dispatchEvent(OnOnFetchingTodoListEvent(widget.tag));
      }
    });
  }

  @override
  void stateListenerHandler(BaseState state) {
    super.stateListenerHandler(state);
    if (state is TodoListState && state.loadingStatus == LoadingStatus.finish) {
      _controller.refreshCompleted();
    }
    if (state is OnUpdateTotoSuccessState) {
      applicationBloc
          .postBroadcastEvent(UpdateTotoSuccessEvent(todo: state.todo));
    }
  }

  @override
  Widget buildLayout(BuildContext context, BaseBloc bloc) {
    return BlocBuilder<TodoListBloc, TodoListState>(builder: (ctx, state) {
      return state.todos == null
          ? buildShimmer()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: SmartRefresher(
                onRefresh: () {
                  bloc.dispatchEvent(OnOnFetchingTodoListEvent(widget.tag));
                },
                controller: _controller,
                child: state.todos!.isEmpty
                    ? const NoDataMessageWidget()
                    : ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                        itemCount: state.todos!.length,
                        itemBuilder: (_, index) {
                          return TodoItemWidget(
                            onUpdateClicked: (todo) {
                              _showUpdateConfirmDialog(todo);
                            },
                            todo: state.todos![index],
                          );
                        },
                      ),
              ),
            );
    });
  }

  _showUpdateConfirmDialog(TodoModel todo) async {
    final message = todo.isFinished
        ? 'Mark this item is "Doing" ?'
        : 'Mark this item is "Done" ?';
    final isOk = await showAlert(context: context, message: message);
    if (isOk) {
      todo.isFinished = !todo.isFinished;
      bloc.dispatchEvent(OnRequestUpdateTodoEvent(todo: todo));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
