import 'package:flex_audio/flex_audio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flex Audio Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AudioDemoPage(),
    );
  }
}

class AudioDemoPage extends StatefulWidget {
  const AudioDemoPage({super.key});

  @override
  State<AudioDemoPage> createState() => _AudioDemoPageState();
}

class _AudioDemoPageState extends State<AudioDemoPage> {
  late final FlexAudioPlayerController audioController;

  @override
  void initState() {
    super.initState();
    audioController = FlexAudioPlayerController();
  }

  @override
  void dispose() {
    audioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final testAudioUrl =
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

    return Scaffold(
      appBar: AppBar(title: const Text('Flex Audio Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FlexAudioPlayer(
              audioPath: testAudioUrl,
              audioController: audioController,
              showTime: true,
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.blue.withOpacity(0.3),
              controlButtonColor: Colors.blue,
              backgroundColor: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              buildControlButton: (isActive, isPlaying, isLoading) {
                if (isLoading) {
                  return const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                }
                return Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                  size: 40,
                  color: isActive ? Colors.blue : Colors.grey,
                );
              },
              durationTextPosition: DurationTextPositionEnum.end,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => audioController.play(testAudioUrl),
                  child: const Text('Play'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: audioController.pause,
                  child: const Text('Pause'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: audioController.stop,
                  child: const Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
