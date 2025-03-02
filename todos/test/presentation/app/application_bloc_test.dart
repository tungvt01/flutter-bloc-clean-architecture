import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/presentation/app/index.dart';
import 'package:todos/presentation/base/index.dart';

main() {
  late ApplicationBloc applicationBloc;
  final initialState = ApplicationState(tag: AppLaunchTag.splash);
  final expectedState = initialState.copyWith(
    status: LoadingStatus.finish,
    tag: AppLaunchTag.main,
  );
  setUp(() {
    applicationBloc = ApplicationBloc();
  });

  blocTest(
    'should emit [${expectedState.toString()}] when app launched',
    seed: () => initialState,
    build: () {
      return applicationBloc;
    },
    act: (ApplicationBloc bloc) {
      bloc.dispatchEvent(AppLaunched());
    },
    expect: () => [expectedState],
  );
}
