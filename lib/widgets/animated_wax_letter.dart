import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/date_proposal.dart';

class AnimatedWaxLetter extends StatefulWidget {
  final DateProposal proposal;
  final bool isOpened;
  final VoidCallback onToggle;
  final VoidCallback onWaxSealTap;

  const AnimatedWaxLetter({
    super.key,
    required this.proposal,
    required this.isOpened,
    required this.onToggle,
    required this.onWaxSealTap,
  });

  @override
  State<AnimatedWaxLetter> createState() => _AnimatedWaxLetterState();
}

class _AnimatedWaxLetterState extends State<AnimatedWaxLetter>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _scaleAnimation;

  late AnimationController _pulseController;
  late Animation<double> _sealScaleAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideAnimation = Tween<double>(begin: 80.0, end: -35.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
    );

    _rotateAnimation = Tween<double>(begin: -0.01, end: 0.05).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _sealScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.25), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.25, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    if (widget.isOpened) {
      _slideController.value = 1.0;
    } else {
      // Auto open slightly after build
      Future.delayed(const Duration(milliseconds: 350), () {
        if (mounted) _slideController.forward();
      });
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedWaxLetter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpened != oldWidget.isOpened) {
      if (widget.isOpened) {
        _slideController.forward();
      } else {
        _slideController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _onSealTapped() {
    _pulseController.forward(from: 0.0);
    widget.onWaxSealTap();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: widget.onToggle,
        child: SizedBox(
          width: 340,
          height: 480,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // 1. Envelope Back Base
              Positioned(
                top: 70,
                child: Container(
                  width: 310,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFD6BE9F), Color(0xFFBC9E77)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF382A1C).withOpacity(0.25),
                        blurRadius: 30,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Inner Gold Lining Pattern
                      Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAF7F2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFD4AF37), width: 1.2),
                          ),
                          child: Opacity(
                            opacity: 0.15,
                            child: CustomPaint(
                              painter: _LiningPatternPainter(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Open Flap Top
              Positioned(
                top: 70,
                child: CustomPaint(
                  size: const Size(310, 160),
                  painter: _FlapPainter(isUpper: true),
                ),
              ),

              // 3. Animated Sliding Ivory Letter Sheet
              AnimatedBuilder(
                animation: _slideController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Transform.rotate(
                      angle: _rotateAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      ),
                    ),
                  );
                },
                child: _buildIvoryLetter(),
              ),

              // 4. Envelope Front Pocket (Covers bottom of letter)
              Positioned(
                bottom: 50,
                child: IgnorePointer(
                  child: CustomPaint(
                    size: const Size(310, 240),
                    painter: _EnvelopeFrontPocketPainter(),
                  ),
                ),
              ),

              // 5. 3D Crimson Red Wax Seal Stamp
              Positioned(
                bottom: 105,
                left: 45,
                child: GestureDetector(
                  onTap: _onSealTapped,
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _sealScaleAnimation.value,
                        child: child,
                      );
                    },
                    child: _buildWaxSeal(),
                  ),
                ),
              ),

              // 6. Dried Lavender & Baby's Breath Bouquet
              Positioned(
                bottom: 40,
                right: 25,
                child: IgnorePointer(
                  child: SizedBox(
                    width: 100,
                    height: 170,
                    child: CustomPaint(
                      painter: _DriedBouquetPainter(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Pure Ivory Letter Sheet Widget
  Widget _buildIvoryLetter() {
    return Container(
      width: 285,
      height: 380,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4DACB), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF332014).withOpacity(0.22),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Corner Filigrees
          const Positioned(top: 0, left: 0, child: _CornerFiligree(rotation: 0)),
          const Positioned(top: 0, right: 0, child: _CornerFiligree(rotation: math.pi / 2)),
          const Positioned(bottom: 0, left: 0, child: _CornerFiligree(rotation: -math.pi / 2)),
          const Positioned(bottom: 0, right: 0, child: _CornerFiligree(rotation: math.pi)),

          // Letter Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  widget.proposal.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.gowunBatang(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF231A16),
                    height: 1.35,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 18),

                // Decorative Divider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Color(0xFFC4AE88)],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '❦',
                        style: GoogleFonts.cormorantGaramond(
                          color: const Color(0xFFB39868),
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                      width: 45,
                      height: 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFC4AE88), Colors.transparent],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                Text(
                  widget.proposal.dateTimeText,
                  style: GoogleFonts.gowunBatang(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2C221D),
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.proposal.place,
                  style: GoogleFonts.gowunBatang(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF5A4D45),
                  ),
                ),
                const SizedBox(height: 16),

                // Note Box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F5EC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFE5D9C5),
                      style: BorderStyle.solid,
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    widget.proposal.memo,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.gowunBatang(
                      fontSize: 11,
                      color: const Color(0xFF7E6E64),
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3D Crimson Red Lacquer Wax Seal Widget
  Widget _buildWaxSeal() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.35, -0.35),
          radius: 0.85,
          colors: [
            Color(0xFFB81B34),
            Color(0xFF850E22),
            Color(0xFF540412),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF45050F).withOpacity(0.55),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
          const BoxShadow(
            color: Colors.white24,
            blurRadius: 4,
            offset: Offset(-2, -2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Embossed Rim Circle
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          // Inner Icon / Eiffel Tower
          const Icon(
            Icons.wine_bar_rounded,
            color: Color(0xFFFBECEF),
            size: 24,
          ),
        ],
      ),
    );
  }
}

