import 'package:todos/presentation/base/base_page_mixin.dart';

buildNoDataView({TextStyle? textStyle, String? title}) {
  return Center(
    child: Text(title ?? AppLocalizations.shared.commonMessageNoData,
        style: textStyle ??
            titleMedium.copyWith(
                color: AppColors.neutral2,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
  );
}
