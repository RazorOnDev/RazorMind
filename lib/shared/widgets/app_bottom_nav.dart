import 'package:flutter/material.dart';
import 'package:razor_mind/core/constants/app_colors.dart';
import 'package:razor_mind/core/constants/app_strings.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItem(
      label: AppStrings.home,
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    _NavItem(
      label: AppStrings.learn,
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book_rounded,
    ),
    _NavItem(
      label: AppStrings.stats,
      icon: Icons.bar_chart_outlined,
      activeIcon: Icons.bar_chart_rounded,
    ),
    _NavItem(
      label: AppStrings.profile,
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Container(
      height: 72 + bottomPadding,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Row(
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final isSelected = index == currentIndex;
            return Expanded(
              child: _NavButton(
                item: item,
                isSelected: isSelected,
                onTap: () => onTap(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  const _NavButton({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      value: widget.isSelected ? 1.0 : 0.0,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void didUpdateWidget(_NavButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final color = Color.lerp(
            AppColors.textTertiary,
            AppColors.primary,
            _controller.value,
          )!;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnim,
                child: Icon(
                  widget.isSelected ? widget.item.activeIcon : widget.item.icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w400,
                  letterSpacing: 0.1,
                ),
                child: Text(widget.item.label),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}
