import 'package:flutter/material.dart';

import 'circle.dart';

class DotLoader extends StatefulWidget {
  const DotLoader({Key? key}) : super(key: key);

  @override
  _DotLoaderState createState() => _DotLoaderState();
}

class _DotLoaderState extends State<DotLoader> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  late AnimationController controller3;

  late Animation<double> _animation;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  ValueNotifier<bool> isLastVisible = ValueNotifier(false);
  ValueNotifier<bool> isFirstVisible = ValueNotifier(false);
  ValueNotifier<bool> isSecondVisible = ValueNotifier(false);
  ValueNotifier<bool> isThirdVisible = ValueNotifier(false);
  ValueNotifier<bool> isFirstStillVisible = ValueNotifier(false);

  double circleSize = 10;
  int totalDuration = 900;
  double max = 70;
  bool exitingAnimation = false;
  int lastMove = 0;
  double dotsPaddingLeft = 20;

  double? containerHeight;

  @override
  dispose() {
    controller.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    containerHeight = circleSize + 40;

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: totalDuration));
    controller2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: totalDuration));
    controller3 = AnimationController(
        vsync: this, duration: Duration(milliseconds: totalDuration));

    _animation = Tween<double>(
      begin: 0,
      end: max,
    ).animate(controller);

    _animation2 = Tween<double>(
      begin: 0,
      end: max,
    ).animate(controller2);

    _animation3 = Tween<double>(
      begin: 0,
      end: max,
    ).animate(controller3);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.forward) {
        if (lastMove == 5) {
          isFirstStillVisible.value = false;
        }
      }
      if (status == AnimationStatus.completed) {
        if (lastMove == 5) {
          isFirstVisible.value = false;
          isLastVisible.value = false;
          return;
        }

        if (exitingAnimation) {
          if (lastMove == 1) {
            lastMove = 5;
            controller.reset();
            controller.forward();
          } else {
            isFirstVisible.value = false;
          }
        } else {
          controller.reset();
          controller.forward();
        }
      }
    });

    controller2.addStatusListener((status) async {
      if (status == AnimationStatus.forward) {
        if (lastMove == 20) {
          isFirstStillVisible.value = false;
        }
      }
      if (status == AnimationStatus.completed) {
        if (lastMove == 20) {
          isSecondVisible.value = false;
          isLastVisible.value = false;
          return;
        }

        if (exitingAnimation) {
          if (lastMove == 2) {
            lastMove = 20;
            controller2.reset();
            controller2.forward();
          } else {
            isSecondVisible.value = false;
          }
        } else {
          controller2.reset();
          controller2.forward();
        }
      }
    });

    controller3.addStatusListener((status) async {
      if (status == AnimationStatus.forward) {
        if (lastMove == 30) {
          isFirstStillVisible.value = false;
        }
      }
      if (status == AnimationStatus.completed) {
        if (lastMove == 30) {
          isThirdVisible.value = false;
          isLastVisible.value = false;
          return;
        }

        if (exitingAnimation) {
          if (lastMove == 3) {
            lastMove = 30;
            controller3.reset();
            controller3.forward();
          } else {
            isThirdVisible.value = false;
          }
        } else {
          controller3.reset();
          controller3.forward();
        }
      }
    });

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 200));
      startDotAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: Colors.white)),
        Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            width: circleSize + max + dotsPaddingLeft * 2,
            height: containerHeight,
            duration: const Duration(milliseconds: 500),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ValueListenableBuilder(
                    valueListenable: isFirstVisible,
                    builder: (context, bool isVis, _) {
                      return Visibility(
                        visible: isVis,
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (context, _) {
                            return Positioned(
                                left: _animation.value + dotsPaddingLeft,
                                child: const Circle());
                          },
                        ),
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: isSecondVisible,
                    builder: (context, bool isVis, _) {
                      return Visibility(
                        visible: isVis,
                        child: AnimatedBuilder(
                          animation: controller2,
                          builder: (context, _) {
                            return Positioned(
                                left: _animation2.value + dotsPaddingLeft,
                                child: const Circle());
                          },
                        ),
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: isThirdVisible,
                    builder: (context, bool isVis, _) {
                      return Visibility(
                        visible: isVis,
                        child: AnimatedBuilder(
                          animation: controller3,
                          builder: (context, _) {
                            return Positioned(
                                left: _animation3.value + dotsPaddingLeft,
                                child: const Circle());
                          },
                        ),
                      );
                    }),
                Positioned(
                    left: max + dotsPaddingLeft,
                    child: ValueListenableBuilder(
                        valueListenable: isLastVisible,
                        builder: (context, bool val, _) {
                          return Visibility(
                              visible: val, child: const Circle());
                        })),
                Positioned(
                    left: 0 + dotsPaddingLeft,
                    child: ValueListenableBuilder(
                        valueListenable: isFirstStillVisible,
                        builder: (context, bool val, _) {
                          return Visibility(
                              visible: val, child: const Circle());
                        })),
              ],
            ),
          ),
        )
      ],
    );
  }

  void stopDotAnimation() async {
    double v1 = controller.value;
    double v2 = controller2.value;
    double v3 = controller3.value;

    double largest = [v1, v2, v3]
        .reduce((value, element) => value > element ? value : element);
    if (largest == v1) {
      lastMove = 1;
    } else if (largest == v2) {
      lastMove = 2;
    } else {
      lastMove = 3;
    }
    exitingAnimation = true;
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  void startDotAnimation() async {
    isFirstVisible.value = true;
    isSecondVisible.value = true;
    isThirdVisible.value = true;
    isFirstStillVisible.value = true;

    Future.delayed(Duration(milliseconds: totalDuration), () {
      isLastVisible.value = true;
    });
    if (mounted) controller.forward();
    await Future.delayed(Duration(milliseconds: totalDuration ~/ 3));
    if (mounted) controller2.forward();
    await Future.delayed(Duration(milliseconds: totalDuration ~/ 3));
    if (mounted) controller3.forward();
  }
}
