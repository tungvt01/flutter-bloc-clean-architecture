import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/domain/usecase/base_usecase.dart';

import 'usecase_mock.dart';

main() async {
  late BaseUseCase baseUseCase;

  setUp(() {
    baseUseCase = MockBaseUseCase();
  });

  tearDown(() {
    reset(baseUseCase);
  });

  test('Should execute successfully', () {
    when(baseUseCase.execute).thenAnswer((_) => Future.value(const Right(1)));

    baseUseCase.execute();

    verify(baseUseCase.execute).called(1);
    verifyNoMoreInteractions(baseUseCase);
  });
}
