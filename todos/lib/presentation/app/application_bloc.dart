import 'dart:async';
import 'package:todos/presentation/base/index.dart';
import 'package:rxdart/subjects.dart';
import 'index.dart';

class ApplicationBloc extends BaseBloc<ApplicationEvent, ApplicationState> {

  final PublishSubject<BaseEvent> _broadcastEventManager =
      PublishSubject<BaseEvent>();

  ApplicationBloc()
      : super(initState: ApplicationState(tag: AppLaunchTag.splash)) {
    on<AppLaunched>(_onAppLaunchHandler);

  }


  _onAppLaunchHandler(
      AppLaunched event, Emitter<ApplicationState> emitter) async {
    emitter(state.copyWith(status: LoadingStatus.finish,tag: AppLaunchTag.main));
  }

  @override
  void dispose() {
    _broadcastEventManager.close();
  }
}

//broadcast event
extension AppEventCenter on ApplicationBloc {
  Stream<BaseEvent> get broadcastEventStream => _broadcastEventManager.stream;

  void postBroadcastEvent(BaseEvent event) {
    _broadcastEventManager.add(event);
  }
}
