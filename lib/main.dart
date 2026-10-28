import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const CampusClosetApp());

// Brand color palette matching the design
const Color wine = Color(0xFF8B1524); // Deep brand crimson
const Color blushBg = Color(0xFFFAF1ED); // Main warm blush background
const Color blushBgLight = Color(0xFFFFF7F4); // Gradient highlight
const Color blushBgDeep = Color(0xFFF6E8E2); // Gradient shadow
const Color ink = Color(0xFF1B1617); // Primary dark charcoal text
const Color inkSecondary = Color(0xFF635A5C); // Muted descriptive text
const Color badgeBg = Color(0xFFFDE4E0); // Soft circle icon badge
const Color dotInactive = Color(0xFFF1CECA); // Inactive indicator dot
const Color tapeColor = Color(0xCCF4B8B4); // Polaroid washi tape

class CampusClosetApp extends StatelessWidget {
  const CampusClosetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Closet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: blushBg,
      ),
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
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(26, 14, 26, 0),
                  child: _BrandHeader(),
                ),
                // Swipeable Onboarding Screens
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _ScreenOne(
                        onNext: () => _goTo(1),
                        onSkip: () => _goTo(2),
                      ),
                      _ScreenTwo(
                        onNext: () => _goTo(2),
                        onBack: () => _goTo(0),
                      ),
                      _ScreenThree(
                        onGetStarted: () => _goTo(0),
                        onBack: () => _goTo(1),
                      ),
                    ],
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

// ==========================================
// BRAND HEADER
// ==========================================
class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _FlowerLogo(size: 26, color: wine),
        const SizedBox(width: 9),
        Text(
          'Campus Closet',
          style: GoogleFonts.playfairDisplay(
            color: wine,
            fontSize: 21,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ],
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
      child: CustomPaint(
        painter: _FlowerLogoPainter(color: color),
      ),
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
    final petalLength = r * 0.76;
    final petalWidth = r * 0.28;

    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * 3.141592653589793 / 180;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);

      final path = Path();
      path.moveTo(0, 0);
      path.quadraticBezierTo(petalWidth, -petalLength * 0.45, 0, -petalLength);
      path.quadraticBezierTo(-petalWidth, -petalLength * 0.45, 0, 0);
      canvas.drawPath(path, paint);

      canvas.restore();
    }

    canvas.drawCircle(center, r * 0.23, paint);
  }

  @override
  bool shouldRepaint(covariant _FlowerLogoPainter oldDelegate) =>
      oldDelegate.color != color;
}

