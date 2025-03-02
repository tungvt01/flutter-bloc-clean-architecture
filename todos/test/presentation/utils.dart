import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/presentation/app/application_bloc.dart';

Widget generateTestPage({required Widget page}) {
  return MaterialApp(
    localizationsDelegates: const [
      DefaultMaterialLocalizations.delegate,
    ],
    home: Directionality(
      textDirection: TextDirection.ltr,
      child: BlocProvider.value(
        value: ApplicationBloc(),
        child: page,
      ),
    ),
  );
}
