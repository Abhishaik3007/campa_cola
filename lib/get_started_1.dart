import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'responsive.dart';

const Color _crimson = Color(0xFFB40008);
const Color _ink = Color(0xFF161414);
const Color _subtitle = Color(0xFF4A4546);
const Color _skip = Color(0xFF4E4A49);
const Color _dotInactive = Color(0xFFFCB8B9);
const Color _tape = Color(0xD9FCA9AF);
const Color _frame = Color(0xFFFDF8F4);
const Color _brush = Color(0xFFF9BCBE);
const Color _doodleRed = Color(0xFFC8101C);
const Color _doodlePink = Color(0xFFF2A2A8);

/// Size of the screen body (below the brand header) in the design, in dp.
/// All measurements below are taken on this canvas and converted to the
/// device with [Responsive].
const Size _designSize = Size(384, 712);

/// First get-started screen: "Your closet, your campus, your way."
class GetStarted1 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const GetStarted1({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final r = Responsive(constraints, _designSize);
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox.fromSize(
            size: r.canvasSize,
            child: _Canvas(r: r, onNext: onNext, onSkip: onSkip),
          ),
        );
      },
    );
  }
}

class _Canvas extends StatelessWidget {
  final Responsive r;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const _Canvas({required this.r, required this.onNext, required this.onSkip});

