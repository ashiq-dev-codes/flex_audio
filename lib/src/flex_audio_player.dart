import 'package:corextra/corextra.dart';
import 'package:flex_audio/flex_audio.dart';
import 'package:flutter/material.dart';

class FlexAudioPlayer extends StatefulWidget {
  const FlexAudioPlayer({
    super.key,
    this.style = 1,
    this.isFile = false,
    required this.audioPath,
    required this.audioController,
  });
  final int style;
  final bool isFile;
  final String audioPath;
  final FlexAudioController audioController;

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

    return ValueListenableBuilder<String?>(
      valueListenable: audioController.currentPath,
      builder: (context, currentPath, _) {
        final isActive = currentPath == widget.audioPath;

        return ValueListenableBuilder<Duration>(
          valueListenable: audioController.position,
          builder: (context, currentPosition, _) {
            return ValueListenableBuilder<Duration>(
              valueListenable: audioController.duration,
              builder: (context, currentDuration, _) {
                return ValueListenableBuilder<bool>(
                  valueListenable: audioController.isPlaying,
                  builder: (context, isPlaying, _) {
                    // Only get position & duration if active
                    final position = isActive
                        ? currentPosition
                        : _localPosition;
                    final duration = isActive ? currentDuration : Duration.zero;
                    final total = duration.inMilliseconds == 0
                        ? 1
                        : duration.inMilliseconds;
                    final value = position.inMilliseconds
                        .clamp(0, total)
                        .toDouble();

                    return _buildChatAudioPlayerCard(
                      value: value,
                      isActive: isActive,
                      duration: duration,
                      position: position,
                      max: total.toDouble(),
                      audioController: audioController,
                      isPlaying: !audioController.hasCompleted && isPlaying,
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

  Widget _buildChatAudioPlayerCard({
    double max = 1.0,
    bool isActive = false,
    required double value,
    bool isPlaying = false,
    Duration duration = Duration.zero,
    Duration position = Duration.zero,
    required FlexAudioController audioController,
  }) {
    switch (widget.style) {
      case 2:
        return FlexAudioPlayerStyle2(
          max: max,
          value: value,
          isActive: true,
          duration: duration,
          position: position,
          isPlaying: isPlaying,
          onChanged: (val) {
            audioController.seek(Duration(milliseconds: val.toInt()));
          },
          onPressed: () {
            if (isPlaying) {
              audioController.pause();
            } else {
              audioController.play(widget.audioPath, isFile: widget.isFile);
            }
            // Save position if inactive, so slider doesn't reset immediately
            if (!isActive) {
              safeSetState(() {
                _localPosition = Duration.zero;
              });
            }
          },
        );
      default:
        return FlexAudioPlayerStyle1(
          max: max,
          value: value,
          isActive: isActive,
          duration: duration,
          position: position,
          isPlaying: isPlaying,
          onChanged: isActive
              ? (val) {
                  audioController.seek(Duration(milliseconds: val.toInt()));
                }
              : null,
          onPressed: () {
            if (isActive && isPlaying) {
              audioController.pause();
            } else {
              audioController.play(widget.audioPath, isFile: widget.isFile);
            }
            // Save position if inactive, so slider doesn't reset immediately
            if (!isActive) {
              safeSetState(() {
                _localPosition = Duration.zero;
              });
            }
          },
        );
    }
  }
}
