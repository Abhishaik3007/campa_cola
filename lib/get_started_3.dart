import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animations.dart';
import 'responsive.dart';

const Color _crimson = Color(0xFFA20314);
const Color _ink = Color(0xFF161414);
const Color _subtitle = Color(0xFF5A5251);
const Color _featureSub = Color(0xFF6A6162);
const Color _back = Color(0xFF3A3536);
const Color _badge = Color(0xFFFED0D0);
const Color _dotInactive = Color(0xFFFAC9C8);
const Color _handInk = Color(0xFF2B2425);
const Color _brush = Color(0xFFF7C0C2);

/// Blush field behind the third screen, slightly deeper toward the bottom.
const Color screenThreeBgTop = Color(0xFFFEEAE6);
const Color screenThreeBgBottom = Color(0xFFFDE8E5);

/// Size of the screen body (below the brand header) in the design, in dp.
/// All measurements below are taken on this canvas and converted to the
/// device with [Responsive].
const Size _designSize = Size(384, 735);

/// Third get-started screen: "Give every outfit a second life."
class GetStarted3 extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onBack;

  const GetStarted3({
    super.key,
    required this.onGetStarted,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final r = Responsive(constraints, _designSize);
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox.fromSize(
            size: r.canvasSize,
            child: _Canvas(r: r, onGetStarted: onGetStarted, onBack: onBack),
          ),
        );
      },
    );
  }
}

class _Canvas extends StatelessWidget {
  final Responsive r;
  final VoidCallback onGetStarted;
  final VoidCallback onBack;

  const _Canvas({
    required this.r,
    required this.onGetStarted,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: RepaintBoundary(
              child: CustomPaint(
                painter: _BrushPainter(r),
                isComplex: true,
                willChange: false,
              ),
            ),
          ),
        ),

        // Headline. The italic line is set larger than the roman one.
        Positioned(
          left: r.dp(31),
          top: r.dp(21.3),
          child: Text(
            'Give every outfit',
            style: GoogleFonts.playfairDisplay(
              fontSize: r.dp(47.5),
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: _ink,
              letterSpacing: r.dp(-1.22),
            ),
          ),
        ),
        Positioned(
          left: r.dp(34.5),
          top: r.dp(66.3),
          child: Text(
            'a second life.',
            style: GoogleFonts.playfairDisplay(
              fontSize: r.dp(49),
              height: 1.0,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              color: _crimson,
              letterSpacing: r.dp(-1.1),
            ),
          ),
        ),

        // Subtitle
        Positioned(
          left: r.dp(33.5),
          top: r.dp(125.5),
          child: Text(
            'Sell or rent what you love, and\nmake room for your next favorite.',
            style: GoogleFonts.inter(
              fontSize: r.dp(17),
              height: 1.353,
              fontWeight: FontWeight.w400,
              color: _subtitle,
              letterSpacing: r.dp(-0.1),
            ),
          ),
        ),

