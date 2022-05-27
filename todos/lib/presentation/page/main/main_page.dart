import 'package:todos/presentation/app/index.dart';
import 'package:todos/presentation/base/base_page_mixin.dart';
import 'package:todos/presentation/base/index.dart';
import 'package:todos/presentation/navigator/page_navigator.dart';
import 'package:todos/presentation/page/main/widget/input_toto_widget.dart';
import 'package:todos/presentation/page/todo_list/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class MainPage extends BasePage {
  const MainPage({required PageTag pageTag, Key? key})
      : super(tag: pageTag, key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends BasePageState<MainBloc, MainPage> {
  int pageIndex = 0;

  @override
  void stateListenerHandler(BaseState state) {
    super.stateListenerHandler(state);
    if (state is AddNewTodoSuccessState) {
      applicationBloc
          .postBroadcastEvent(OnAddNewTodoSuccessEvent(todo: state.todo));
    }
  }

  @override
  Widget buildLayout(BuildContext context, BaseBloc bloc) {
    return BlocBuilder<MainBloc, MainState>(builder: (ctx, state) {
      return Scaffold(
        floatingActionButton: _CreateTodoButton(
          onPressed: () {
            _onAddNewTodoClickedHandler();
          },
        ),
        bottomNavigationBar: _BottomNavigationBar(
            initIndex: pageIndex,
            onItemClicked: (index) {
              setState(() {
                pageIndex = index;
              });
            }),
        body: SafeArea(
          child: IndexedStack(
            index: pageIndex,
            children: const [
              TodoListPage(pageTag: PageTag.allTodo),
              TodoListPage(pageTag: PageTag.doingTodo),
              TodoListPage(pageTag: PageTag.doneTodo),
            ],
          ),
        ),
      );
    });
  }

  _onAddNewTodoClickedHandler() async {
    final result = await showPopup(
        context: context,
        widget: InputTodoWidget(onConfirm: (data) {
          return navigator.popBack(context: context, result: data);
        }));
    if (result != null) {
      bloc.dispatchEvent(OnAddNewTodoEvent(todo: result));
    }
  }
}

class _BottomNavigationBar extends StatefulWidget {
  final int initIndex;
  final Function(int) onItemClicked;

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarState();
  const _BottomNavigationBar(
      {required this.onItemClicked, required this.initIndex});
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: AppColors.primaryColor,
      onTap: (index) {
        widget.onItemClicked(index);
        setState(() {
          selectedIndex = index;
        });
      },
      currentIndex: selectedIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.all_out),
          label: AppLocalizations.shared.commonTabAll,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.pending_rounded),
          label: AppLocalizations.shared.commonTabDoing,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.done_all),
          label: AppLocalizations.shared.commonTabDone,
        ),
      ],
    );
  }
}

class _CreateTodoButton extends StatelessWidget {
  final Function() onPressed;
  const _CreateTodoButton({required this.onPressed, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      backgroundColor: AppColors.primaryColor,
      onPressed: onPressed,
    );
  }
}
