import 'package:examplevoice/overview.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:permission/permission.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Command Voice'),
    );
  }
}

const languages = const [
  const Language('English', 'en_US'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String getPermission = '';
  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String _currentLocale = 'en_US';

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
    requestPermission();
  }

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.mic,
              size: 80.0,
            ),
            Text("Trun on and Navigate to home"),
            _buildButton(
              onPressed: _speechRecognitionAvailable && !_isListening
                  ? () => start()
                  : null,
              label: _isListening ? 'Listening...' : 'Trun On',
            ),
            _buildButton(
              onPressed: _isListening ? () => stop() : null,
              label: 'Stop',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Overview()));
        },
      ),
    );
  }

  Widget _buildButton({String label, VoidCallback onPressed}) => new Padding(
      padding: new EdgeInsets.all(12.0),
      child: new RaisedButton(
        color: Colors.red,
        onPressed: onPressed,
        child: new Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ));
  void start() => _speech
      .listen(locale: _currentLocale)
      .then((result) => print('_MyAppState.start => result ${result}'));

  void stop() =>
      _speech.stop().then((result) => setState(() => _isListening = result));

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    setState(() => _currentLocale = locale);
  }

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionComplete() => setState(() => _isListening = false);
  requestPermission() async {
    final res =
        await Permission.requestSinglePermission(PermissionName.Microphone);
    print(res);
  }
}
