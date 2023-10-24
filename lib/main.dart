import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:audioplayers/audioplayers.dart';
// ignore: implementation_imports
//import 'package:assets_audio_player/src/assets_audio_player.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const PianoScreen());
}

final assetsAudioPlayer = AssetsAudioPlayer();
final FocusNode _focusNode = FocusNode();

class PianoScreen extends StatefulWidget {
  const PianoScreen({super.key});
  @override
  State<PianoScreen> createState() => _PianoScreenState();
}

void _readTone(String tone) {
  assetsAudioPlayer.open(
    Audio("assets/notes/$tone.mp3"),
  );
}

class _PianoScreenState extends State<PianoScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("PIANO"),
          ),
        ),
        body: Container(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double whiteWidth = constraints.maxWidth / 7;
            //FocusScope.of(context).requestFocus(focusNode);
            return RawKeyboardListener(
              autofocus: true,
              focusNode: _focusNode,
              onKey: _handleKeyEvent,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  whiteTile('C', 0, whiteWidth),
                  whiteTile('D', 1, whiteWidth),
                  whiteTile('E', 2, whiteWidth),
                  whiteTile('F', 3, whiteWidth),
                  whiteTile('G', 4, whiteWidth),
                  whiteTile('A', 5, whiteWidth),
                  whiteTile('B', 6, whiteWidth),
                  whiteTile('A', 7, whiteWidth),
                  whiteTile('B', 8, whiteWidth),
                  whiteTile('C', 9, whiteWidth),
                  blackTile('Db', 1, whiteWidth, constraints.maxHeight / 2),
                  blackTile('Eb', 2, whiteWidth, constraints.maxHeight / 2),
                  //blackTile('Eb', 3, whiteWidth, constraints.maxHeight / 2),
                  blackTile('Gb', 4, whiteWidth, constraints.maxHeight / 2),
                  blackTile('Ab', 5, whiteWidth, constraints.maxHeight / 2),
                  blackTile('Bb', 6, whiteWidth, constraints.maxHeight / 2),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

Widget whiteTile(String tone, double position, double whiteWidth) {
  return Positioned(
    top: 0.0,
    left: position * whiteWidth,
    width: whiteWidth,
    bottom: 0,
    child: RawMaterialButton(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1.0),
        ),
        onPressed: () => _readTone(tone)),
  );
}

Widget blackTile(
    String tone, double position, double whiteWidth, double height) {
  double blackWidth = whiteWidth * 0.60;
  return Positioned(
    top: 0,
    left: position * whiteWidth - blackWidth / 2,
    width: blackWidth,
    height: height,
    child: RawMaterialButton(
        fillColor: Colors.black,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1.0),
        ),
        onPressed: () => _readTone(tone)),
  );
}

void _handleKeyEvent(RawKeyEvent event) {
  if (event.logicalKey == LogicalKeyboardKey.keyZ) {
    _readTone('C');
  } else if (event.logicalKey == LogicalKeyboardKey.keyX)
    // ignore: curly_braces_in_flow_control_structures
    _readTone('D');
  else if (event.logicalKey == LogicalKeyboardKey.keyC)
    // ignore: curly_braces_in_flow_control_structures
    _readTone('E');
  else if (event.logicalKey == LogicalKeyboardKey.keyV)
    // ignore: curly_braces_in_flow_control_structures
    _readTone('F');
  else if (event.logicalKey == LogicalKeyboardKey.keyB)
    // ignore: curly_braces_in_flow_control_structures
    _readTone('G');
  else if (event.logicalKey == LogicalKeyboardKey.keyN)
    // ignore: curly_braces_in_flow_control_structures
    _readTone('A');
  else if (event.logicalKey == LogicalKeyboardKey.keyM)
    // ignore: curly_braces_in_flow_control_structures
    _readTone('B');
  else if (event.logicalKey == LogicalKeyboardKey.keyS)
    // ignore: curly_braces_in_flow_control_structures
    _readTone('Db');
  else if (event.logicalKey == LogicalKeyboardKey.keyD)
    // ignore: curly_braces_in_flow_control_structures
    _readTone('Eb');
  else if (event.logicalKey == LogicalKeyboardKey.keyF)
    // ignore: curly_braces_in_flow_control_structures
    _readTone('Gb');
  else if (event.logicalKey == LogicalKeyboardKey.keyH)
    // ignore: curly_braces_in_flow_control_structures
    _readTone('Ab');

  // ignore: curly_braces_in_flow_control_structures
  else if (event.logicalKey == LogicalKeyboardKey.keyJ) _readTone('Bb');
}
