import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';






class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("clicked");
            AudioPlayer audioPlayer = AudioPlayer();
            audioPlayer.setAsset('assets/sound/scan_complete.mp3');
            audioPlayer.play();
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
