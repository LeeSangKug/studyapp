import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts_web.dart';
import 'utils/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'My Best Friend',
      home: new MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final TextStyle textStyle = GoogleFonts.mukta(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 28,
    ),
  );

  final TextStyle textStyle2 = GoogleFonts.mukta(
    textStyle: TextStyle(
      color: Colors.white60,
      fontSize: 28,
    ),
  );

  List<Data> list = List<Data>();
  FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  Future _speak(String newText) async {
    var result = await flutterTts.speak(newText);
    if (result == 1)
      setState(() {
        ttsState = TtsState.playing;
      });
  }

  int currnet = 0;

  @override
  Widget build(BuildContext context) {
    _speak('I am sorry for the late reply.');
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        list[index].content,
                        style: textStyle2,
                      ),
                    );
                  },
                  itemCount: list == null ? 0 : list.length,
                ),
              ),
              TypewriterAnimatedTextKit(
                text: [
                  'A: I am sorry for the late reply.',
                  'B: Never mind. It\'s not important.',
                  'C: Never mind. It\'s not important.',
                  'D: Never mind. It\'s not important.',
                  'D: Never mind. It\'s not important.',
                  'D: Never mind. It\'s not important.',
                  'D: Never mind. It\'s not important.',
                  'D: Never mind. It\'s not important.',
                  'D: Never mind. It\'s not important.',
                  'D: Never mind. It\'s not important.',
                ],
                textStyle: textStyle,
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.centerStart,
                totalRepeatCount: 1,
                onNextBeforePause: (idx, _bool, _text) {
                  _speak(_text);
                },
                onNext: (idx, _bool, _text) {
                  if (!_bool) {
                    setState(() {
                      list.insert(idx, new Data(idx, _text));
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

class Data {
  int index;
  String content;

  Data(this.index, this.content);
}
