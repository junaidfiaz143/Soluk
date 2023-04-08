import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget enterWidget;
  final Widget oldWidget;
  final dynamic arguments;

  SlideRightRoute({required this.enterWidget, required this.oldWidget, this.arguments})
      : super(
      settings: RouteSettings(arguments: arguments),
      transitionDuration: const Duration(milliseconds: 1000),
      reverseTransitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return enterWidget;
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) {
        Animation darkish = Tween(begin: 0.0, end:0.3).animate(animation);

        return Stack(
          children: <Widget>[
            SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end:  const Offset(0.3, 0.0),
                ).chain(CurveTween(curve: Curves.easeInOutQuart)).animate(animation),
                child: oldWidget),
            Opacity(opacity: darkish.value, child: Container(color:Colors.black)),
            SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: const Offset(0.0, 0.0),
                ).chain(CurveTween(curve: Curves.easeInOutQuart)).animate(animation),
                child: enterWidget)
          ],
        );
      });
}