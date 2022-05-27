import 'package:todos/presentation/utils/index.dart';
import 'package:todos/presentation/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos/presentation/resources/index.dart';
import 'package:todos/presentation/resources/localization/app_localization.dart';
import 'package:todos/presentation/styles/index.dart';
export 'package:todos/presentation/resources/icons/app_images.dart';
export 'package:todos/presentation/styles/text_style.dart';
export 'package:todos/presentation/styles/app_colors.dart';
export 'package:todos/presentation/resources/icons/app_images.dart';
export 'package:todos/presentation/resources/localization/app_localization.dart';
export 'package:flutter/material.dart';
export 'package:todos/presentation/styles/index.dart';

mixin BasePageMixin {
  Future<void> showSnackBarMessage(String msg, BuildContext context) async {
    final snackBar = SnackBar(
      backgroundColor: AppColors.primaryColor,
      content: Container(
        height: 50,
        color: AppColors.primaryColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(msg,
              style: bodyMedium.copyWith(
                  color: Colors.white, fontWeight: FontWeight.w500)),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  hideKeyboard(context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<bool> showAlert(
      {required BuildContext context,
      String? title,
      required String message,
      String? okActionTitle,
      String? cancelTitle,
      TextStyle? titleStyle,
      TextStyle? messageStyle,
      String? image,
      bool? dismissWithBackPress,
      Color primaryColor = AppColors.primaryColor}) async {
    final result = await AlertManager.showAlert(
        context: context,
        message: message,
        title: title,
        okActionTitle: okActionTitle,
        cancelTitle: cancelTitle,
        image: image,
        titleStyle: titleStyle,
        dismissWithBackPress: dismissWithBackPress,
        messageStyle: messageStyle,
        primaryColor: primaryColor);
    return result;
  }

  buildSeparator(
      {EdgeInsets padding = const EdgeInsets.all(0),
      double height = 0.5,
      Color color = AppColors.gray}) {
    return Padding(
      padding: padding,
      child: Container(
        height: height,
        color: color,
      ),
    );
  }

  buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  buildBottomLoadMore({Color? backgroundColor}) {
    return Container(
      alignment: Alignment.center,
      color: backgroundColor ?? AppColors.gray.withAlpha(150),
      child: const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  showBottomSheetMenu<T>(
      {required Widget child,
      required BuildContext context,
      double? height,
      bool isDismissible = false}) {
    return showModalBottomSheet<T>(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        // ),
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Center(child: child)),
              )
            ],
          );
        });
  }

  Widget buildShimmer({int count = 20}) {
    final children = List.generate(count, (index) => const ShimmeItemWidget());
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget buildNoDataMessage() {
    return LayoutBuilder(builder: (context, constrainst) {
      return SizedBox(
        height: constrainst.maxHeight,
        child: Center(
          child: Text(
            AppLocalizations.shared.commonMessageNoData,
            style: bodyMedium.copyWith(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
          ),
        ),
      );
    });
  }

  showPopup({required BuildContext context, required Widget widget}) async {
    return AlertManager.showWidgetDialog(context: context, child: widget);
  }
}
