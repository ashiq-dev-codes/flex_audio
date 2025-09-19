import 'package:flex_audio/flex_audio.dart';
import 'package:flutter/material.dart';

class FlexAudioPlayerCard extends StatelessWidget {
  const FlexAudioPlayerCard({
    super.key,
    this.padding,
    this.iconSize,
    this.playIcon,
    this.showTime,
    this.onChanged,
    this.iconColor,
    this.pauseIcon,
    this.thumbColor,
    this.trackColor,
    this.borderRadius,
    required this.max,
    required this.value,
    this.backgroundColor,
    this.isActive = false,
    this.isPlaying = false,
    this.isLoading = false,
    this.durationTextStyle,
    required this.onPressed,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.durationTextPosition = DurationTextPositionEnum.none,
  });
  final double max;
  final double value;
  final bool isActive;
  final bool? showTime;
  final bool isPlaying;
  final bool isLoading;
  final Color? iconColor;
  final double? iconSize;
  final Widget? playIcon;
  final Color? thumbColor;
  final Color? trackColor;
  final Widget? pauseIcon;
  final Duration position;
  final Duration duration;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? durationTextStyle;
  final Function(double value)? onChanged;
  final BorderRadiusGeometry? borderRadius;
  final DurationTextPositionEnum durationTextPosition;

  @override
  Widget build(BuildContext context) {
    final defaultValue = FlexAudioPlayerCardDefaultValue();

    return Container(
      padding: padding ?? defaultValue.padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultValue.white,
        borderRadius: borderRadius ?? defaultValue.borderRadius,
      ),
      child: Row(
        children: [
          if (durationTextPosition == DurationTextPositionEnum.start)
            _defaultDurationText,

          InkWell(
            onTap: isLoading ? null : onPressed,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: trackColor ?? defaultValue.primary,
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: iconColor ?? defaultValue.white,
                        ),
                      )
                    : isActive && isPlaying
                    ? pauseIcon ?? _defaultPauseIcon
                    : playIcon ?? _defaultPlayIcon,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 2.5,
                    overlayShape: SliderComponentShape.noOverlay,
                    thumbColor: thumbColor ?? defaultValue.primary,
                  ),
                  child: Slider(
                    min: 0,
                    max: max,
                    onChanged: onChanged,
                    value: value.clamp(0, max),
                    activeColor: trackColor ?? defaultValue.primary,
                    inactiveColor: (trackColor ?? defaultValue.primary)
                        .withValues(alpha: 0.4),
                  ),
                ),

                if (durationTextPosition == DurationTextPositionEnum.bottom)
                  _defaultDurationText,
              ],
            ),
          ),

          if (durationTextPosition == DurationTextPositionEnum.end)
            _defaultDurationText,
        ],
      ),
    );
  }

  String _format(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Widget get _defaultPauseIcon {
    final defaultValue = FlexAudioPlayerCardDefaultValue();

    return Icon(
      Icons.pause_rounded,
      color: iconColor ?? defaultValue.white,
      size: iconSize ?? defaultValue.iconSize,
    );
  }

  Widget get _defaultPlayIcon {
    final defaultValue = FlexAudioPlayerCardDefaultValue();

    return Icon(
      Icons.play_arrow_rounded,
      color: iconColor ?? defaultValue.white,
      size: iconSize ?? defaultValue.iconSize,
    );
  }

  Widget get _defaultDurationText {
    final defaultValue = FlexAudioPlayerCardDefaultValue();

    if (showTime != true) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        duration.inMilliseconds == 0
            ? "--:--" // fallback when duration is unknown
            : _format(isActive ? position : duration),
        style: durationTextStyle ?? defaultValue.durationTextStyle,
      ),
    );
  }
}
