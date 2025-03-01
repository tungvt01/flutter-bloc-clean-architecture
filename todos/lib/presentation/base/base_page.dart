import 'package:focus_detector/focus_detector.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/infrastructure/injection.dart';
import 'package:todos/presentation/app/index.dart';
import 'package:todos/presentation/base/index.dart';

import 'package:todos/presentation/navigator/page_navigator.dart';
import 'package:todos/presentation/utils/index.dart';
import 'base_page_mixin.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:logger/logger.dart';
export 'package:todos/presentation/styles/index.dart';
export 'package:todos/presentation/utils/input_formatter.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({
    required this.tag,
    super.key,
  });

  final PageTag tag;
}

abstract class BasePageState<T extends BaseBloc<BaseEvent, BaseState>, P extends BasePage> extends State<P> with BasePageMixin {
  late T bloc;
  late BuildContext subContext;
  late ApplicationBloc applicationBloc;

  bool get resizeToAvoidBottomInset => false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.onPageDidChangeDependenciesEvent(PageDidChangeDependenciesEvent(context: context));
  }

  @override
  void initState() {
    bloc = injector.get<T>(type: T);
    applicationBloc = BlocProvider.of<ApplicationBloc>(context);

    bloc.onPageInitStateEvent(PageInitStateEvent(context: context));
    super.initState();
  }

  Widget buildLayout(BuildContext context, BaseBloc bloc);

  void stateListenerHandler(BaseState state) async {
    if (state.failure != null) {
      if ((state.failure!.httpStatusCode ?? 0) == accessTokenExpiredCode) {
        final result = await showAlert(
          primaryColor: AppColors.primaryColor,
          context: context,
          message: AppLocalizations.shared.commonMessageServerMaintenance,
        );
        if (result) {
          navigator.popToRoot(context: context);
          applicationBloc.dispatchEvent(AccessTokenExpiredEvent());
        }
        return;
      }
      String message = '';
      Logger().d('[Debug]: error ${state.failure?.message}');
      if (state.failure!.message == internetErrorMessage || state.failure!.message == socketErrorMessage) {
        message = AppLocalizations.shared.commonMessageConnectionError;
      } else if (state.failure!.message == serverErrorMessage) {
        message = AppLocalizations.shared.commonMessageServerMaintenance;
      } else {
        message = state.failure!.message ?? unknownErrorMessage;
      }
      showAlert(
        context: context,
        message: message,
        primaryColor: AppColors.primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        bloc.onPageDidAppearEvent(PageDidAppearEvent(tag: widget.tag, context: context));
      },
      onFocusLost: () {
        bloc.onPageDidDisappearEvent(PageDidDisappearEvent(tag: widget.tag, context: context));
      },
      onForegroundLost: () {
        bloc.onAppEnterBackgroundEvent(AppEnterBackgroundEvent(context: context, tag: widget.tag));
      },
      onForegroundGained: () {
        bloc.onAppGainForegroundEvent(AppGainForegroundEvent(context: context, tag: widget.tag));
      },
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: BlocProvider<T>(
          create: (context) => bloc,
          child: BlocListener<T, BaseState>(listener: (context, state) async {
            stateListenerHandler(state);
          }, child: LayoutBuilder(builder: (sub, _) {
            subContext = sub;
            return buildLayout(subContext, bloc);
          })),
        ),
      ),
    );
  }

  @override
  dispose() {
    bloc.dispose();
    bloc.close();
    super.dispose();
  }
}
