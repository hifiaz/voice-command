import 'package:examplevoice/test.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
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
        title: Text('Overview'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(transcription, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
            ),
            Text('Say "Back" to back home \n "Next" to the next page'),
          ],
        ),
      ),
    );
  }

  // void onRecognitionResult(String text) => setState(() => transcription = text);
  void onRecognitionResult(String text) => setState(() {
        if (text == "Next" || text == "next") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Test()));
        } else if (text == "Back" || text == "back") {
          Navigator.pop(context);
        } else {
          transcription = text;
        }
      });
}
