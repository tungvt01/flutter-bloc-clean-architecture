import 'package:todos/core/error/failures.dart';
import 'package:todos/presentation/base/base_state.dart';

class ApplicationState extends BaseState {
  AppLaunchTag tag;

  ApplicationState({
    required this.tag,
    Failure? failure,
    LoadingStatus? status,
  }) : super(failure: failure, loadingStatus: status ?? LoadingStatus.none);

  ApplicationState copyWith({
    AppLaunchTag? tag,
    Failure? failure,
    LoadingStatus? status,
  }) {
    return ApplicationState(
        tag: tag ?? this.tag, failure: failure, status: status);
  }
}

enum AppLaunchTag { splash, main }
