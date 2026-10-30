import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animations.dart';
import 'responsive.dart';

const Color _crimson = Color(0xFFB4030C);
const Color _ink = Color(0xFF161414);
const Color _subtitle = Color(0xFF574F4E);
const Color _featureSub = Color(0xFF5E5455);
const Color _back = Color(0xFF3A3536);
const Color _badge = Color(0xFFFED1D0);
const Color _card = Color(0xFFFEF4F3);
const Color _cardName = Color(0xFF1E1A1A);
const Color _cardHeart = Color(0xFFE47C82);
const Color _dotInactive = Color(0xFFFAC7C6);
const Color _brush = Color(0xFFF7C3C5);

/// Size of the screen body (below the brand header) in the design, in dp.
/// All measurements below are taken on this canvas and converted to the
/// device with [Responsive].
const Size _designSize = Size(384, 730);

/// Second get-started screen: "Buy less. Style more."
class GetStarted2 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const GetStarted2({super.key, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final r = Responsive(constraints, _designSize);
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox.fromSize(
            size: r.canvasSize,
            child: _Canvas(r: r, onNext: onNext, onBack: onBack),
          ),
        );
      },
    );
  }
}

/// The reference heart sits in the header region above the page body.
class GetStarted2Heart extends StatelessWidget {
  const GetStarted2Heart({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(painter: _HeaderHeartPainter());
  }
}

class _Canvas extends StatelessWidget {
  final Responsive r;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Canvas({required this.r, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned.fill(
          child: IgnorePointer(child: CustomPaint(painter: _BrushPainter(r))),
        ),

        // Model photo on the right, tucked behind the product cards.
        Positioned(
          left: r.dp(236),
          top: r.dp(47),
          width: r.dp(160),
          height: r.dp(476),
          child: const _ModelPhoto(),
        ),

        // Burst marks above the model's head
        Positioned.fill(
          child: IgnorePointer(child: CustomPaint(painter: _BurstPainter(r))),
        ),

        // Headline
        Positioned(
          left: r.dp(25.8),
          top: r.dp(31.3),
          child: Text.rich(
            TextSpan(
              style: GoogleFonts.playfairDisplay(
                fontSize: r.dp(51),
                height: 0.882,
                fontWeight: FontWeight.w700,
                color: _ink,
                letterSpacing: r.dp(-1.6),
              ),
              children: [
                const TextSpan(text: 'Buy less.\n'),
                TextSpan(
                  text: 'Style more.',
                  style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: _crimson,
                    letterSpacing: r.dp(-1.2),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Subtitle
        Positioned(
          left: r.dp(25.8),
          top: r.dp(132.7),
          child: Text(
            'Find unique, affordable and\nhigh-quality pre-loved pieces\nfrom students near you.',
            style: GoogleFonts.inter(
              fontSize: r.dp(16),
              height: 1.41,
              fontWeight: FontWeight.w400,
              color: _subtitle,
              letterSpacing: r.dp(-0.1),
            ),
          ),
        ),

        // Feature list
        _Feature(
          r: r,
          centerY: 253,
          icon: const _BagIconPainter(),
          title: 'Trendy finds',
          subtitle: 'New styles every day.',
        ),
        _Feature(
          r: r,
          centerY: 322.5,
          icon: const _CoinsIconPainter(),
          title: 'Student friendly',
          subtitle: 'Great prices.',
        ),
        _Feature(
          r: r,
          centerY: 390,
          icon: const _LeafIconPainter(),
          title: 'Sustainable',
          subtitle: 'Give clothes a second life.',
        ),

        // Product cards
        _ProductCard(
          r: r,
          left: 8,
          asset: 'assets/images/style-more-dress.png',
          name: 'Sequin Mini Dress',
          price: r'$26',
        ),
        _ProductCard(
          r: r,
          left: 131,
          asset: 'assets/images/style-more-bag.png',
          name: 'Shoulder Handbag',
          price: r'$18',
        ),
        _ProductCard(
          r: r,
          left: 254,
          asset: 'assets/images/style-more-heels.png',
          name: 'Strappy Heels',
          price: r'$28',
        ),

        // Page indicator
        for (var i = 0; i < 3; i++)
          Positioned(
            left: r.dp(162.5 + i * 29 - 7.7),
            top: r.dp(634 - 7.7),
            child: Container(
              width: r.dp(15.4),
              height: r.dp(15.4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == 1 ? _crimson : _dotInactive,
              ),
            ),
          ),

        // Back
        Positioned(
          left: r.dp(13),
          top: r.dp(675.6),
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
                  fontSize: r.dp(19),
                  height: 1.0,
                  fontWeight: FontWeight.w400,
                  color: _back,
                  letterSpacing: r.dp(-0.3),
                ),
              ),
            ),
          ),
        ),

        // Next
        Positioned(
          left: r.dp(206),
          top: r.dp(660),
          child: BouncyButton(
            onTap: onNext,
            child: Container(
              width: r.dp(163),
              height: r.dp(58),
              decoration: BoxDecoration(
                color: _crimson,
                borderRadius: BorderRadius.circular(r.dp(29)),
              ),
              padding: EdgeInsets.only(left: r.dp(49)),
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
                  SizedBox(width: r.dp(14)),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: r.dp(26),
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

/// Model photo with its edges and stray reference marks faded out so it
/// Model photo with its bottom edge faded out so it blends behind the product cards.
class _ModelPhoto extends StatelessWidget {
  const _ModelPhoto();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (rect) => const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white, Colors.transparent],
          stops: [0.0, 0.90, 1.0],
        ).createShader(rect),
        child: Image.asset(
          'assets/images/style-more-model.png',
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
          filterQuality: FilterQuality.high,
        ),
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
    const badge = 53.0;
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            left: r.dp(51.3 - badge / 2),
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
                width: r.dp(29),
                height: r.dp(29),
                child: CustomPaint(painter: icon),
              ),
            ),
          ),
          // The title baseline lines up with the badge centre.
          Positioned(
            left: r.dp(94.5),
            top: r.dp(centerY - 13.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: r.dp(14.3),
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: _ink,
                    letterSpacing: r.dp(-0.2),
                  ),
                ),
                SizedBox(height: r.dp(2.5)),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: r.dp(11.5),
                    height: 1.2,
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

class _ProductCard extends StatelessWidget {
  final Responsive r;

  /// Left edge of the card on the design canvas.
  final double left;
  final String asset;
  final String name;
  final String price;

  const _ProductCard({
    required this.r,
    required this.left,
    required this.asset,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: r.dp(left),
      top: r.dp(443),
      width: r.dp(121),
      height: r.dp(158.5),
      child: Container(
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(r.dp(11)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFB4030C).withValues(alpha: 0.06),
              blurRadius: r.dp(8),
              offset: r.point(const Offset(0, 2)),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: r.dp(8),
              top: r.dp(8),
              right: r.dp(8),
              height: r.dp(106),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(r.dp(7)),
                child: Image.asset(
                  asset,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            Positioned(
              left: r.dp(104 - 8),
              top: r.dp(20 - 7.5),
              width: r.dp(16),
              height: r.dp(15),
              child: PulsingHeart(
                child: CustomPaint(painter: _CardHeartPainter(r)),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: r.dp(118.4),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: r.dp(10),
                  height: 1.2,
                  fontWeight: FontWeight.w400,
                  color: _cardName,
                  letterSpacing: r.dp(-0.3),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: r.dp(133.1),
              child: Text(
                price,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: r.dp(15.5),
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: _crimson,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Paint _iconStroke(Size size) => Paint()
  ..color = _crimson
  ..style = PaintingStyle.stroke
  ..strokeWidth = size.width * 0.065
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round;

class _BagIconPainter extends CustomPainter {
  const _BagIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = _iconStroke(size);
    final body = Path()
      ..moveTo(w * 0.17, h * 0.36)
      ..lineTo(w * 0.83, h * 0.36)
      ..lineTo(w * 0.87, h * 0.92)
      ..lineTo(w * 0.13, h * 0.92)
      ..close();
    final handle = Path()
      ..moveTo(w * 0.34, h * 0.46)
      ..lineTo(w * 0.34, h * 0.24)
      ..cubicTo(w * 0.34, h * 0.04, w * 0.66, h * 0.04, w * 0.66, h * 0.24)
      ..lineTo(w * 0.66, h * 0.46);
    canvas.drawPath(body, paint);
    canvas.drawPath(handle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Two stacks of coins seen from the side, the shorter stack in front.
class _CoinsIconPainter extends CustomPainter {
  const _CoinsIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final stroke = _iconStroke(size);
    final fill = Paint()..color = _badge;

    void stack(double left, double bottom, int count) {
      final coinW = w * 0.56;
      final coinH = h * 0.2;
      final step = h * 0.16;
      for (var i = 0; i < count; i++) {
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(left, bottom - coinH - i * step, coinW, coinH),
          Radius.circular(coinH / 2),
        );
        canvas.drawRRect(rect, fill);
        canvas.drawRRect(rect, stroke);
      }
    }

    stack(w * 0.06, h * 0.80, 4);
    stack(w * 0.38, h * 0.96, 3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LeafIconPainter extends CustomPainter {
  const _LeafIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = _iconStroke(size);
    final leaf = Path()
      ..moveTo(w * 0.30, h * 0.80)
      ..cubicTo(w * 0.08, h * 0.60, w * 0.18, h * 0.12, w * 0.86, h * 0.10)
      ..cubicTo(w * 0.92, h * 0.62, w * 0.62, h * 0.90, w * 0.30, h * 0.80);
    final rib = Path()
      ..moveTo(w * 0.12, h * 0.94)
      ..quadraticBezierTo(w * 0.40, h * 0.58, w * 0.66, h * 0.34);
    canvas.drawPath(leaf, paint);
    canvas.drawPath(rib, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CardHeartPainter extends CustomPainter {
  final Responsive r;

  const _CardHeartPainter(this.r);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = _cardHeart
      ..style = PaintingStyle.stroke
      ..strokeWidth = r.dp(1.3)
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(w * 0.5, h * 0.95)
      ..cubicTo(w * 0.05, h * 0.62, w * -0.02, h * 0.28, w * 0.18, h * 0.10)
      ..cubicTo(w * 0.32, h * -0.02, w * 0.46, h * 0.08, w * 0.5, h * 0.22)
      ..cubicTo(w * 0.54, h * 0.08, w * 0.68, h * -0.02, w * 0.82, h * 0.10)
      ..cubicTo(w * 1.02, h * 0.28, w * 0.95, h * 0.62, w * 0.5, h * 0.95)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CardHeartPainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}

/// Three short strokes radiating above the model's head.
class _BurstPainter extends CustomPainter {
  final Responsive r;

  const _BurstPainter(this.r);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _crimson
      ..strokeWidth = r.dp(2.0)
      ..strokeCap = StrokeCap.round;
    const lines = <(Offset, Offset)>[
      (Offset(281, 36), Offset(292, 54)),
      (Offset(300, 17), Offset(301, 51)),
      (Offset(319, 29), Offset(308, 55)),
    ];
    for (final (a, b) in lines) {
      canvas.drawLine(r.point(a), r.point(b), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BurstPainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}

/// Soft marker swipes behind the model and a loose scribble beside her arm.
class _BrushPainter extends CustomPainter {
  final Responsive r;

  const _BrushPainter(this.r);

  @override
  void paint(Canvas canvas, Size size) {
    final swipe = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // (start, end, width, opacity)
    const swipes = <(Offset, Offset, double, double)>[
      (Offset(300, 120), Offset(392, 52), 26, 0.30),
      (Offset(286, 168), Offset(392, 92), 20, 0.22),
      (Offset(340, 210), Offset(392, 170), 30, 0.28),
      (Offset(352, 300), Offset(392, 268), 26, 0.24),
      (Offset(222, 196), Offset(300, 130), 22, 0.32),
      (Offset(212, 226), Offset(290, 168), 14, 0.26),
      (Offset(232, 150), Offset(300, 96), 12, 0.22),
    ];
    for (final (a, b, width, alpha) in swipes) {
      swipe
        ..color = _brush.withValues(alpha: alpha)
        ..strokeWidth = r.dp(width);
      canvas.drawLine(r.point(a), r.point(b), swipe);
    }

    final scribble = Paint()
      ..color = _brush.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r.dp(1.6)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final start = r.point(const Offset(238, 222));
    final path = Path()..moveTo(start.dx, start.dy);
    const zigzag = [
      Offset(214, 248),
      Offset(240, 238),
      Offset(216, 276),
      Offset(242, 262),
      Offset(214, 312),
      Offset(240, 298),
      Offset(220, 350),
      Offset(238, 340),
    ];
    for (final p in zigzag) {
      final q = r.point(p);
      path.lineTo(q.dx, q.dy);
    }
    canvas.drawPath(path, scribble);
  }

  @override
  bool shouldRepaint(covariant _BrushPainter oldDelegate) =>
      oldDelegate.r.scale != r.scale;
}

class _HeaderHeartPainter extends CustomPainter {
  const _HeaderHeartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF0B6B8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(w * .5, h * .91)
      ..cubicTo(w * .03, h * .60, w * .02, h * .16, w * .30, h * .10)
      ..cubicTo(w * .43, h * .08, w * .49, h * .23, w * .5, h * .34)
      ..cubicTo(w * .51, h * .23, w * .57, h * .08, w * .70, h * .10)
      ..cubicTo(w * .98, h * .16, w * .97, h * .60, w * .5, h * .91);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
