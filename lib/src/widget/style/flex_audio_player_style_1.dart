import 'package:flutter/material.dart';

class FlexAudioPlayerStyle1 extends StatelessWidget {
  const FlexAudioPlayerStyle1({
    super.key,
    this.max = 1.0,
    required this.value,
    this.isActive = false,
    this.isPlaying = false,
    required this.onPressed,
    required this.onChanged,
    this.duration = Duration.zero,
    this.position = Duration.zero,
  });
  final double max;
  final double value;
  final bool isActive;
  final bool isPlaying;
  final Duration duration;
  final Duration position;
  final VoidCallback onPressed;
  final Function(double value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onPressed,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
              ),
              child: Icon(
                isActive && isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    overlayShape: SliderComponentShape.noOverlay,
                    trackHeight: 2.5,
                  ),
                  child: Slider(
                    min: 0,
                    max: max,
                    value: value,
                    onChanged: onChanged,
                    activeColor: Colors.blueAccent,
                    inactiveColor: Colors.blueAccent.withValues(alpha: 0.4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    _format(isActive ? position : duration),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600,
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

  String _format(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
