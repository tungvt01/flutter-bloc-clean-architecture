import 'package:flutter_svg/svg.dart';
import 'package:todos/presentation/base/base_page_mixin.dart';
import 'package:todos/presentation/base/index.dart';
import 'package:todos/presentation/widgets/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class LoginPage extends BasePage {
  const LoginPage(
      {required PageTag pageTag, Key? key})
      : super(tag: pageTag, key: key);


  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends BasePageState<LoginBloc, LoginPage> {
  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  bool get willListenApplicationEvent => true;

  PageController pvController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void stateListenerHandler(BaseState state) async {
    super.stateListenerHandler(state);
  }

  @override
  Widget buildLayout(BuildContext context, BaseBloc bloc) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (ctx, state) {
      var page = Scaffold(
        body: SafeArea(
          child: GestureDetector(
              onTap: () => hideKeyboard(ctx),
              child: Container(
                width: MediaQuery.of(ctx).size.width,
                height: MediaQuery.of(ctx).size.height,
                color: AppColors.colorFF8B8B8B,
                child: Stack(
                  children: [
                   
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 50, bottom: 35),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(AppImages.icAppLogoWhite),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),),
        ),
      );
      return ProgressHud(
        child: page,
        inAsyncCall: state.loadingStatus == LoadingStatus.loading,
      );
    });
  }
}

