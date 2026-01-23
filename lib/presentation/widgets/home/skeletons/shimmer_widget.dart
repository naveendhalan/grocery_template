import 'package:flutter/material.dart';

/// Base shimmer widget for skeleton loading animations
class ShimmerWidget extends StatefulWidget {
  const ShimmerWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  });

  final Widget child;
  final Duration duration;

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            final double width = bounds.width;
            final double progress = _controller.value;
            final double shimmerWidth = width * 0.4;
            final double shimmerStart = (progress * 2 - 0.5) * width;
            
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
              ],
              stops: [
                (shimmerStart - shimmerWidth) / width,
                shimmerStart / width,
                (shimmerStart + shimmerWidth) / width,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}
