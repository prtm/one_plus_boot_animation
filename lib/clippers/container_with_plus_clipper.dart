import 'package:flutter/material.dart';

class LogoContainerWithPlusClipper extends CustomClipper<Path> {
  const LogoContainerWithPlusClipper(
      {@required this.thickness,
      @required this.iconSize,
      this.spaceBetweenPlusAndContainer = 8.0,
      this.increaseLeftBottomAnimationValue,
      this.decreaseTopRightAnimationValue});

  final double decreaseTopRightAnimationValue;
  final double iconSize;
  final double increaseLeftBottomAnimationValue;
  final double spaceBetweenPlusAndContainer;
  final double thickness;

  @override
  Path getClip(Size size) {
    var barSize = iconSize / 2 - thickness / 2;
    var totalSpace = iconSize + spaceBetweenPlusAndContainer;

    var plusPath = Path()
      ..moveTo(size.width - iconSize / 2 - thickness / 2,
          barSize * (1 - decreaseTopRightAnimationValue))
      ..relativeLineTo(thickness, 0.0)
      ..relativeLineTo(0.0, barSize * decreaseTopRightAnimationValue)
      ..relativeLineTo(barSize * decreaseTopRightAnimationValue, 0)
      ..relativeLineTo(0, thickness)
      ..relativeLineTo(-barSize * decreaseTopRightAnimationValue, 0.0)
      ..relativeLineTo(
          0.0,
          barSize +
              (spaceBetweenPlusAndContainer * increaseLeftBottomAnimationValue))
      ..relativeLineTo(-thickness, 0.0)
      ..relativeLineTo(
          0.0,
          -barSize -
              (spaceBetweenPlusAndContainer * increaseLeftBottomAnimationValue))
      ..relativeLineTo(
          -barSize -
              (spaceBetweenPlusAndContainer * increaseLeftBottomAnimationValue),
          0.0)
      ..relativeLineTo(0.0, -thickness)
      ..relativeLineTo(
          barSize +
              (spaceBetweenPlusAndContainer * increaseLeftBottomAnimationValue),
          0.0)
      ..close();

    var containerPath = Path()
      ..moveTo(0.0, barSize)
      ..relativeLineTo(0.0, size.height)
      ..relativeLineTo(size.width - barSize, 0.0)
      ..lineTo(size.width - barSize, totalSpace)
      ..relativeLineTo(-thickness, 0.0)
      ..lineTo(size.width - thickness - barSize, size.height - thickness)
      ..lineTo(thickness, size.height - thickness)
      ..lineTo(thickness, barSize + thickness)
      ..lineTo(size.width - totalSpace, barSize + thickness)
      ..relativeLineTo(0.0, -thickness)
      ..close();
    containerPath.addPath(plusPath, Offset.zero);

    return containerPath;
  }

  @override
  bool shouldReclip(LogoContainerWithPlusClipper oldClipper) => true;

  // @override
  // bool shouldReclip(LogoContainerWithPlusClipper oldClipper) =>
  //     oldClipper.spaceBetweenPlusAndContainer != spaceBetweenPlusAndContainer ||
  //     oldClipper.iconSize != iconSize ||
  //     oldClipper.thickness != thickness ||
  //     oldClipper.increaseLeftBottomAnimationValue !=
  //         increaseLeftBottomAnimationValue ||
  //     oldClipper.decreaseTopRightAnimationValue !=
  //         decreaseTopRightAnimationValue;

}
