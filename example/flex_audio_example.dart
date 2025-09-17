// flex_audio_example.dart
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
  late final FlexAudioController audioController;

  @override
  void initState() {
    super.initState();
    audioController = FlexAudioController();
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
              style: 1,
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
