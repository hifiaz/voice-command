import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  SpeechRecognition _speech;
  String transcription = '';

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setRecognitionResultHandler(onRecognitionResult);
  }

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: Text('Test'),
      ),
    );
  }

  void onRecognitionResult(String text) => setState(() {
        if (text == "Next" || text == "next") {
          exit(0);
        } else if (text == "Back" || text == "back") {
          Navigator.pop(context);
        } else {
          transcription = text;
        }
      });
}
