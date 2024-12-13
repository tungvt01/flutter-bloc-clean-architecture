import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos/app_injector.dart';
import 'package:todos/presentation/app/application_bloc.dart';
import 'package:todos/presentation/base/base_bloc.dart';
import 'package:todos/presentation/base/base_event.dart';
import 'package:todos/presentation/base/base_page.dart';
import 'package:todos/presentation/base/base_state.dart';
import 'package:todos/presentation/utils/index.dart';

class BaseBlocImpl extends Mock implements BaseBloc {}

class BasePageImpl extends BasePage {
  const BasePageImpl({super.key, required super.tag});

  @override
  State<StatefulWidget> createState() => BasePageStateImpl();
}

class BasePageStateImpl extends BasePageState<BaseBlocImpl, BasePageImpl> {
  @override
  Widget buildLayout(BuildContext context, BaseBloc<BaseEvent, BaseState> bloc) {
    return Container();
  }
}

main() {
  late BaseBlocImpl baseBloc;

  setUpAll(() {
    baseBloc = BaseBlocImpl();
    registerFallbackValue(PageInitStateEvent());
    registerFallbackValue(PageDidChangeDependenciesEvent());
  });

  setUp(() async {
    await injector.reset();
    injector.registerFactory<BaseBlocImpl>(() => baseBloc);
    reset(baseBloc);
    when(() => baseBloc.stream).thenAnswer((_) => BehaviorSubject<BaseState>().stream);
    when(() => baseBloc.state).thenAnswer((_) => IdlState());
    when(() => baseBloc.close()).thenAnswer((_) => Future<void>.value());
  });

  testWidgets('BasePageImpl initState', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BlocProvider.value(
            value: ApplicationBloc(),
            child: const BasePageImpl(
              tag: PageTag.main,
            )),
      ));
      final BasePageStateImpl basePageState = tester.state(find.byType(BasePageImpl));

      expect(basePageState.bloc, baseBloc);
      expect(basePageState.applicationBloc, isInstanceOf<ApplicationBloc>());
      verify(() => baseBloc.onPageInitStateEvent(any(that: isA<PageInitStateEvent>()))).called(1);
      verify(() => baseBloc.onPageDidChangeDependenciesEvent(any())).called(1);
    });
  });
}
