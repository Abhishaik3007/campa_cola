import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'get_started_1.dart';
import 'get_started_2.dart';
import 'get_started_3.dart';

void main() => runApp(const CampusClosetApp());

// Brand color palette matching the design
const Color wine = Color(0xFFB5010A); // Brand crimson from the reference
const Color blushBg = Color(0xFFFAF1ED); // Main warm blush background
const Color blushBgLight = Color(0xFFFFF7F4); // Gradient highlight
const Color blushBgDeep = Color(0xFFF6E8E2); // Gradient shadow
const Color ink = Color(0xFF1B1617); // Primary dark charcoal text
const Color inkSecondary = Color(0xFF635A5C); // Muted descriptive text
const Color badgeBg = Color(0xFFFDE4E0); // Soft circle icon badge
const Color dotInactive = Color(0xFFF1CECA); // Inactive indicator dot
const Color screenOneBg = Color(0xFFFEEAE9); // First-screen blush field

/// Blocks finger swipes. Button calls to [PageController.jumpToPage] still work.
class _NoSwipePhysics extends ScrollPhysics {
  const _NoSwipePhysics({super.parent});

  @override
  _NoSwipePhysics applyTo(ScrollPhysics? ancestor) {
    return _NoSwipePhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) => false;
}

class CampusClosetApp extends StatelessWidget {
  const CampusClosetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Closet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: blushBg),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _goTo(int page) {
    if (!_pageController.hasClients) return;
    _pageController.jumpToPage(page);
    setState(() => _currentIndex = page);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background subtle warm gradient and watercolor washes
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [blushBgLight, blushBg, blushBgDeep],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _BlushArtPainter(pageIndex: _currentIndex),
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top Brand Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(26, 19, 26, 0),
                  child: _currentIndex == 2
                      ? const _BrandHeader(
                          logoOffset: Offset(4, -1),
                          textOffset: Offset(3, -1.5),
                          fontSize: 21.8,
                        )
                      : const _BrandHeader(),
                ),
                // Swipeable Onboarding Screens
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    physics: const _NoSwipePhysics(),
                    children: [
                      GetStarted1(
                        onNext: () => _goTo(1),
                        onSkip: () => _goTo(2),
                      ),
                      GetStarted2(
                        onNext: () => _goTo(2),
                        onBack: () => _goTo(0),
                      ),
                      GetStarted3(
                        onGetStarted: () => _goTo(0),
                        onBack: () => _goTo(1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_currentIndex == 1)
            Positioned(
              left: MediaQuery.sizeOf(context).width * (315 / 384),
              top: MediaQuery.sizeOf(context).width * (73 / 384),
              width: MediaQuery.sizeOf(context).width * (54 / 384),
              height: MediaQuery.sizeOf(context).width * (54 / 384),
              child: const IgnorePointer(child: GetStarted2Heart()),
            ),
        ],
      ),
    );
  }
}

// ==========================================
// BRAND HEADER
// ==========================================
class _BrandHeader extends StatelessWidget {
  final Offset logoOffset;
  final Offset textOffset;
  final double fontSize;

  const _BrandHeader({
    this.logoOffset = Offset.zero,
    this.textOffset = Offset.zero,
    this.fontSize = 23.6,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        children: [
          Transform.translate(
            offset: logoOffset,
            child: const _FlowerLogo(size: 36, color: wine),
          ),
          const SizedBox(width: 8),
          Transform.translate(
            offset: textOffset,
            child: Text(
              'Campus Closet',
              style: GoogleFonts.playfairDisplay(
                color: wine,
                fontSize: fontSize,
                height: 1.0,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Stylized 8-petal asterisk flower logo matching reference design
class _FlowerLogo extends StatelessWidget {
  final double size;
  final Color color;
  const _FlowerLogo({this.size = 26, this.color = wine});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _FlowerLogoPainter(color: color)),
    );
  }
}

class _FlowerLogoPainter extends CustomPainter {
  final Color color;
  _FlowerLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;
    final inner = r * 0.10;
    final outer = r * 0.98;
    final petalWidth = r * 0.34;

    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * 3.141592653589793 / 180;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);

      final mid = (inner + outer) / 2;
      final path = Path()
        ..moveTo(0, -inner)
        ..quadraticBezierTo(petalWidth, -mid, 0, -outer)
        ..quadraticBezierTo(-petalWidth, -mid, 0, -inner)
        ..close();
      canvas.drawPath(path, paint);

      canvas.restore();
    }

    canvas.drawCircle(center, r * 0.06, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant _FlowerLogoPainter oldDelegate) =>
      oldDelegate.color != color;
}

// Background artistic subtle watercolor brush wash painter
class _BlushArtPainter extends CustomPainter {
  final int pageIndex;
  _BlushArtPainter({required this.pageIndex});

  @override
  void paint(Canvas canvas, Size size) {
    if (pageIndex == 0) {
      // Flat blush field. The diagonal strokes are painted by GetStarted1.
      canvas.drawRect(Offset.zero & size, Paint()..color = screenOneBg);
    } else if (pageIndex == 1) {
      canvas.drawRect(
        Offset.zero & size,
        Paint()..color = const Color(0xFFFCECEC),
      );
    } else {
      // Blush field. The brush strokes are painted by GetStarted3.
      final rect = Offset.zero & size;
      canvas.drawRect(
        rect,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [screenThreeBgTop, screenThreeBgBottom],
          ).createShader(rect),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BlushArtPainter oldDelegate) =>
      oldDelegate.pageIndex != pageIndex;
}
