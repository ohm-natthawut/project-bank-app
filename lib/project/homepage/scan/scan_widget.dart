import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:just_audio/just_audio.dart';
import 'package:tflite/tflite.dart';

const Map<String, String> labelToAudioMap = {
  'ธนบัตร 20 บาท': 'assets/audios/banknote20.mp3',
  'ธนบัตร 50 บาท': 'assets/audios/banknote50.mp3',
  'ธนบัตร 100 บาท': 'assets/audios/banknote100.mp3',
  'ธนบัตร 500 บาท': 'assets/audios/banknote500.mp3',
  'ธนบัตร 1000 บาท': 'assets/audios/banknote1000.mp3',
};

class ScanWidget extends StatefulWidget {
  @override
  _ScanWidgetState createState() => _ScanWidgetState();
}

class _ScanWidgetState extends State<ScanWidget> {
  bool loading = true;
  late File _image;
  final AudioPlayer _audioPlayer = AudioPlayer();

  double totalAmount = 0;

  List<dynamic> _output = [];
  final imagepicker = ImagePicker();

  final CollectionReference _historyRef =
      FirebaseFirestore.instance.collection('scan_history');

  late just_audio.AudioPlayer _player;

  int count = 0;

  Map<String, int> banknotesCount = {
    'ธนบัตร 20 บาท': 0,
    'ธนบัตร 50 บาท': 0,
    'ธนบัตร 100 บาท': 0,
    'ธนบัตร 500 บาท': 0,
    'ธนบัตร 1000 บาท': 0,
  };

  @override
  void initState() {
    super.initState();
    _playOpeningSound();

    _image = File('');
    loadmodel().then((value) {
      setState(() {});
    });
  }

  Future<void> _playOpeningSound() async {
    try {
      await _audioPlayer.setAsset('assets/audios/scanba.mp3');
      await _audioPlayer.play();

      // Get the duration of the audio
      final duration = await _audioPlayer.duration;

      // Delay navigation for the duration of the audio
      Timer(duration ?? Duration.zero, () {
        Navigator.of(context).pushNamed('homepage');
      });
    } catch (e) {
      print("Error playing opening sound: $e");
    }
  }

  void addToScanHistory(String label, double confidence) async {
    var timestamp = DateTime.now().toUtc();
    var amount = getAmountFromLabel(label);

    setState(() {
      totalAmount += amount;
      count++;

      // Record the number of banknotes scanned
      banknotesCount[label] = banknotesCount[label]! + 1;
    });

    await _historyRef.add({
      'timestamp': timestamp,
      'label': label,
      'confidence': confidence,
      'amount': amount,
      'totalAmount': totalAmount,
      'scanCount': count,
    });
  }

  double getAmountFromLabel(String label) {
    switch (label) {
      case 'ธนบัตร 20 บาท':
        return 20;
      case 'ธนบัตร 50 บาท':
        return 50;
      case 'ธนบัตร 100 บาท':
        return 100;
      case 'ธนบัตร 500 บาท':
        return 500;
      case 'ธนบัตร 1000 บาท':
        return 1000;
      default:
        return 0;
    }
  }

  void detectimage(File image) async {
    var prediction = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 3,
      threshold: 0.6,
      imageMean: 224,
      imageStd: 224,
    );

    setState(() {
      _output = prediction ?? [];
      loading = false;
      if (_output.isNotEmpty) {
        double confidence = double.parse((_output[0]['confidence']).toString());
        if (confidence >= 0.8) {
          addToScanHistory(
            (_output[0]['label']).toString().substring(2),
            confidence,
          );
          playAudio((_output[0]['label']).toString().substring(2));
        } else {
          print("Scan unsuccessful. Confidence below 80%");
        }
      }
    });
  }

  Future<void> playAudio(String label) async {
    final audioUrl = labelToAudioMap[label];
    if (audioUrl != null) {
      _player = just_audio.AudioPlayer();
      await _player.setAudioSource(just_audio.AudioSource.asset(audioUrl));
      await _player.play();
      await _player.dispose();
    } else {
      // Handle missing audio file (optional)
    }
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels_model.txt',
    );
  }

  pickimage_camera() async {
    var image = await imagepicker.getImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _image = File(image.path);
      });
      detectimage(_image);
    }
  }

  pickimage_gallery() async {
    var image = await imagepicker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _image = File(image.path);
      });
      detectimage(_image);
    }
  }

  void _resetScan() {
    setState(() {
      loading = true;
      _output = [];
      totalAmount = 0;
      _image = File('');
      count = 0;
      banknotesCount = {
        'ธนบัตร 20 บาท': 0,
        'ธนบัตร 50 บาท': 0,
        'ธนบัตร 100 บาท': 0,
        'ธนบัตร 500 บาท': 0,
        'ธนบัตร 1000 บาท': 0,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          color: Color(0xFF334E53),
          child: Column(
            children: [
              loading != true
                  ? Container(
                      padding: EdgeInsets.all(50),
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            padding: EdgeInsets.all(15),
                            child: Image.file(_image),
                          ),
                          if (_output.isNotEmpty)
                            Text(
                              (_output[0]['label']).toString().substring(2),
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          if (_output.isNotEmpty)
                            Text(
                              'รวมเงินทั้งหมด: $totalAmount บาท',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          if (count >
                              0) // Check if any banknotes have been scanned
                            Text(
                              'จำนวนการนำแบงค์เข้ามาสแกน: $count ใบ',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          for (var entry in banknotesCount.entries)
                            if (entry.value > 0)
                              Text(
                                '${entry.key} จำนวน: ${entry.value} ใบ',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(60, 100, 60, 0),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/scan.jpg',
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 15),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 80,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Capture',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          HapticFeedback.vibrate();
                          pickimage_camera();
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 80,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Gallery',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          HapticFeedback.vibrate();
                          pickimage_gallery();
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 80,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Reset',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: _resetScan,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
