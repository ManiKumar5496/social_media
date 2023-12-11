import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../components/text_field.dart';

class SpeechScreen extends StatefulWidget {
  
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _textSpeech = '';
  TextEditingController textEditingController = TextEditingController();
  void onListen() async {
    bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'));

    if (!_isListening) {
      if (available) {
        setState(() {
          _isListening = false;
          _speech!.listen(
            onResult: (val) => setState(() {
              _textSpeech = val.recognizedWords;
              textEditingController.text = val.recognizedWords;
            }),
          );
        });
      }
    } else {
      setState(() {
        _isListening = false;
        _speech!.stop();
      });
    }
  }

  void stopListen() {
    _speech!.stop();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    _fondoApp() {
      final gradiente = Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0),
                colors: [Colors.white, Colors.white])),
      );

      return Stack(
        children: <Widget>[gradiente],
      );
    }

    return Scaffold(
        body: Stack(children: <Widget>[
          _fondoApp(),
          Container(
             
              child: Text("",
                  // _textSpeech,
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.w500))),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: FloatingActionButton(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.close),
                        onPressed: () {
                         Navigator.pop(context, textEditingController.text);
                        }),
                  )
                ],
              ),
              SizedBox(height: 30,),
             TextField(
                controller: textEditingController,
               decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        fillColor: Colors.grey
      ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: FloatingActionButton(
                      onPressed: onListen,
                      child: Icon(Icons.mic),
                      backgroundColor: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  SizedBox(
                    child: _speech!.isListening
                        ? Text(
                            "Listening...",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            '',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: FloatingActionButton(
                      child: Icon(Icons.stop),
                      heroTag: "btn2",
                      backgroundColor: Colors.redAccent,
                      onPressed: () => stopListen(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
