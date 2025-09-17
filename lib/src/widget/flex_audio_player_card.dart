import 'package:flutter/material.dart';

class FlexAudioPlayerCard extends StatelessWidget {
  const FlexAudioPlayerCard({
    super.key,
    required this.value,
    required this.max,
    required this.onPressed,
    this.onChanged,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.isActive = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor = Colors.white,
    this.trackColor = Colors.blueAccent,
    this.thumbColor = Colors.blueAccent,
    this.iconColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    this.borderRadius = 8.0,
    this.showTime = true,
    this.iconSize = 28.0,
  });

  final double value;
  final double max;
  final bool isPlaying;
  final bool isActive;
  final bool isLoading;
  final bool isDisabled;
  final Duration position;
  final Duration duration;
  final VoidCallback onPressed;
  final Function(double value)? onChanged;

  final Color backgroundColor;
  final Color trackColor;
  final Color thumbColor;
  final Color iconColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool showTime;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final effectiveTrackColor = isDisabled
        ? trackColor.withValues(alpha: 0.3)
        : trackColor;
    final effectiveThumbColor = isDisabled
        ? thumbColor.withValues(alpha: 0.3)
        : thumbColor;
    final effectiveIconColor = isDisabled
        ? iconColor.withValues(alpha: 0.3)
        : iconColor;
    final effectiveBackgroundColor = isDisabled
        ? backgroundColor.withValues(alpha: 0.5)
        : backgroundColor;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: isDisabled || isLoading ? null : onPressed,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: effectiveTrackColor,
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: effectiveIconColor,
                        ),
                      )
                    : Icon(
                        isActive && isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: effectiveIconColor,
                        size: iconSize,
                      ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbColor: effectiveThumbColor,
                overlayShape: SliderComponentShape.noOverlay,
                trackHeight: 2.5,
              ),
              child: Slider(
                min: 0,
                max: max,
                value: value.clamp(0, max),
                onChanged: isDisabled ? null : onChanged,
                activeColor: effectiveTrackColor,
                inactiveColor: effectiveTrackColor.withValues(alpha: 0.4),
              ),
            ),
          ),
          if (showTime)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                duration.inMilliseconds == 0
                    ? "--:--" // fallback when duration is unknown
                    : _format(isActive ? position : duration),
                style: TextStyle(
                  fontSize: 12,
                  color: effectiveIconColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _format(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