  TextStyle _headline(
    Color color, {
    bool italic = false,
    required double letterSpacing,
  }) {
    return GoogleFonts.playfairDisplay(
      fontSize: r.dp(55.5),
      height: 0.85,
      fontWeight: FontWeight.w700,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color,
      letterSpacing: r.dp(letterSpacing),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _BrushPainter(r),
              isComplex: true,
              willChange: false,
            ),
          ),
        ),

        // Headline
        // Each line is placed on its own so the uneven line spacing matches.
        Positioned(
          left: r.dp(28),
          top: r.dp(25.4),
          child: Text(
            'Your closet,',
            style: _headline(_ink, letterSpacing: -1.9),
          ),
        ),
        Positioned(
          left: r.dp(28),
          top: r.dp(77.0),
          child: Text(
            'your campus,',
            style: _headline(_crimson, italic: true, letterSpacing: -0.9),
          ),
        ),
        Positioned(
          left: r.dp(28),
          top: r.dp(120.3),
          child: Text(
            'your way.',
            style: _headline(_ink, letterSpacing: -1.55),
          ),
        ),

        // Subtitle
        Positioned(
          left: r.dp(33),
          top: r.dp(176),
          child: Text(
            'Discover pre-loved fashion\nfrom students around you.',
            style: GoogleFonts.inter(
              fontSize: r.dp(19.5),
              height: 1.36,
              fontWeight: FontWeight.w400,
              color: _subtitle,
              letterSpacing: r.dp(-0.15),
            ),
          ),
        ),

        // Doodles around the headline and subtitle
        _Marks(
          r: r,
          lines: const [
            [Offset(278.7, 37.5), Offset(291.0, 13.5)],
            [Offset(285.3, 48.4), Offset(310.0, 23.1)],
            [Offset(296.2, 54.0), Offset(310.0, 49.2)],
          ],
        ),
        _Heart(
          r: r,
          rect: const Rect.fromLTWH(328.8, 59.3, 35, 45.7),
          color: _doodlePink,
          angle: 0.18,
        ),
        _Heart(
          r: r,
          rect: const Rect.fromLTWH(263, 216, 33, 43),
          color: _doodleRed,
          angle: -0.12,
        ),
        _Squiggle(
          r: r,
          points: const [
            Offset(18, 246),
            Offset(58, 232),
            Offset(70, 244),
            Offset(92, 230),
            Offset(98, 241),
            Offset(165, 229),
          ],
          color: _doodlePink,
        ),
        _Marks(
          r: r,
          lines: const [
            [Offset(63.0, 288.0), Offset(85.5, 301.0)],
            [Offset(72.0, 271.0), Offset(93.4, 292.0)],
            [Offset(93.4, 264.6), Offset(102.3, 288.0)],
          ],
        ),
        _Sparkle(r: r, rect: const Rect.fromLTWH(325, 309, 26.5, 34)),
        _Marks(
          r: r,
          lines: const [
            [Offset(349.0, 379.0), Offset(361.0, 363.0)],
            [Offset(356.8, 388.0), Offset(373.6, 376.0)],
          ],
        ),

        // Polaroid collage. The centre frame sits behind the two side frames.
        _Polaroid(
          r: r,
          center: const Offset(197, 381),
          width: 175,
          height: 232,
          angle: 0.155,
          asset: 'assets/images/collage-center-cut.png',
          view: const Rect.fromLTWH(258, 8, 506.53, 660),
          tapeDx: 0.445,
          tapeSize: const Size(43, 18),
          tapeAngle: -0.03,
        ),
        _Polaroid(
          r: r,
          center: const Offset(93.2, 477.2),
          width: 139,
          height: 202.5,
          angle: -0.286,
          asset: 'assets/images/collage-left-cut.png',
          view: const Rect.fromLTWH(420, 0, 471.3, 682),
          tapeDx: 0.5,
          tapeSize: const Size(34, 16),
          tapeAngle: 0.04,
        ),
        _Polaroid(
          r: r,
          center: const Offset(301.3, 488.5),
          width: 134,
          height: 193,
          angle: 0.31,
          asset: 'assets/images/collage-right-cut.png',
          view: const Rect.fromLTWH(468, 150, 372.31, 532),
          tapeDx: 0.42,
          tapeSize: const Size(34, 16),
          tapeAngle: -0.04,
        ),

        // Doodles drawn over and below the collage
        _Heart(
          r: r,
          rect: const Rect.fromLTWH(20, 421, 18, 22),
          color: _doodleRed,
          angle: -0.2,
        ),
        _Heart(
          r: r,
          rect: const Rect.fromLTWH(184.7, 514, 24, 30),
          color: _doodleRed,
          angle: 0.08,
        ),
        _Squiggle(
          r: r,
          points: const [
            Offset(132, 597),
            Offset(172, 578),
            Offset(181, 589),
            Offset(190, 577),
            Offset(198, 590),
            Offset(246, 588),
          ],
          color: _doodlePink,
        ),

        // Page indicator
        for (var i = 0; i < 3; i++)
          Positioned(
            left: r.dp(163.3 + i * 28.55 - 7.4),
            top: r.dp(621.7 - 7.4),
            child: Container(
              width: r.dp(14.8),
              height: r.dp(14.8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == 0 ? _crimson : _dotInactive,
              ),
            ),
          ),

        // Skip
        Positioned(
          left: r.dp(17),
          top: r.dp(653.6),
          child: GestureDetector(
            onTap: onSkip,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: r.dp(12),
                vertical: r.dp(10),
              ),
              child: Text(
                'Skip',
                style: GoogleFonts.inter(
                  fontSize: r.dp(23),
                  height: 1.0,
                  fontWeight: FontWeight.w400,
                  color: _skip,
                ),
              ),
            ),
          ),
        ),

        // Next
        Positioned(
          left: r.dp(202),
          top: r.dp(643),
          child: GestureDetector(
            onTap: onNext,
            child: Container(
              width: r.dp(165.5),
              height: r.dp(55.8),
              decoration: BoxDecoration(
                color: _crimson,
                borderRadius: BorderRadius.circular(r.dp(28)),
              ),
              padding: EdgeInsets.only(left: r.dp(52)),
              child: Row(
                children: [
                  Text(
                    'Next',
                    style: GoogleFonts.inter(
                      fontSize: r.dp(20),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: r.dp(18)),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: r.dp(25),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Polaroid extends StatelessWidget {
  final Responsive r;
  final Offset center;
  final double width;
  final double height;
  final double angle;
  final String asset;

  /// Window into the original photo, in source pixels. The file is not edited.
  final Rect view;
  final double tapeDx;
  final Size tapeSize;
  final double tapeAngle;

  const _Polaroid({
    required this.r,
    required this.center,
    required this.width,
    required this.height,
    required this.angle,
    required this.asset,
    required this.view,
    required this.tapeDx,
    required this.tapeSize,
    required this.tapeAngle,
  });

  @override
  Widget build(BuildContext context) {
    final w = r.dp(width);
    final h = r.dp(height);
    final side = w * 0.045;
    final chin = w * 0.095;
    final tapeW = r.dp(tapeSize.width);
    final tapeH = r.dp(tapeSize.height);

    return Positioned(
      left: r.dp(center.dx) - w / 2,
      top: r.dp(center.dy) - h / 2,
      width: w,
      height: h,
      child: Transform.rotate(
        angle: angle,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.fromLTRB(side, side, side, chin),
                decoration: BoxDecoration(
                  color: _frame,
                  borderRadius: BorderRadius.circular(r.dp(1.5)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7A3A3A).withValues(alpha: 0.18),
                      blurRadius: r.dp(10),
                      offset: Offset(0, r.dp(4)),
                    ),
                    BoxShadow(
                      color: const Color(0xFF7A3A3A).withValues(alpha: 0.08),
                      blurRadius: r.dp(2),
                      offset: Offset(0, r.dp(1)),
                    ),
                  ],
                ),
                child: ClipRect(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final scale = constraints.maxWidth / view.width;
                      return OverflowBox(
                        alignment: Alignment.topLeft,
                        minWidth: 0,
                        minHeight: 0,
                        maxWidth: double.infinity,
                        maxHeight: double.infinity,
                        child: Transform.translate(
                          offset: Offset(-view.left * scale, -view.top * scale),
                          child: Image.asset(
                            asset,
                            width: 1024 * scale,
                            height: 682 * scale,
                            fit: BoxFit.fill,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              left: w * tapeDx - tapeW / 2,
              top: -tapeH * 0.55,
              child: Transform.rotate(
                angle: tapeAngle,
                child: Container(width: tapeW, height: tapeH, color: _tape),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Short hand-drawn emphasis strokes.
class _Marks extends StatelessWidget {
  final Responsive r;
  final List<List<Offset>> lines;
  const _Marks({required this.r, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(painter: _MarksPainter(r, lines)),
      ),
    );
  }
}

class _MarksPainter extends CustomPainter {
  final Responsive r;
  final List<List<Offset>> lines;
  _MarksPainter(this.r, this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _doodleRed
      ..strokeWidth = r.dp(1.9)
      ..strokeCap = StrokeCap.round;
    for (final l in lines) {
      canvas.drawLine(r.point(l[0]), r.point(l[1]), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MarksPainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}

class _Heart extends StatelessWidget {
  final Responsive r;
  final Rect rect;
  final Color color;
  final double angle;
  const _Heart({
    required this.r,
    required this.rect,
    required this.color,
    this.angle = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: r.box(rect),
      child: IgnorePointer(
        child: Transform.rotate(
          angle: angle,
          child: CustomPaint(painter: _HeartPainter(r, color)),
        ),
      ),
    );
  }
}

class _HeartPainter extends CustomPainter {
  final Responsive r;
  final Color color;
  _HeartPainter(this.r, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    // The pen width follows the heart's design size, within 1.4 to 2 dp.
    final designPen = (w / r.scale * 0.06).clamp(1.4, 2.0).toDouble();
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = r.dp(designPen)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Hand-drawn heart: the two lobes cross slightly at the bottom tip.
    final path = Path()
      ..moveTo(w * 0.50, h * 0.28)
      ..cubicTo(w * 0.40, h * 0.02, w * 0.02, h * 0.04, w * 0.04, h * 0.34)
      ..cubicTo(w * 0.06, h * 0.58, w * 0.36, h * 0.78, w * 0.52, h * 0.98)
      ..moveTo(w * 0.50, h * 0.28)
      ..cubicTo(w * 0.62, h * 0.04, w * 0.98, h * 0.04, w * 0.96, h * 0.34)
      ..cubicTo(w * 0.94, h * 0.58, w * 0.66, h * 0.78, w * 0.46, h * 0.96);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _HeartPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.r.scale != r.scale;
}

class _Sparkle extends StatelessWidget {
  final Responsive r;
  final Rect rect;
  const _Sparkle({required this.r, required this.rect});

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: r.box(rect),
      child: IgnorePointer(child: CustomPaint(painter: _SparklePainter(r))),
    );
  }
}

class _SparklePainter extends CustomPainter {
  final Responsive r;
  _SparklePainter(this.r);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _doodleRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = r.dp(1.8)
      ..strokeJoin = StrokeJoin.round;
    final cx = size.width / 2;
    final cy = size.height / 2;
    final path = Path()
      ..moveTo(cx, 0)
      ..quadraticBezierTo(
        cx + size.width * 0.06,
        cy - size.height * 0.06,
        size.width,
        cy,
      )
      ..quadraticBezierTo(
        cx + size.width * 0.06,
        cy + size.height * 0.06,
        cx,
        size.height,
      )
      ..quadraticBezierTo(
        cx - size.width * 0.06,
        cy + size.height * 0.06,
        0,
        cy,
      )
      ..quadraticBezierTo(
        cx - size.width * 0.06,
        cy - size.height * 0.06,
        cx,
        0,
      )
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklePainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}

/// Pen squiggle drawn through the given points with rounded turns.
class _Squiggle extends StatelessWidget {
  final Responsive r;
  final List<Offset> points;
  final Color color;
  const _Squiggle({required this.r, required this.points, required this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(painter: _SquigglePainter(r, points, color)),
      ),
    );
  }
}

class _SquigglePainter extends CustomPainter {
  final Responsive r;
  final List<Offset> points;
  final Color color;
  _SquigglePainter(this.r, this.points, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = r.dp(2.0)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final p = points.map(r.point).toList();
    final path = Path()..moveTo(p.first.dx, p.first.dy);
    for (var i = 1; i < p.length - 1; i++) {
      final mid = Offset(
        (p[i].dx + p[i + 1].dx) / 2,
        (p[i].dy + p[i + 1].dy) / 2,
      );
      path.quadraticBezierTo(p[i].dx, p[i].dy, mid.dx, mid.dy);
    }
    path.lineTo(p.last.dx, p.last.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SquigglePainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}

/// Dry-brush marker swipes in the diagonal band behind the collage.
class _BrushPainter extends CustomPainter {
  final Responsive r;
  const _BrushPainter(this.r);

  // Broad marker swipes placed where the reference shows them (design dp):
  // centre, length, width. All swipes rise toward the upper right.
  static const _swipes = <(Offset, double, double)>[
    // right edge, from the heart down beside the collage
    (Offset(372, 140), 100, 22),
    (Offset(335, 182), 160, 28),
    (Offset(312, 214), 170, 26),
    (Offset(352, 236), 150, 32),
    (Offset(345, 268), 120, 26),
    (Offset(360, 296), 130, 32),
    (Offset(370, 330), 110, 34),
    (Offset(362, 362), 110, 30),
    (Offset(372, 400), 90, 30),
    (Offset(372, 480), 110, 36),
    (Offset(372, 560), 100, 34),
    // band under the subtitle
    (Offset(262, 250), 200, 24),
    (Offset(130, 262), 120, 12),
    // left side above the left polaroid
    (Offset(95, 300), 100, 14),
    (Offset(45, 352), 160, 40),
    (Offset(25, 388), 120, 34),
    // left edge and below the left polaroid
    (Offset(10, 450), 100, 30),
    (Offset(10, 520), 110, 34),
    (Offset(40, 580), 170, 40),
    (Offset(70, 604), 170, 26),
    (Offset(160, 585), 120, 18),
    (Offset(300, 590), 140, 20),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(5);
    final angle = math.atan(-0.72);
    for (final (c, len, width) in _swipes) {
      _swipe(
        canvas,
        rnd,
        c,
        angle + (rnd.nextDouble() - 0.5) * 0.12,
        len,
        width,
      );
    }
  }

  /// One dry marker swipe: a dense core of overlapping bristles with ragged
  /// ends and a few loose streaks along the edges. The swipe is worked out in
  /// design dp and converted to the device when drawn.
  void _swipe(
    Canvas canvas,
    math.Random rnd,
    Offset c,
    double angle,
    double len,
    double width,
  ) {
    final u = Offset(math.cos(angle), math.sin(angle));
    final n = Offset(-u.dy, u.dx);
    final bristles = (width * 1.1).round();
    for (var i = 0; i < bristles; i++) {
      final off = (rnd.nextDouble() - 0.5) * width;
      final edge = (off.abs() / (width / 2));
      final l = len * (0.7 + rnd.nextDouble() * 0.3) * (1 - edge * 0.35);
      final shift = (rnd.nextDouble() - 0.5) * len * 0.18;
      final a = c + n * off + u * (shift - l / 2);
      final b =
          c + n * (off + (rnd.nextDouble() - 0.5) * 4) + u * (shift + l / 2);
      final paint = Paint()
        ..color = _brush.withValues(
          alpha: (0.2 + rnd.nextDouble() * 0.26) * (1 - edge * 0.4),
        )
        ..strokeWidth = r.dp(3 + rnd.nextDouble() * 5)
        ..strokeCap = StrokeCap.round;
      var t = 0.0;
      while (t < 1) {
        final t2 = math.min(1.0, t + 0.25 + rnd.nextDouble() * 0.6);
        canvas.drawLine(
          r.point(Offset.lerp(a, b, t)!),
          r.point(Offset.lerp(a, b, t2)!),
          paint,
        );
        t = t2 + rnd.nextDouble() * 0.05;
      }
    }
    // Loose streaks trailing off the swipe.
    final streak = Paint()
      ..color = _brush.withValues(alpha: 0.45)
      ..strokeWidth = r.dp(1.1)
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 3; i++) {
      final off = (rnd.nextDouble() - 0.5) * width * 1.3;
      final l = len * (0.6 + rnd.nextDouble() * 0.5);
      canvas.drawLine(
        r.point(c + n * off - u * (l / 2)),
        r.point(c + n * off + u * (l / 2)),
        streak,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BrushPainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}
