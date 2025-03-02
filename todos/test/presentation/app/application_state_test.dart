import 'package:flutter_test/flutter_test.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/presentation/app/application_state.dart';
import 'package:todos/presentation/base/base_state.dart';

main() {
  final initialState = ApplicationState(
    tag: AppLaunchTag.main,
    failure: RemoteFailure(msg: 'RemoteFailure'),
    status: LoadingStatus.none,
  );

  final tests = [
    [
      initialState.copyWith(tag: AppLaunchTag.main),
      ApplicationState(
        tag: AppLaunchTag.main,
        status: initialState.loadingStatus,
      ),
    ],
    [
      initialState.copyWith(failure: LocalFailure(msg: 'LocalFailure')),
      ApplicationState(
        tag: AppLaunchTag.main,
        failure: LocalFailure(msg: 'LocalFailure'),
        status: LoadingStatus.none,
      ),
    ],
    [
      initialState.copyWith(status: LoadingStatus.finish),
      ApplicationState(
        tag: AppLaunchTag.main,
        status: LoadingStatus.finish,
      ),
    ]
  ];

  for (var (index, [coppiedState, expectedState]) in tests.indexed) {
    test('should copy correctly $index', () {
      expect(coppiedState, expectedState);
    });
  }
}