        // Model photo, cut out of the reference so the painted background
        // shows around her.
        Positioned(
          left: 0,
          top: r.dp(173.9),
          width: r.dp(237.0),
          height: r.dp(504.8),
          child: IgnorePointer(
            child: Image.asset(
              'assets/images/Get_started_3.png',
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),

        // Burst marks beside her head
        Positioned.fill(
          child: IgnorePointer(child: CustomPaint(painter: _BurstPainter(r))),
        ),

        // Sell / Rent / Buy
        _Feature(
          r: r,
          centerY: 234.5,
          icon: const _HangerIconPainter(),
          title: 'Sell',
          subtitle: 'Turn your\ncloset into cash.',
        ),
        _Feature(
          r: r,
          centerY: 319.5,
          icon: const _RefreshIconPainter(),
          title: 'Rent',
          subtitle: 'Wear more,\nspend less.',
        ),
        _Feature(
          r: r,
          centerY: 402.5,
          icon: const _HeartIconPainter(),
          title: 'Buy',
          subtitle: 'Find your\nnext favorite.',
        ),

        // Handwritten note, centred lines rotated about the block centre.
        Positioned(
          left: r.dp(294.5 - 90),
          top: r.dp(511.5 - 35),
          width: r.dp(180),
          height: r.dp(70),
          child: IgnorePointer(
            child: Transform.rotate(
              angle: -0.34,
              child: Center(
                child: Stack(
                  children: [
                    _HandNote(r: r, stroke: false),
                    // Traces the glyphs again to match the heavier pen line.
                    _HandNote(r: r, stroke: true),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _FlourishPainter(r)),
          ),
        ),

        // Page indicator
        for (var i = 0; i < 3; i++)
          Positioned(
            left: r.dp(165.5 + i * 27.25 - 6.4),
            top: r.dp(643.5 - 6.4),
            child: Container(
              width: r.dp(12.8),
              height: r.dp(12.8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == 2 ? _crimson : _dotInactive,
              ),
            ),
          ),

        // Back
        Positioned(
          left: r.dp(18),
          top: r.dp(687),
          child: BouncyButton(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: r.dp(12),
                vertical: r.dp(10),
              ),
              child: Text(
                'Back',
                style: GoogleFonts.inter(
                  fontSize: r.dp(17),
                  height: 1.0,
                  fontWeight: FontWeight.w400,
                  color: _back,
                  letterSpacing: r.dp(-0.2),
                ),
              ),
            ),
          ),
        ),

        // Get Started
        Positioned(
          left: r.dp(189),
          top: r.dp(671.5),
          child: BouncyButton(
            onTap: onGetStarted,
            child: Container(
              width: r.dp(178),
              height: r.dp(52),
              decoration: BoxDecoration(
                color: _crimson,
                borderRadius: BorderRadius.circular(r.dp(26)),
              ),
              padding: EdgeInsets.only(left: r.dp(35)),
              child: Row(
                children: [
                  Text(
                    'Get Started',
                    style: GoogleFonts.inter(
                      fontSize: r.dp(16.3),
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      letterSpacing: r.dp(-0.2),
                    ),
                  ),
                  SizedBox(width: r.dp(13)),
                  SizedBox(
                    width: r.dp(17),
                    height: r.dp(14),
                    child: CustomPaint(painter: _ArrowPainter(r)),
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

class _HandNote extends StatelessWidget {
  final Responsive r;
  final bool stroke;
  const _HandNote({required this.r, required this.stroke});

  @override
  Widget build(BuildContext context) {
    final paint = Paint()..color = _handInk;
    if (stroke) {
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = r.dp(0.8)
        ..strokeJoin = StrokeJoin.round;
    }
    return Text(
      'Same Campus.\nMore Possibilities.',
      textAlign: TextAlign.center,
      softWrap: false,
      style: GoogleFonts.moonDance(
        fontSize: r.dp(26.5),
        height: 1.23,
        foreground: paint,
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final Responsive r;

  /// Vertical centre of the row on the design canvas.
  final double centerY;
  final CustomPainter icon;
  final String title;
  final String subtitle;

  const _Feature({
    required this.r,
    required this.centerY,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const badge = 60.0;
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            left: r.dp(247 - badge / 2),
            top: r.dp(centerY - badge / 2),
            child: Container(
              width: r.dp(badge),
              height: r.dp(badge),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: _badge,
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: r.dp(33),
                height: r.dp(33),
                child: CustomPaint(painter: icon),
              ),
            ),
          ),
          // The title baseline sits 7dp above the badge centre.
          Positioned(
            left: r.dp(291.5),
            top: r.dp(centerY - 7 - 12.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: r.dp(14.2),
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: _ink,
                  ),
                ),
                SizedBox(height: r.dp(2.5)),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: r.dp(11.8),
                    height: 1.27,
                    fontWeight: FontWeight.w400,
                    color: _featureSub,
                    letterSpacing: r.dp(-0.1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Paint _iconStroke(Size size) => Paint()
  ..color = _crimson
  ..style = PaintingStyle.stroke
  ..strokeWidth = size.width * 0.06
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round;

class _HangerIconPainter extends CustomPainter {
  const _HangerIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = _iconStroke(size);
    final path = Path()
      // hook
      ..moveTo(w * 0.40, h * 0.30)
      ..cubicTo(w * 0.40, h * 0.18, w * 0.47, h * 0.14, w * 0.52, h * 0.14)
      ..cubicTo(w * 0.59, h * 0.14, w * 0.63, h * 0.20, w * 0.62, h * 0.26)
      ..cubicTo(w * 0.61, h * 0.32, w * 0.52, h * 0.34, w * 0.51, h * 0.42)
      // shoulders and bar
      ..lineTo(w * 0.07, h * 0.72)
      ..quadraticBezierTo(w * 0.02, h * 0.80, w * 0.10, h * 0.81)
      ..lineTo(w * 0.90, h * 0.81)
      ..quadraticBezierTo(w * 0.98, h * 0.80, w * 0.93, h * 0.72)
      ..lineTo(w * 0.51, h * 0.42);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Two arcs chasing each other, each ending in an arrow head.
class _RefreshIconPainter extends CustomPainter {
  const _RefreshIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = _iconStroke(size);
    final c = Offset(w / 2, h / 2);
    final r = w * 0.36;
    final rect = Rect.fromCircle(center: c, radius: r);
    const start = 195 * math.pi / 180;
    const sweep = 140 * math.pi / 180;

    // Upper arc runs clockwise from the left over the top; the lower arc is
    // the same arc turned half a revolution.
    canvas.drawArc(rect, start, sweep, false, paint);
    canvas.drawArc(rect, start - math.pi, sweep, false, paint);

    // Arrow head at the end of each arc, opening back along the curve.
    void head(double angle) {
      final tip = c + Offset(math.cos(angle), math.sin(angle)) * r;
      final back = Offset(math.sin(angle), -math.cos(angle));
      final a = w * 0.2;
      Offset wing(double turn) {
        final cs = math.cos(turn);
        final sn = math.sin(turn);
        return tip +
            Offset(back.dx * cs - back.dy * sn, back.dx * sn + back.dy * cs) *
                a;
      }

      canvas.drawPath(
        Path()
          ..moveTo(wing(0.75).dx, wing(0.75).dy)
          ..lineTo(tip.dx, tip.dy)
          ..lineTo(wing(-0.75).dx, wing(-0.75).dy),
        paint,
      );
    }

    head(start + sweep);
    head(start - math.pi + sweep);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeartIconPainter extends CustomPainter {
  const _HeartIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = _iconStroke(size);
    final path = Path()
      ..moveTo(w * 0.5, h * 0.88)
      ..cubicTo(w * 0.10, h * 0.58, w * 0.02, h * 0.36, w * 0.10, h * 0.24)
      ..cubicTo(w * 0.20, h * 0.08, w * 0.42, h * 0.10, w * 0.5, h * 0.27)
      ..cubicTo(w * 0.58, h * 0.10, w * 0.80, h * 0.08, w * 0.90, h * 0.24)
      ..cubicTo(w * 0.98, h * 0.36, w * 0.90, h * 0.58, w * 0.5, h * 0.88)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Thin right arrow used on the Get Started button.
class _ArrowPainter extends CustomPainter {
  final Responsive r;

  const _ArrowPainter(this.r);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final inset = r.dp(0.8);
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = r.dp(1.6)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawLine(Offset(r.dp(0.5), h / 2), Offset(w - inset, h / 2), paint);
    canvas.drawPath(
      Path()
        ..moveTo(w - h / 2, inset)
        ..lineTo(w - inset, h / 2)
        ..lineTo(w - h / 2, h - inset),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}

/// Three short strokes radiating beside the model's head.
class _BurstPainter extends CustomPainter {
  final Responsive r;

  const _BurstPainter(this.r);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _crimson
      ..strokeWidth = r.dp(1.9)
      ..strokeCap = StrokeCap.round;
    const lines = <(Offset, Offset)>[
      (Offset(27, 222.5), Offset(47, 235.5)),
      (Offset(33, 204.5), Offset(54, 228.5)),
      (Offset(49, 195.5), Offset(61, 223.5)),
    ];
    for (final (a, b) in lines) {
      canvas.drawLine(r.point(a), r.point(b), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BurstPainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}

/// Pen flourish under the handwritten note: a long rising stroke that
/// doubles back into a small zigzag.
class _FlourishPainter extends CustomPainter {
  final Responsive r;

  const _FlourishPainter(this.r);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _crimson
      ..style = PaintingStyle.stroke
      ..strokeWidth = r.dp(1.6)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(r.dp(279), r.dp(565.5))
      ..quadraticBezierTo(r.dp(320), r.dp(548), r.dp(351), r.dp(537.5))
      ..lineTo(r.dp(309), r.dp(559.5))
      ..lineTo(r.dp(320), r.dp(561.5))
      ..lineTo(r.dp(304), r.dp(576));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _FlourishPainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}

/// Dry marker swipes: a broad band rising behind the model and lighter
/// strokes beside her right sleeve.
class _BrushPainter extends CustomPainter {
  final Responsive r;

  const _BrushPainter(this.r);

  // centre, length, width, angle (radians, negative rises to the right),
  // strength — all on the design canvas
  static const _swipes = <(Offset, double, double, double, double)>[
    (Offset(50, 268), 80, 22, -0.55, 0.38),
    (Offset(28, 292), 130, 50, -0.6, 0.4),
    (Offset(10, 335), 140, 56, -0.65, 0.42),
    (Offset(0, 385), 110, 50, -0.7, 0.5),
    (Offset(225, 452), 70, 26, -0.75, 0.38),
    (Offset(208, 520), 120, 20, -1.35, 0.38),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(11);
    for (final (c, len, width, angle, strength) in _swipes) {
      _swipe(canvas, rnd, c, angle, len, width, strength);
    }
  }

  void _swipe(
    Canvas canvas,
    math.Random rnd,
    Offset c,
    double angle,
    double len,
    double width,
    double strength,
  ) {
    final u = Offset(math.cos(angle), math.sin(angle));
    final n = Offset(-u.dy, u.dx);
    // The bristle count stays tied to the design width so the random
    // sequence, and with it the texture, is the same on every device.
    final bristles = (width * 1.2).round();
    for (var i = 0; i < bristles; i++) {
      final off = (rnd.nextDouble() - 0.5) * width;
      final edge = off.abs() / (width / 2);
      final l = len * (0.7 + rnd.nextDouble() * 0.3) * (1 - edge * 0.35);
      final shift = (rnd.nextDouble() - 0.5) * len * 0.18;
      final a = c + n * off + u * (shift - l / 2);
      final b = c + n * off + u * (shift + l / 2);
      final paint = Paint()
        ..color = _brush.withValues(
          alpha: (0.18 + rnd.nextDouble() * 0.22) * (1 - edge * 0.4) * strength,
        )
        ..strokeWidth = r.dp(1.5 + rnd.nextDouble() * 2.5)
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(r.point(a), r.point(b), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BrushPainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}
