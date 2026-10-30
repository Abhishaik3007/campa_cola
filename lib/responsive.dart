import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Turns measurements from a screen's design into sizes for the space the
/// screen actually gets on the current device.
///
/// Each screen is designed once on a fixed canvas ([designSize], in dp). The
/// [scale] is worked out from the real layout constraints, so every position,
/// size, font size and stroke grows on bigger phones and shrinks on smaller
/// ones while the layout keeps its proportions.
///
/// ```dart
/// LayoutBuilder(builder: (context, constraints) {
///   final r = Responsive(constraints, const Size(384, 735));
///   return Positioned(left: r.dp(31), top: r.dp(21.3), child: ...);
/// });
/// ```
class Responsive {
  Responsive(BoxConstraints constraints, this.designSize)
    : scale = math.min(
        constraints.maxWidth / designSize.width,
        constraints.maxHeight / designSize.height,
      );

  /// Size of the screen in the design, in dp.
  final Size designSize;

  /// How many real dp one design dp takes up on this device. Width and height
  /// share one factor so circles stay round and text keeps its shape.
  final double scale;

  /// Area the screen occupies on this device.
  Size get canvasSize => designSize * scale;

  /// Converts one design measurement: a position, width, height, font size,
  /// letter spacing, padding, radius or stroke width.
  double dp(double value) => value * scale;

  /// Converts a design point.
  Offset point(Offset designPoint) => designPoint * scale;

  /// Converts a design rectangle.
  Rect box(Rect designRect) => Rect.fromLTWH(
    designRect.left * scale,
    designRect.top * scale,
    designRect.width * scale,
    designRect.height * scale,
  );
}
