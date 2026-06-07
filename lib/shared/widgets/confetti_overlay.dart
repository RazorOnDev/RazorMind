import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:razor_mind/core/constants/app_colors.dart';

class ConfettiOverlay extends StatefulWidget {
  final bool active;
  final Widget child;

  const ConfettiOverlay({
    super.key,
    required this.active,
    required this.child,
  });

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final math.Random _rng = math.Random();

  static const _colors = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.correct,
    AppColors.error,
    Color(0xFF06B6D4),
    Color(0xFFEC4899),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.addListener(() => setState(() => _updateParticles()));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _particles.clear());
      }
    });
    if (widget.active) _startConfetti();
  }

  @override
  void didUpdateWidget(ConfettiOverlay old) {
    super.didUpdateWidget(old);
    if (!old.active && widget.active) _startConfetti();
  }

  void _startConfetti() {
    _particles.clear();
    for (int i = 0; i < 60; i++) {
      _particles.add(_Particle(
        x: _rng.nextDouble(),
        y: -_rng.nextDouble() * 0.3,
        vx: (_rng.nextDouble() - 0.5) * 0.008,
        vy: 0.002 + _rng.nextDouble() * 0.004,
        rotation: _rng.nextDouble() * math.pi * 2,
        vRotation: (_rng.nextDouble() - 0.5) * 0.15,
        size: 6 + _rng.nextDouble() * 8,
        color: _colors[_rng.nextInt(_colors.length)],
        isRect: _rng.nextBool(),
      ));
    }
    _controller.forward(from: 0);
  }

  void _updateParticles() {
    final gravity = 0.0003;
    for (final p in _particles) {
      p.x += p.vx;
      p.y += p.vy;
      p.vy += gravity;
      p.rotation += p.vRotation;
      p.vx += (_rng.nextDouble() - 0.5) * 0.0002;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_particles.isNotEmpty && _controller.isAnimating)
          Positioned.fill(
            child: IgnorePointer(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CustomPaint(
                    painter: _ConfettiPainter(
                      particles: _particles,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _Particle {
  double x;
  double y;
  double vx;
  double vy;
  double rotation;
  double vRotation;
  final double size;
  final Color color;
  final bool isRect;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.rotation,
    required this.vRotation,
    required this.size,
    required this.color,
    required this.isRect,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_Particle> particles;
  final double width;
  final double height;

  const _ConfettiPainter({
    required this.particles,
    required this.width,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final p in particles) {
      final px = p.x * width;
      final py = p.y * height;
      if (py > height + 20) continue;
      paint.color = p.color.withOpacity(
        (1.0 - (p.y.clamp(0.7, 1.0) - 0.7) / 0.3).clamp(0.0, 1.0),
      );
      canvas.save();
      canvas.translate(px, py);
      canvas.rotate(p.rotation);
      if (p.isRect) {
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: p.size,
            height: p.size * 0.45,
          ),
          paint,
        );
      } else {
        canvas.drawCircle(Offset.zero, p.size / 2, paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => true;
}
