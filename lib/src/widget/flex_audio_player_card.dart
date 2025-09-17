import 'package:flutter/material.dart';

class FlexAudioPlayerCard extends StatelessWidget {
  const FlexAudioPlayerCard({
    super.key,
    this.onChanged,
    required this.max,
    required this.value,
    this.iconSize = 28.0,
    this.showTime = true,
    this.isActive = false,
    this.isPlaying = false,
    this.isLoading = false,
    required this.onPressed,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.iconColor = Colors.white,
    this.trackColor = Colors.blueAccent,
    this.thumbColor = Colors.blueAccent,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
  });
  final double max;
  final double value;
  final bool isActive;
  final bool? showTime;
  final bool isPlaying;
  final bool isLoading;
  final Color? iconColor;
  final double? iconSize;
  final Color? thumbColor;
  final Color? trackColor;
  final Duration position;
  final Duration duration;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Function(double value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: isLoading ? null : onPressed,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: trackColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: iconColor,
                        ),
                      )
                    : Icon(
                        isActive && isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: iconSize,
                        color: iconColor,
                      ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2.5,
                thumbColor: thumbColor,
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Slider(
                min: 0,
                max: max,
                onChanged: onChanged,
                activeColor: trackColor,
                value: value.clamp(0, max),
                inactiveColor: trackColor?.withValues(alpha: 0.4),
              ),
            ),
          ),
          if (showTime == true)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                duration.inMilliseconds == 0
                    ? "--:--" // fallback when duration is unknown
                    : _format(isActive ? position : duration),
                style: TextStyle(
                  fontSize: 12,
                  color: iconColor,
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
