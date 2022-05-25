import 'package:todos/core/utils/validations.dart';
import 'package:todos/presentation/base/index.dart';
import 'package:todos/presentation/page/login/index.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc<BaseEvent, LoginState> with Validators {

  final password = ReplaySubject<String>();

  Function(String) get changePassword => password.sink.add;

  LoginBloc(
  ) : super(initState: LoginState()) {
    on<OnLoginEvent>((e, m) => _loginClickHandler(e, m));
  }

  _loginClickHandler(OnLoginEvent event, Emitter<LoginState> emitter) async {
    emitter(state.copyWith(loadingStatus: LoadingStatus.loading));

  }

  @override
  dispose() {
    password.close();
  }

  @override
  void onPageInitStateEvent(PageInitStateEvent event) {
    super.onPageInitStateEvent(event);
  }
}
