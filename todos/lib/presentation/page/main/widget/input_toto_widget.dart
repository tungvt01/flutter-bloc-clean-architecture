import 'dart:ffi';

import 'package:rxdart/subjects.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/presentation/base/base_page_mixin.dart';
import 'package:todos/presentation/widgets/index.dart';

class InputTodoWidget extends StatefulWidget {
  final Function(TodoModel) onConfirm;
  const InputTodoWidget({
    required this.onConfirm,
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _InputTodoWidgetState();
}

class _InputTodoWidgetState extends State<InputTodoWidget> with BasePageMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.shared.addTotoTitle,
                style: titleLarge,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.shared.addTotoTitleLabel,
              style: titleSmall,
            ),
            TextFormField(
              controller: _title,
              validator: (value) {
                return (value?.isEmpty ?? true)
                    ? AppLocalizations.shared.addNewTodoTitleError
                    : null;
              },
              style: bodyMedium,
              decoration: InputDecoration(
                  border: outlineBorder,
                  hintText: AppLocalizations.shared.addTotoHintTitleLabel,
                  hintStyle: bodyMedium.copyWith(
                    color: AppColors.gray[400],
                  )),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.shared.addTotoDescriptionLabel,
              style: titleSmall,
            ),
            TextFormField(
              controller: _description,
              validator: (value) {
                return (value?.isEmpty ?? true)
                    ? AppLocalizations.shared.addNewTodoDescriptionError
                    : null;
              },
              style: bodyMedium,
              maxLines: 3,
              decoration: InputDecoration(
                  border: outlineBorder,
                  hintText: AppLocalizations.shared.addTotoHintDescriptionLabel,
                  hintStyle: bodyMedium.copyWith(
                    color: AppColors.gray[400],
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SolidButton(
                height: 50,
                width: 200,
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  hideKeyboard(context);
                  final isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    final data = TodoModel(
                        title: _title.text,
                        description: _description.text,
                        createdDate: DateTime.now(),
                        isFinished: false);
                    widget.onConfirm(data);
                  }
                },
                title: 'Save',
                titleStyle: titleMedium.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