// Gold Corner Filigree Decoration
class _CornerFiligree extends StatelessWidget {
  final double rotation;

  const _CornerFiligree({required this.rotation});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: SizedBox(
        width: 26,
        height: 26,
        child: CustomPaint(
          painter: _FiligreePainter(),
        ),
      ),
    );
  }
}

class _FiligreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.7)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(2, size.height);
    path.lineTo(2, 2);
    path.lineTo(size.width, 2);

    // Inner curve flourish
    path.moveTo(6, size.height * 0.7);
    path.quadraticBezierTo(6, 6, size.width * 0.7, 6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Envelope Lining Pattern
class _LiningPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC7A762)
      ..strokeWidth = 0.7;

    const step = 14.0;
    for (double i = 0; i < size.width + size.height; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(0, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Flap Painter
class _FlapPainter extends CustomPainter {
  final bool isUpper;

  _FlapPainter({required this.isUpper});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE0CBAE), Color(0xFFC5AA86)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);

    // Gold trim line along edge
    final trimPaint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.8)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final trimPath = Path();
    trimPath.moveTo(0, 0);
    trimPath.lineTo(size.width / 2, size.height);
    trimPath.lineTo(size.width, 0);

    canvas.drawPath(trimPath, trimPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Front Pocket Painter
class _EnvelopeFrontPocketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height * 0.58);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFCBAF8B), Color(0xFFB59771)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawShadow(path, Colors.black.withOpacity(0.15), 6, true);
    canvas.drawPath(path, paint);

    // Gold trim on V notch
    final trimPaint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.7)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final vPath = Path();
    vPath.moveTo(0, 0);
    vPath.lineTo(size.width / 2, size.height * 0.58);
    vPath.lineTo(size.width, 0);

    canvas.drawPath(vPath, trimPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Dried Lavender Bouquet Painter
class _DriedBouquetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stemPaint = Paint()
      ..color = const Color(0xFF7E846E)
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    // Stems
    canvas.drawLine(Offset(size.width * 0.2, size.height), Offset(size.width * 0.45, 30), stemPaint);
    canvas.drawLine(Offset(size.width * 0.25, size.height), Offset(size.width * 0.7, 45), stemPaint);
    canvas.drawLine(Offset(size.width * 0.22, size.height), Offset(size.width * 0.55, 60), stemPaint);

    // Lavender Buds
    final purplePaint = Paint()..color = const Color(0xFF6B588E);
    final lightPurplePaint = Paint()..color = const Color(0xFF8674A8);
    final whitePaint = Paint()..color = const Color(0xFFF7F4EC);

    // Lavender spike 1
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.45, 30), width: 7, height: 11), purplePaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.43, 40), width: 7, height: 10), lightPurplePaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.47, 50), width: 7, height: 10), purplePaint);

    // Lavender spike 2
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.7, 45), width: 6, height: 10), lightPurplePaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.68, 55), width: 6, height: 9), purplePaint);

    // Baby's breath little white dots
    canvas.drawCircle(Offset(size.width * 0.35, 65), 3.5, whitePaint);
    canvas.drawCircle(Offset(size.width * 0.5, 75), 3.0, whitePaint);
    canvas.drawCircle(Offset(size.width * 0.6, 85), 3.5, whitePaint);
    canvas.drawCircle(Offset(size.width * 0.3, 80), 2.8, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
