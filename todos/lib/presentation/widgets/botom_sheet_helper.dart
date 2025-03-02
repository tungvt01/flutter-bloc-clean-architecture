import '../base/base_page_mixin.dart';

class BottomSheetHelper {
  static Future showBottomSheet({
    required Widget body,
    required BuildContext context,
    required Function onTapBtnConfirm,
  }) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return _CommonBottomSheet(
          body: body,
          onTapBtnConfirm: onTapBtnConfirm,
        );
      },
    );
  }
}

class _CommonBottomSheet extends StatelessWidget {
  final Widget body;
  final Function onTapBtnConfirm;

  const _CommonBottomSheet({
    required this.body,
    required this.onTapBtnConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
      child: body,
    );
  }
}
