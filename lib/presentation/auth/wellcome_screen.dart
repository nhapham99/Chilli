import 'package:chilli/presentation/auth/choose_theme_color_screen.dart';
import 'package:chilli/presentation/auth/input_username_screen.dart';
import 'package:chilli/presentation/auth/widgets/wellcome_widget.dart';
import 'package:chilli/utils/icons.dart';
import 'package:chilli/widgets/bouce_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class WellcomeScreen extends StatefulWidget {
  const WellcomeScreen({Key? key}) : super(key: key);

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController(
    keepPage: true,
  );

  late AnimationController _pageAnimationController;

  late AnimationController _backArrowAnimationController;

  late AnimationController _appIconAnimationController;

  late Animation<Offset> _backAnimation;

  late Animation<double> _appIconAnimation;

  double paddingAppIcon = 8.0.h;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 0),
      reverseDuration: const Duration(milliseconds: 500),
    );

    _backArrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    final backArrowCurve = CurvedAnimation(
      parent: _backArrowAnimationController,
      curve: Curves.linear,
    );
    _backAnimation = Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(backArrowCurve);
    _pageAnimationController.forward();
    _appIconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    final appIconCurve = CurvedAnimation(
      parent: _appIconAnimationController,
      curve: Curves.linear,
    );
    _appIconAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(appIconCurve);
  }

  @override
  void dispose() {
    _pageAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.0.w,
        height: 100.0.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffF4C898),
              Color(0xFFDC6B66),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              _buildBackArrow(),
              Column(
                children: [
                  AnimatedPadding(
                    padding: EdgeInsets.only(top: paddingAppIcon),
                    duration: const Duration(milliseconds: 400),
                  ),
                  BounceWidget(
                    duration: const Duration(milliseconds: 2000),
                    child: ScaleTransition(
                      scale: _appIconAnimation,
                      child: SvgPicture.asset(
                        AppIcons.appIcons,
                        height: 25.0.w,
                        width: 25.0.w,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      itemBuilder: (BuildContext context, int index) {
                        currentPage = index;
                        return _buildBody(index);
                      },
                      itemCount: 3,
                    ),
                  ),
                  SizedBox(height: 5.0.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(int pageIndex) {
    if (pageIndex == 0) {
      return WellcomeWidget(
        onTapLogin: () {},
        onTapRegister: () {
          HapticFeedback.lightImpact();
          _pageController.nextPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.linear,
          );
          setState(() {
            paddingAppIcon = 1.0.h;
          });
          _backArrowAnimationController.forward();
          _appIconAnimationController.forward();
        },
      );
    } else if (pageIndex == 1) {
      return InputUsernameScreen(
        onTapConfirm: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.linear,
          );
        },
      );
    } else if (pageIndex == 2) {
      return const ChooseThemeColorScreen();
    } else {
      return Container();
    }
  }

  Widget _buildBackArrow() {
    return SlideTransition(
      position: _backAnimation,
      child: GestureDetector(
        onTap: () {
          if (currentPage == 1) {
            _backArrowAnimationController.reverse();
            _pageController.previousPage(
              duration: const Duration(milliseconds: 350),
              curve: Curves.linear,
            );
            setState(() {
              paddingAppIcon = 8.0.h;
            });
            _pageAnimationController.forward();
            _appIconAnimationController.reverse();
          } else {
            currentPage -= 1;
            _pageController.previousPage(
              duration: const Duration(milliseconds: 350),
              curve: Curves.linear,
            );
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.only(top: 4.0.h),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white.withOpacity(0.4),
              size: 22.0.sp,
            ),
          ),
        ),
      ),
    );
  }
}
