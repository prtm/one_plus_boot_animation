import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:oneplus_animation/clippers/container_with_plus_clipper.dart';
import 'package:oneplus_animation/clippers/text_one_clipper.dart';
import 'package:oneplus_animation/styles.dart';
import 'package:vector_math/vector_math.dart' show radians;

class OnePlusLogo extends StatefulWidget {
  const OnePlusLogo({Key key}) : super(key: key);

  @override
  _OnePlusLogoState createState() => _OnePlusLogoState();
}

class _OnePlusLogoState extends State<OnePlusLogo>
    with TickerProviderStateMixin {
  AnimationController _increaseLeftBottomAnimationController;
  AnimationController _decreaseTopRightAnimationController;
  AnimationController _rectTocircleAnimationController;
  AnimationController _innerCircleAnimationController;
  AnimationController _innerOuterCircleCombineAnimationController;
  AnimationController _firstCircleMoveUpAnimationController;
  AnimationController _firstCircleRotateAroundCircleAnimationController;
  AnimationController _secondCircleMoveUpAnimationController;
  AnimationController _secondCircleRotateAroundCircleAnimationController;
  AnimationController _increaseCircleHeightLiquidAnimationController;
  AnimationController _decreaseCircleHeightLiquidAnimationController;
  AnimationController _finalCirclesAnimationController;
  Animation<double> roundnessContainerAnimation;
  Animation<double> outerContainerSizeAnimation;
  Animation<double> innerContainerSizeAnimation;
  Animation<double> innerOuterCircleCombineAnimation;
  Animation<double> firstCircleMoveUpAnimation;
  Animation<double> firstCircleRotateAnimation;
  Animation<double> secondCircleMoveUpAnimation;
  Animation<double> secondCircleRotateAnimation;
  Animation<double> increaseCircleHeightLiquidAnimation;
  Animation<double> decreaseCircleHeightLiquidAnimation;
  Animation<double> finalInnerCircleAnimation;
  Animation<double> finalMiddleCircleAnimation;
  Animation<double> finalOuterCircleAnimation;
  Animation<double> finalOuterCircleRadiusAnimation;
  Animation<double> textSizeAnimation;
  Animation<double> textFadeAnimation;
  Animation<double> increaseLeftBottomAnimation;
  Animation<double> decreaseTopRightAnimation;
  final int circleRotationAnimationSeconds = 2 * 3;

  static const iconSize = 36.0;
  static const containerThickness = iconSize / 4;
  final outerContainerSize = iconSize * 2.2;
  static const outerContainerAfterSmallSize = 40.0;
  final smallCircleForRotationSize = outerContainerAfterSmallSize / 3;
  final stackSize = iconSize * 2.2 + iconSize / 2 - containerThickness / 2;

  @override
  void initState() {
    super.initState();
    _increaseLeftBottomAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _decreaseTopRightAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _rectTocircleAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _innerCircleAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _innerOuterCircleCombineAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _firstCircleMoveUpAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _firstCircleRotateAroundCircleAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _secondCircleMoveUpAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _secondCircleRotateAroundCircleAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _increaseCircleHeightLiquidAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _decreaseCircleHeightLiquidAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _finalCirclesAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _rectTocircleAnimationController.addListener(() {
      setState(() {});
    });
    _finalCirclesAnimationController.addListener(() {
      setState(() {});
    });
    increaseLeftBottomAnimation = Tween<double>(begin: 0, end: 1)
        .animate(_increaseLeftBottomAnimationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _decreaseTopRightAnimationController.forward();
            }
          });
    decreaseTopRightAnimation = Tween<double>(begin: 1, end: 0)
        .animate(_decreaseTopRightAnimationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _rectTocircleAnimationController.forward();
            }
          });

    roundnessContainerAnimation =
        Tween<double>(begin: 0.0, end: outerContainerSize / 2).animate(
      CurvedAnimation(
        parent: _rectTocircleAnimationController,
        curve: Curves.linear,
      ),
    );

    textSizeAnimation = Tween<double>(
            begin: outerContainerSize -
                iconSize / 2 -
                containerThickness / 2 -
                containerThickness,
            end: 0)
        .animate(CurvedAnimation(
      parent: _rectTocircleAnimationController,
      curve: Curves.linear,
    ));
    textFadeAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _rectTocircleAnimationController,
      curve: Curves.fastOutSlowIn,
    ));
    outerContainerSizeAnimation = Tween<double>(
            begin: outerContainerSize, end: outerContainerAfterSmallSize)
        .animate(
      CurvedAnimation(
        parent: _rectTocircleAnimationController,
        curve: Curves.linear,
      ),
    )..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _innerCircleAnimationController.forward();
            }
          });

    innerContainerSizeAnimation = Tween<double>(
            begin: 0, end: outerContainerAfterSmallSize - containerThickness)
        .animate(
      CurvedAnimation(
        parent: _innerCircleAnimationController,
        curve: Curves.linear,
      ),
    )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _innerOuterCircleCombineAnimationController.forward();
            }
          });
    innerOuterCircleCombineAnimation =
        Tween<double>(begin: 0, end: containerThickness).animate(
      CurvedAnimation(
        parent: _innerOuterCircleCombineAnimationController,
        curve: Curves.linear,
      ),
    )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _firstCircleMoveUpAnimationController.forward();
            }
          });
    firstCircleMoveUpAnimation = Tween<double>(
            begin: stackSize / 2 - smallCircleForRotationSize / 2, end: 0)
        .animate(
      CurvedAnimation(
        parent: _firstCircleMoveUpAnimationController,
        curve: Curves.linear,
      ),
    )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              var tickerFuture =
                  _firstCircleRotateAroundCircleAnimationController.repeat();
              tickerFuture
                  .timeout(Duration(seconds: circleRotationAnimationSeconds),
                      onTimeout: () {
                _firstCircleRotateAroundCircleAnimationController.forward(
                    from: 0);
                _firstCircleRotateAroundCircleAnimationController.stop(
                    canceled: true);
              });
              Future.delayed(Duration(milliseconds: 500)).then(
                  (value) => _secondCircleMoveUpAnimationController.forward());
            }
          });
    firstCircleRotateAnimation = Tween<double>(begin: 0, end: 360.0).animate(
      CurvedAnimation(
          parent: _firstCircleRotateAroundCircleAnimationController,
          curve: Interval(
            0.3,
            1,
            curve: Curves.decelerate,
          )),
    )..addListener(() {
        setState(() {});
      });
    secondCircleMoveUpAnimation = Tween<double>(
            begin: stackSize / 2 - smallCircleForRotationSize / 2, end: 0)
        .animate(
      CurvedAnimation(
        parent: _secondCircleMoveUpAnimationController,
        curve: Curves.linear,
      ),
    )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              var tickerFuture =
                  _secondCircleRotateAroundCircleAnimationController.repeat();
              tickerFuture
                  .timeout(Duration(seconds: circleRotationAnimationSeconds),
                      onTimeout: () {
                _secondCircleRotateAroundCircleAnimationController.forward(
                    from: 0);
                _secondCircleRotateAroundCircleAnimationController.stop(
                    canceled: true);
                _increaseCircleHeightLiquidAnimationController.forward();
              });
            }
          });
    secondCircleRotateAnimation = Tween<double>(begin: 0, end: 360.0).animate(
      CurvedAnimation(
          parent: _secondCircleRotateAroundCircleAnimationController,
          curve: Interval(
            0.3,
            1,
            curve: Curves.decelerate,
          )),
    )..addListener(() {
        setState(() {});
      });

    increaseCircleHeightLiquidAnimation = Tween<double>(
            begin: smallCircleForRotationSize,
            end: stackSize / 2 + smallCircleForRotationSize / 2)
        .animate(
      CurvedAnimation(
        parent: _increaseCircleHeightLiquidAnimationController,
        curve: Curves.linear,
      ),
    )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _decreaseCircleHeightLiquidAnimationController.forward();
            }
          });
    decreaseCircleHeightLiquidAnimation = Tween<double>(
            begin: stackSize / 2 + smallCircleForRotationSize / 2,
            end: smallCircleForRotationSize)
        .animate(
      CurvedAnimation(
        parent: _decreaseCircleHeightLiquidAnimationController,
        curve: Curves.linear,
      ),
    )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _finalCirclesAnimationController.forward();
            }
          });
    finalInnerCircleAnimation =
        Tween<double>(begin: 0, end: smallCircleForRotationSize).animate(
      CurvedAnimation(
        parent: _finalCirclesAnimationController,
        curve: Curves.linear,
      ),
    );
    finalMiddleCircleAnimation = Tween<double>(
            begin: smallCircleForRotationSize, end: containerThickness)
        .animate(
      CurvedAnimation(
        parent: _finalCirclesAnimationController,
        curve: Curves.linear,
      ),
    );
    finalOuterCircleAnimation = Tween<double>(
            begin: smallCircleForRotationSize,
            end: stackSize - (iconSize / 2 - containerThickness / 2))
        .animate(
      CurvedAnimation(
        parent: _finalCirclesAnimationController,
        curve: Curves.linear,
      ),
    );
    finalOuterCircleRadiusAnimation = Tween<double>(
            begin: (stackSize - (iconSize / 2 - containerThickness / 2)) / 2,
            end: 2)
        .animate(
      CurvedAnimation(
        parent: _finalCirclesAnimationController,
        curve: Curves.linear,
      ),
    );
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _increaseLeftBottomAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _increaseLeftBottomAnimationController.dispose();
    _decreaseTopRightAnimationController.dispose();
    _rectTocircleAnimationController.dispose();
    _innerCircleAnimationController.dispose();
    _innerOuterCircleCombineAnimationController.dispose();
    _firstCircleMoveUpAnimationController.dispose();
    _firstCircleRotateAroundCircleAnimationController.dispose();
    _secondCircleMoveUpAnimationController.dispose();
    _secondCircleRotateAroundCircleAnimationController.dispose();
    _increaseCircleHeightLiquidAnimationController.dispose();
    _decreaseCircleHeightLiquidAnimationController.dispose();
    _finalCirclesAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var barSize = iconSize / 2 - containerThickness / 2;
    return Container(
      height: stackSize,
      width: stackSize,
      child: Stack(
        children: [
          if ((innerContainerSizeAnimation.isCompleted &&
                  increaseCircleHeightLiquidAnimation.status !=
                      AnimationStatus.completed) &&
              (firstCircleMoveUpAnimation.status == AnimationStatus.forward ||
                  firstCircleRotateAnimation.status == AnimationStatus.forward))
            Positioned(
              top: firstCircleMoveUpAnimation.value,
              left: 0,
              right: 0,
              child: Transform.rotate(
                origin: Offset(0, stackSize / 2 + containerThickness / 2),
                angle: radians(firstCircleRotateAnimation.value),
                child: Container(
                  margin: EdgeInsets.only(
                      right: iconSize / 2 - containerThickness / 2),
                  child: Container(
                    width: smallCircleForRotationSize,
                    height: smallCircleForRotationSize,
                    decoration: BoxDecoration(
                      color: onePlusWhiteColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          if ((innerContainerSizeAnimation.isCompleted &&
                  increaseCircleHeightLiquidAnimation.status !=
                      AnimationStatus.completed) &&
              (secondCircleMoveUpAnimation.status == AnimationStatus.forward ||
                  secondCircleRotateAnimation.status ==
                      AnimationStatus.forward))
            Positioned(
              top: secondCircleMoveUpAnimation.value,
              left: 0,
              right: 0,
              child: Transform.rotate(
                origin: Offset(0, stackSize / 2 + containerThickness / 2),
                angle: radians(secondCircleRotateAnimation.value),
                child: Container(
                  margin: EdgeInsets.only(
                      right: iconSize / 2 - containerThickness / 2),
                  child: Container(
                    width: smallCircleForRotationSize,
                    height: smallCircleForRotationSize,
                    decoration: BoxDecoration(
                      color: onePlusWhiteColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          roundnessContainerAnimation.status == AnimationStatus.forward ||
                  roundnessContainerAnimation.status ==
                      AnimationStatus.completed
              ? Center(
                  child: Container(
                    width: outerContainerSizeAnimation.value,
                    height: outerContainerSizeAnimation.value,
                    margin: EdgeInsets.only(
                        top: iconSize / 2 - containerThickness / 2,
                        right: iconSize / 2 - containerThickness / 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: innerOuterCircleCombineAnimation.isCompleted
                            ? Colors.transparent
                            : onePlusWhiteColor,
                        width: containerThickness -
                            innerOuterCircleCombineAnimation.value,
                      ),
                      borderRadius: BorderRadius.circular(
                          roundnessContainerAnimation.value),
                    ),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: onePlusRedColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: innerOuterCircleCombineAnimation.value,
                            color: onePlusRedColor,
                          ),
                        ),
                        width: innerContainerSizeAnimation.value,
                        height: innerContainerSizeAnimation.value,
                      ),
                    ),
                  ),
                )
              : Positioned.fill(
                  child: ClipPath(
                    clipper: LogoContainerWithPlusClipper(
                      thickness: containerThickness,
                      iconSize: iconSize,
                      increaseLeftBottomAnimationValue:
                          increaseLeftBottomAnimation.value,
                      decreaseTopRightAnimationValue:
                          decreaseTopRightAnimation.value,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: outerContainerSizeAnimation.value,
                      height: outerContainerSizeAnimation.value,
                      decoration: BoxDecoration(
                        color: onePlusWhiteColor,
                        borderRadius: BorderRadius.circular(
                            roundnessContainerAnimation.value),
                      ),
                    ),
                  ),
                ),
          if (increaseCircleHeightLiquidAnimation.status ==
                  AnimationStatus.forward ||
              decreaseCircleHeightLiquidAnimation.status ==
                  AnimationStatus.forward)
            Positioned(
              top: (increaseCircleHeightLiquidAnimation.status ==
                          AnimationStatus.forward ||
                      increaseCircleHeightLiquidAnimation.status !=
                          AnimationStatus.completed)
                  ? 0
                  : null,
              bottom: (increaseCircleHeightLiquidAnimation.status ==
                      AnimationStatus.completed)
                  ? stackSize / 2 - smallCircleForRotationSize
                  : null,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    right: iconSize / 2 - containerThickness / 2),
                child: Container(
                  width: smallCircleForRotationSize,
                  height: increaseCircleHeightLiquidAnimation.status ==
                          AnimationStatus.forward
                      ? increaseCircleHeightLiquidAnimation.value
                      : decreaseCircleHeightLiquidAnimation.value,
                  decoration: BoxDecoration(
                    color: onePlusWhiteColor,
                    borderRadius:
                        BorderRadius.circular(smallCircleForRotationSize),
                  ),
                ),
              ),
            ),
          if (decreaseCircleHeightLiquidAnimation.status ==
              AnimationStatus.completed)
            Positioned.fill(
              top: barSize,
              right: barSize,
              child: Center(
                child: Container(
                  height: finalOuterCircleAnimation.value,
                  width: finalOuterCircleAnimation.value,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: onePlusRedColor,
                    borderRadius: BorderRadius.circular(
                        finalOuterCircleRadiusAnimation.value),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: onePlusWhiteColor,
                          width: finalMiddleCircleAnimation.value),
                    ),
                    child: Container(
                      width: finalInnerCircleAnimation.value,
                      height: finalInnerCircleAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: onePlusRedColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Positioned.fill(
            top: barSize,
            right: barSize,
            child: FadeTransition(
              opacity: textFadeAnimation,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: iconSize / 3.5 + containerThickness),
                child: ClipPath(
                  clipper: TextOneClipper(thickness: containerThickness),
                  child: Container(
                    width: min(iconSize / 1.5, textSizeAnimation.value),
                    height: textSizeAnimation.value,
                    color: onePlusWhiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
