import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:razor_mind/core/constants/app_colors.dart';

enum RazorButtonVariant { primary, secondary }

class RazorButton extends StatefulWidget {
  const RazorButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = RazorButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width = double.infinity,
    this.height = 52,
    this.borderRadius = 14,
  });

  final String label;
  final VoidCallback? onPressed;
  final RazorButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final double width;
  final double height;
  final double borderRadius;

  @override
  State<RazorButton> createState() => _RazorButtonState();
}

class _RazorButtonState extends State<RazorButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 160),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails _) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();

  bool get _isPrimary => widget.variant == RazorButtonVariant.primary;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.isLoading;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: isDisabled ? null : widget.onPressed,
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isDisabled && !widget.isLoading ? 0.5 : 1.0,
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: _isPrimary ? _PrimaryContent(widget: widget) : _SecondaryContent(widget: widget),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

class _PrimaryContent extends StatelessWidget {
  const _PrimaryContent({required this.widget});
  final RazorButton widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryLight, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: _ButtonInner(widget: widget, foregroundColor: Colors.white),
    );
  }
}

class _SecondaryContent extends StatelessWidget {
  const _SecondaryContent({required this.widget});
  final RazorButton widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: _ButtonInner(widget: widget, foregroundColor: AppColors.textPrimary),
    );
  }
}

class _ButtonInner extends StatelessWidget {
  const _ButtonInner({required this.widget, required this.foregroundColor});

  final RazorButton widget;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, color: foregroundColor, size: 20),
          const SizedBox(width: 8),
        ],
        Text(
          widget.label,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
