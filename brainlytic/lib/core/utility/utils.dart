import 'package:brainlytic/core/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showSnackBar(BuildContext context, String text){
  // ScaffoldMessenger.of(context)
  // ..hideCurrentSnackBar()
  // ..showSnackBar(
  //   SnackBar(
  //     behavior: SnackBarBehavior.floating,
  //     backgroundColor: Pallete.snackBarColor,
  //     content: Text(text,
  //       style: Theme.of(context).textTheme.bodyLarge,
  //     )
  //   ),
  //   snackBarAnimationStyle: AnimationStyle(
  //     duration: const Duration(milliseconds: 550),
  //     reverseDuration: const Duration(milliseconds: 500),
  //     //curve: Curves.easeIn,
  //     reverseCurve: Curves.easeOut
  //   )
  // );
  toastification..dismissAll()
  ..show(
    context: context,
    title: Text(text,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    style: ToastificationStyle.simple,
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(30),
    icon: const SizedBox.shrink(),
    showIcon: false,
    closeOnClick: false,
    closeButton: ToastCloseButton(
      showType: CloseButtonShowType.none
    ),
    alignment: Alignment.bottomCenter,
    applyBlurEffect: true,
    animationDuration: const Duration(milliseconds: 500),
    backgroundColor: Pallete.snackBarColor,
    autoCloseDuration: const Duration(milliseconds: 3000),
    animationBuilder: (context, animation, alignment, child){
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}