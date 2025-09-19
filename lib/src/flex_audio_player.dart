import 'package:flex_audio/flex_audio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class FlexAudioPlayer extends StatefulWidget {
  const FlexAudioPlayer({
    super.key,
    this.padding,
    this.iconSize,
    this.showTime,
    this.iconColor,
    this.trackColor,
    this.thumbColor,
    this.borderRadius,
    this.isFile = false,
    this.backgroundColor,
    this.durationTextStyle,
    required this.audioPath,
    required this.audioController,
    this.durationTextPosition = DurationTextPositionEnum.none,
  });
  final bool isFile;
  final bool? showTime;
  final double? iconSize;
  final Color? iconColor;
  final String audioPath;
  final Color? trackColor;
  final Color? thumbColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? durationTextStyle;
  final BorderRadiusGeometry? borderRadius;
  final FlexAudioPlayerController audioController;
  final DurationTextPositionEnum durationTextPosition;

  @override
  State<FlexAudioPlayer> createState() => _FlexAudioPlayerState();
}

class _FlexAudioPlayerState extends State<FlexAudioPlayer> {
  Duration _localPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    widget.audioController.init();
  }

  @override
  Widget build(BuildContext context) {
    final audioController = widget.audioController;

    return ValueListenableBuilder<ProcessingState>(
      valueListenable: audioController.state,
      builder: (context, currentState, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: audioController.currentPath,
          builder: (context, currentPath, _) {
            final isActive = currentPath == widget.audioPath;

            return ValueListenableBuilder(
              valueListenable: audioController.position,
              builder: (context, currentPosition, _) {
                return ValueListenableBuilder<Duration>(
                  valueListenable: audioController.duration,
                  builder: (context, currentDuration, _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: audioController.isPlaying,
                      builder: (context, isPlaying, _) {
                        // Only get position & duration if active
                        final isLoading =
                            isActive &&
                                currentState == ProcessingState.loading ||
                            currentState == ProcessingState.buffering;

                        final position = isActive
                            ? currentPosition
                            : _localPosition;
                        final duration = isActive
                            ? currentDuration
                            : Duration.zero;

                        final total = duration.inMilliseconds == 0
                            ? 1
                            : duration.inMilliseconds;
                        final value = position.inMilliseconds
                            .clamp(0, total)
                            .toDouble();

                        return FlexAudioPlayerCard(
                          value: value,
                          position: position,
                          duration: duration,
                          isActive: isActive,
                          isLoading: isLoading,
                          max: total.toDouble(),
                          padding: widget.padding,
                          iconSize: widget.iconSize,
                          showTime: widget.showTime,
                          iconColor: widget.iconColor,
                          thumbColor: widget.thumbColor,
                          trackColor: widget.trackColor,
                          borderRadius: widget.borderRadius,
                          backgroundColor: widget.backgroundColor,
                          durationTextStyle: widget.durationTextStyle,
                          durationTextPosition: widget.durationTextPosition,
                          isPlaying:
                              !audioController.hasCompleted &&
                              isPlaying &&
                              !isLoading,
                          onPressed: () {
                            if (isPlaying) {
                              audioController.pause();
                              if (isActive) return;
                            }

                            audioController.play(
                              widget.audioPath,
                              isFile: widget.isFile,
                            );

                            if (!isActive) {
                              setState(() => _localPosition = Duration.zero);
                            }
                          },
                          onChanged: isActive
                              ? (val) => audioController.seek(
                                  Duration(milliseconds: val.toInt()),
                                )
                              : null,
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