// ==========================================
// SCREEN 1: "Your closet, your campus, your way."
// ==========================================
class _ScreenOne extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const _ScreenOne({required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              // Heading with handwritten note
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 35,
                          height: 1.13,
                          fontWeight: FontWeight.w700,
                          color: ink,
                          letterSpacing: -0.6,
                        ),
                        children: [
                          const TextSpan(text: 'Your closet,\n'),
                          TextSpan(
                            text: 'your campus,',
                            style: GoogleFonts.playfairDisplay(
                              color: wine,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: '\nyour way.'),
                        ],
                      ),
                    ),
                  ),
                  // Handwritten note + heart
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 6),
                    child: Transform.rotate(
                      angle: 0.05,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Real\nStudents.\nReal Style.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.caveat(
                              fontSize: 17,
                              height: 1.12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4A3C3E),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const _DrawnHeart(size: 17),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Subtitle
              Text(
                'Discover pre-loved fashion from\nstudents around you.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.5,
                  height: 1.45,
                  color: inkSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              // Polaroid Collage Section
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Decorative hand-drawn ticks on left
                    Positioned(
                      left: 10,
                      top: 45,
                      child: Transform.rotate(
                        angle: -0.2,
                        child: Column(
                          children: [
                            Container(width: 14, height: 2, color: const Color(0xFF7A4F4F)),
                            const SizedBox(height: 3),
                            Container(width: 16, height: 2, color: const Color(0xFF7A4F4F)),
                            const SizedBox(height: 3),
                            Container(width: 12, height: 2, color: const Color(0xFF7A4F4F)),
                          ],
                        ),
                      ),
                    ),
                    // Center Main Polaroid
                    Align(
                      alignment: const Alignment(0.05, -0.15),
                      child: Transform.rotate(
                        angle: 0.02,
                        child: const _PolaroidCard(
                          asset: 'assets/images/campus-closet-main.png',
                          width: 205,
                          height: 250,
                          hasTape: true,
                          tapeAngle: -0.04,
                          imageAlignment: Alignment(0.0, -0.3),
                        ),
                      ),
                    ),
                    // Left Polaroid (Girl in blue tank)
                    Align(
                      alignment: const Alignment(-0.95, 0.72),
                      child: Transform.rotate(
                        angle: -0.14,
                        child: const _PolaroidCard(
                          asset: 'assets/images/campus-closet-blue.png',
                          width: 125,
                          height: 155,
                          hasTape: true,
                          tapeAngle: 0.05,
                          imageAlignment: Alignment(0.4, -0.4),
                        ),
                      ),
                    ),
                    // Right Polaroid (Girl in green dress)
                    Align(
                      alignment: const Alignment(0.98, 0.78),
                      child: Transform.rotate(
                        angle: 0.15,
                        child: const _PolaroidCard(
                          asset: 'assets/images/campus-closet-green.png',
                          width: 125,
                          height: 155,
                          hasTape: true,
                          tapeAngle: -0.06,
                          imageAlignment: Alignment(-0.3, -0.3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom Controls
              _BottomBar(
                currentIndex: 0,
                leftLabel: 'Skip',
                onLeftTap: onSkip,
                rightLabel: 'Next',
                onRightTap: onNext,
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

// ==========================================
// SCREEN 2: "Buy less. Style more."
// ==========================================
class _ScreenTwo extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _ScreenTwo({required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          // Heading
          Text.rich(
            TextSpan(
              style: GoogleFonts.playfairDisplay(
                fontSize: 35,
                height: 1.13,
                fontWeight: FontWeight.w700,
                color: ink,
                letterSpacing: -0.6,
              ),
              children: [
                const TextSpan(text: 'Buy less.\n'),
                TextSpan(
                  text: 'Style more.',
                  style: GoogleFonts.playfairDisplay(
                    color: wine,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Find unique, affordable and\nhigh-quality pre-loved pieces\nfrom students near you.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.5,
              height: 1.45,
              color: inkSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          // Center Section with Features and Seamless Cutout Portrait
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Girl in blue top on the right (seamless transparent cutout)
                Positioned(
                  right: -14,
                  top: 0,
                  bottom: 76,
                  width: 215,
                  child: Image.asset(
                    'assets/images/campus-closet-blue-clean.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomRight,
                  ),
                ),
                // 3 Features on the left
                Positioned(
                  left: 0,
                  top: 10,
                  bottom: 100,
                  width: 185,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _FeatureRow(
                        icon: Icons.shopping_bag_outlined,
                        title: 'Trendy finds',
                        subtitle: 'New styles every day.',
                      ),
                      _FeatureRow(
                        icon: Icons.monetization_on_outlined,
                        title: 'Student friendly',
                        subtitle: 'Great prices.',
                      ),
                      _FeatureRow(
                        icon: Icons.eco_outlined,
                        title: 'Sustainable',
                        subtitle: 'Give clothes a second life.',
                      ),
                    ],
                  ),
                ),
                // Bottom floating pill card with seamless flatlay items
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 6,
                  child: Container(
                    height: 96,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6B3A36).withValues(alpha: 0.09),
                          blurRadius: 22,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        _GarmentThumb(asset: 'assets/images/flatlay-item-1-clean.png'),
                        SizedBox(width: 8),
                        _GarmentThumb(asset: 'assets/images/flatlay-item-2-clean.png'),
                        SizedBox(width: 8),
                        _GarmentThumb(asset: 'assets/images/flatlay-item-3-clean.png'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Controls
          _BottomBar(
            currentIndex: 1,
            leftLabel: 'Back',
            onLeftTap: onBack,
            rightLabel: 'Next',
            onRightTap: onNext,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ==========================================
// SCREEN 3: "Give every outfit a second life."
// ==========================================
class _ScreenThree extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onBack;

  const _ScreenThree({required this.onGetStarted, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          // Heading
          Text.rich(
            TextSpan(
              style: GoogleFonts.playfairDisplay(
                fontSize: 35,
                height: 1.13,
                fontWeight: FontWeight.w700,
                color: ink,
                letterSpacing: -0.6,
              ),
              children: [
                const TextSpan(text: 'Give every outfit\n'),
                TextSpan(
                  text: 'a second life.',
                  style: GoogleFonts.playfairDisplay(
                    color: wine,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Sell or rent what you love, and\nmake room for your next favorite.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.5,
              height: 1.45,
              color: inkSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          // Center Section: Girl in Green Dress on Left, Actions on Right
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Girl in green dress on left (seamless transparent cutout)
                Positioned(
                  left: -32,
                  top: 0,
                  bottom: 0,
                  width: 255,
                  child: Image.asset(
                    'assets/images/campus-closet-green-clean.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
                // 3 Actions on right
                Positioned(
                  right: 0,
                  top: 14,
                  width: 172,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _ActionRow(
                        icon: Icons.checkroom_outlined,
                        title: 'Sell',
                        subtitle: 'Turn your\ncloset into cash.',
                      ),
                      SizedBox(height: 18),
                      _ActionRow(
                        icon: Icons.autorenew_rounded,
                        title: 'Rent',
                        subtitle: 'Wear more,\nspend less.',
                      ),
                      SizedBox(height: 18),
                      _ActionRow(
                        icon: Icons.favorite_border_rounded,
                        title: 'Buy',
                        subtitle: 'Find your\nnext favorite.',
                      ),
                    ],
                  ),
                ),
                // Handwritten slogan at bottom right
                Positioned(
                  right: 0,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Same Campus.\nMore Possibilities.',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.caveat(
                          fontSize: 20,
                          height: 1.15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4A3C3E),
                        ),
                      ),
                      const SizedBox(height: 3),
                      // Hand drawn underline flourish
                      CustomPaint(
                        size: const Size(60, 10),
                        painter: _SwooshFlourishPainter(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom Controls
          _BottomBar(
            currentIndex: 2,
            leftLabel: 'Back',
            onLeftTap: onBack,
            rightLabel: 'Get Started',
            onRightTap: onGetStarted,
            isGetStarted: true,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ==========================================
// REUSABLE COMPONENTS
// ==========================================

// Realistic Polaroid Card with Washi Tape and Soft Multi-layer Shadows
class _PolaroidCard extends StatelessWidget {
  final String asset;
  final double width;
  final double height;
  final bool hasTape;
  final double tapeAngle;
  final Alignment imageAlignment;

  const _PolaroidCard({
    required this.asset,
    required this.width,
    required this.height,
    this.hasTape = true,
    this.tapeAngle = 0.0,
    this.imageAlignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: width,
          height: height,
          padding: EdgeInsets.fromLTRB(
            width * 0.045,
            width * 0.045,
            width * 0.045,
            height * 0.16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF462725).withValues(alpha: 0.16),
                blurRadius: 18,
                offset: const Offset(0, 9),
                spreadRadius: 1,
              ),
              BoxShadow(
                color: const Color(0xFF331D1B).withValues(alpha: 0.06),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1.5),
            child: Image.asset(
              asset,
              fit: BoxFit.cover,
              alignment: imageAlignment,
            ),
          ),
        ),
        // Translucent washi tape pinning the top
        if (hasTape)
          Positioned(
            top: -9,
            child: Transform.rotate(
              angle: tapeAngle,
              child: Container(
                width: width * 0.28,
                height: 18,
                decoration: BoxDecoration(
                  color: tapeColor,
                  borderRadius: BorderRadius.circular(1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
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

// Feature Row (Screen 2)
class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: badgeBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: wine, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                  color: ink,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: inkSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Action Row (Screen 3)
class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: badgeBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: wine, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                  color: ink,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  height: 1.25,
                  color: inkSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Flatlay Garment Thumbnail
class _GarmentThumb extends StatelessWidget {
  final String asset;
  const _GarmentThumb({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF9EDE8),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(7),
        child: Image.asset(
          asset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// Bottom Bar with Dots and Buttons
class _BottomBar extends StatelessWidget {
  final int currentIndex;
  final String leftLabel;
  final VoidCallback onLeftTap;
  final String rightLabel;
  final VoidCallback onRightTap;
  final bool isGetStarted;

  const _BottomBar({
    required this.currentIndex,
    required this.leftLabel,
    required this.onLeftTap,
    required this.rightLabel,
    required this.onRightTap,
    this.isGetStarted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 3 Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            final isActive = i == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? wine : dotInactive,
              ),
            );
          }),
        ),
        const SizedBox(height: 22),
        // Navigation Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left text button (Skip / Back)
            GestureDetector(
              onTap: onLeftTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  leftLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w500,
                    color: ink,
                  ),
                ),
              ),
            ),
            // Right Pill Button (Next / Get Started)
            GestureDetector(
              onTap: onRightTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 52,
                padding: EdgeInsets.symmetric(
                  horizontal: isGetStarted ? 26 : 22,
                ),
                decoration: BoxDecoration(
                  color: wine,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: wine.withValues(alpha: 0.28),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rightLabel,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 19,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Hand drawn heart for Screen 1
class _DrawnHeart extends StatelessWidget {
  final double size;
  const _DrawnHeart({this.size = 18});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 0.9),
      painter: _HeartPainter(),
    );
  }
}

class _HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A3C3E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.5, h * 0.35);
    path.cubicTo(w * 0.35, h * 0.05, 0, h * 0.15, 0, h * 0.45);
    path.cubicTo(0, h * 0.75, w * 0.45, h * 0.95, w * 0.5, h);
    path.cubicTo(w * 0.55, h * 0.95, w, h * 0.75, w, h * 0.45);
    path.cubicTo(w, h * 0.15, w * 0.65, h * 0.05, w * 0.5, h * 0.35);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Swoosh flourish painter for Screen 3
class _SwooshFlourishPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A3C3E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.1,
      size.width,
      size.height * 0.6,
    );
    path.moveTo(size.width * 0.75, size.height * 0.85);
    path.lineTo(size.width * 0.95, size.height * 0.55);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Background artistic subtle watercolor brush wash painter
class _BlushArtPainter extends CustomPainter {
  final int pageIndex;
  _BlushArtPainter({required this.pageIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    if (pageIndex == 0) {
      // Gentle blush wash behind polaroids
      paint.color = const Color(0xFFF6D9D4).withValues(alpha: 0.35);
      final path = Path();
      path.moveTo(size.width * 0.4, size.height * 0.35);
      path.quadraticBezierTo(
        size.width * 0.95,
        size.height * 0.38,
        size.width,
        size.height * 0.65,
      );
      path.quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.75,
        size.width * 0.3,
        size.height * 0.6,
      );
      path.close();
      canvas.drawPath(path, paint);
    } else if (pageIndex == 1) {
      // Soft brush stroke behind girl in blue
      paint.color = const Color(0xFFF8DED9).withValues(alpha: 0.45);
      final path = Path();
      path.moveTo(size.width * 0.5, size.height * 0.25);
      path.quadraticBezierTo(
        size.width * 1.05,
        size.height * 0.3,
        size.width,
        size.height * 0.7,
      );
      path.quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.8,
        size.width * 0.45,
        size.height * 0.45,
      );
      path.close();
      canvas.drawPath(path, paint);
    } else {
      // Soft wash behind girl in green
      paint.color = const Color(0xFFF7DED8).withValues(alpha: 0.45);
      final path = Path();
      path.moveTo(0, size.height * 0.3);
      path.quadraticBezierTo(
        size.width * 0.55,
        size.height * 0.35,
        size.width * 0.5,
        size.height * 0.75,
      );
      path.quadraticBezierTo(
        size.width * 0.2,
        size.height * 0.85,
        0,
        size.height * 0.65,
      );
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BlushArtPainter oldDelegate) =>
      oldDelegate.pageIndex != pageIndex;
}
