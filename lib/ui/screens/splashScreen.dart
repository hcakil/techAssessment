import 'package:auto_route/auto_route.dart';
import 'package:etiyatechassessment/app/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';


import '../../utils/errorMessageKeys.dart';
import '../../utils/uiUtils.dart';
import '../widgets/circularProgressContainner.dart';
import '../widgets/errorContainer.dart';
import '../widgets/pageBackgroundGradientContainer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 4010))
        ..addStatusListener(animationStatusListener);
  late AnimationController titleFadeAnimationController;

  late AnimationController clockAnimationController;
  late Animation<double> clockScaleUpAnimation;
  late Animation<double> clockScaleDownAnimation;

  late AnimationController logoAnimationController;
  late Animation<double> logoScaleUpAnimation;
  late Animation<double> logoScaleDownAnimation;

  void animationStatusListener(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      titleFadeAnimationController.forward(from: 0.0);
    }
  }

  late bool loadedSystemConfigDetails = false;

  @override
  void initState() {
    initAnimations();
   // loadSystemConfig();
    super.initState();
  }


  void initAnimations() {
    clockAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    clockScaleUpAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
        CurvedAnimation(
            parent: clockAnimationController,
            curve: const Interval(0.0, 0.4, curve: Curves.easeInOut)));
    clockScaleDownAnimation = Tween<double>(begin: 0.0, end: 0.9).animate(
        CurvedAnimation(
            parent: clockAnimationController,
            curve: const Interval(0.4, 1.0, curve: Curves.easeInOut)));

    logoAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    logoScaleUpAnimation = Tween<double>(begin: 0.0, end: 1.1).animate(
        CurvedAnimation(
            parent: logoAnimationController,
            curve: const Interval(0.0, 0.4, curve: Curves.easeInOut)));
    logoScaleDownAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
        CurvedAnimation(
            parent: logoAnimationController,
            curve: const Interval(0.4, 1.0, curve: Curves.easeInOut)));

    titleFadeAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    animationController.removeStatusListener(animationStatusListener);

    animationController.dispose();
    logoAnimationController.dispose();
    clockAnimationController.dispose();
    titleFadeAnimationController.dispose();
    super.dispose();
  }

  void navigateToNextScreen() async {
    context.router.replace(const AccountsRoute());
    /* if (loadedSystemConfigDetails) {
      //Reading from settingsCubit means we are just reading current value of settingsCubit
      //if settingsCubit will change in future it will not rebuild it's child

      final currentSettings = context.read<SettingsCubit>().state.settingsModel;
      final currentAuthState = context.read<AuthCubit>().state;

      if (currentSettings!.showIntroSlider) {
        Navigator.of(context).pushReplacementNamed(Routes.introSlider);
      } else {
        if (currentAuthState is Authenticated) {
          context
              .read<UserDetailsCubit>()
              .fetchUserDetails(context.read<AuthCubit>().getUserFirebaseId());
          Navigator.of(context)
              .pushReplacementNamed(Routes.home, arguments: false);
        } else {
          Navigator.of(context).pushReplacementNamed(Routes.login);
        }
      }
    }*/
  }

  void startAnimation(BuildContext buildContext) async {
    await animationController.forward(from: 0.0);
    await clockAnimationController.forward(from: 0.0);
    await logoAnimationController.forward(from: 0.0);
    navigateToNextScreen();
  }

  Widget _buildSplashAnimation(BuildContext buildContext) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: clockAnimationController,
          builder: (context, child) {
            double scale = 0.8 +
                clockScaleUpAnimation.value -
                clockScaleDownAnimation.value;
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Lottie.asset("assets/animations/splashClock.json",
              controller: animationController, onLoaded: (composition) {
            animationController.duration = composition.duration;
            startAnimation(buildContext);
          }),
        ),
        AnimatedBuilder(
            animation: logoAnimationController,
            builder: (context, child) {
              double scale = 0.0 +
                  logoScaleUpAnimation.value -
                  logoScaleDownAnimation.value;
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Center(
                child: Image.asset(UiUtils.getImagePath("splash_logo.png")))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Center(
      key: const Key("splashAnimation"),
      child: _buildSplashAnimation(context),
    );
    return Scaffold(
      body: Stack(
        children: [
          const PageBackgroundGradientContainer(),
          AnimatedSwitcher(
              duration: const Duration(
                microseconds: 500,
              ),
              child: child)
        ],
      ),
    );
  }
}
