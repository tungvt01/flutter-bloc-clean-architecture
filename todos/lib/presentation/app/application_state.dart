import 'package:equatable/equatable.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/presentation/base/base_state.dart';

class ApplicationState extends BaseState with EquatableMixin {
  final AppLaunchTag tag;

  ApplicationState({
    required this.tag,
    super.failure,
    LoadingStatus? status,
  }) : super(loadingStatus: status ?? LoadingStatus.none);

  ApplicationState copyWith({
    AppLaunchTag? tag,
    Failure? failure,
    LoadingStatus? status,
  }) {
    return ApplicationState(tag: tag ?? this.tag, failure: failure, status: status);
  }

  @override
  List<Object?> get props => [tag, failure, loadingStatus];
}

enum AppLaunchTag { splash, main }
