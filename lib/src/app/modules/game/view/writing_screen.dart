import 'dart:async';

import 'package:dyslearn/src/app/modules/game/model/submit_answer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../../../core/const/colors.dart';
import '../../../../core/const/constants.dart';
import '../../../widgets/icon_button_widget.dart';
import '../../../widgets/primary_button_widget.dart';
import '../controller/game_controller.dart';
import '../widgets/results_dialog.dart';
//import '../widgets/results_dialog.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({
    super.key,
    required this.gameMode,
  });

  // final String title;
  final String gameMode;

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final GameController gameController = Get.put(GameController());
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 9.0,
    penColor: const Color.fromARGB(255, 0, 0, 0), // Set pen color to black
    exportPenColor: const Color.fromARGB(255, 255, 255, 255), // For export
    exportBackgroundColor: const Color.fromARGB(255, 0, 0, 0), // For export
  );

  final FlutterTts flutterTts = FlutterTts();

  Future _speak(String text) async {
    await flutterTts.setLanguage("si-LK"); // Sinhala
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.1);
    await flutterTts.speak(text);
  }

  String feedbackMessage = "";
  Timer? _timer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    _controller.clear();
    //   gameController.fetchGameInstructions(widget.gameMode);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      gameController.fetchGameInstructions(widget.gameMode);
      _startTimer();
    });
    // _saveGameMode();
    // _startTimer();
    super.initState();
  }

  Future<void> _saveGameMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(GAME_MODE, widget.gameMode);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel(); // Stop the timer
      debugPrint('Counted time: $_elapsedSeconds seconds');
    }
  }

  // Function to upload the image and receive predicted letter
  Future<String> uploadImage(File imageFile) async {
    try {
      debugPrint('Uploading image...');
      var request = http.MultipartRequest(
          'POST',
          //Uri.parse('http://192.168.1.15:4000/uploads'), // Update with your endpoint
          // Uri.parse('http://10.0.2.2/uploads')
          Uri.parse('http://10.0.2.2:4000/uploads')
          // http://20.255.49.219:6000/uploads
          // Uri.parse('http://20.255.49.219:6000/uploads')
          );

      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
      debugPrint('Uploading image close ...');
      var response = await request.send();
      if (response.statusCode == 200) {
        debugPrint('Uploading image 2 ...');
        var jsonResponse = await http.Response.fromStream(response);
        var data = json.decode(jsonResponse.body);

        if (data.containsKey('class')) {
          return data['class'];
        } else {
          return 'Prediction failed: No letter found in response';
        }
      } else {
        return 'Error: Server returned status code ${response.statusCode}';
      }
    } catch (e) {
      return 'Failed to upload image: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => gameController.isLoading.value == true
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: PRIMARY_COLOR,
                    backgroundColor: Colors.black12,
                  ),
                ],
              ),
            )
          : OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return const Center(
                    child:
                        Text('Turn your phone to landscape mode to continue.'),
                  );
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/selectScreenBG.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            //----- writing area
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Signature(
                                    controller: _controller,
                                    backgroundColor: Colors.grey[200]!,
                                  ),
                                ),
                              ),
                            ),
                            //----- overview area
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    children: [
                                      //----Icon buttons
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            IconButtonWidget(
                                              icon: Icons.arrow_back_ios_new,
                                              onPressedFunc: () {
                                                //   Navigator.pop(context);
                                                Navigator.pushReplacementNamed(
                                                    context, '/home');
                                              },
                                            ),
                                            const Spacer(),
                                            IconButtonWidget(
                                              icon: Icons.mic,
                                              onPressedFunc: () => _speak(
                                                  gameController
                                                      .instructionsData[0]
                                                      ?.content),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      //----title
                                      widget.gameMode == 'single'
                                          ? Text(
                                              gameController.instructionsData
                                                      .isNotEmpty
                                                  ? '${gameController.instructionsData[0]?.content} අකුර ලියන්න'
                                                  : 'refresh',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : Text(
                                              gameController.instructionsData
                                                      .isNotEmpty
                                                  ? '${gameController.instructionsData[0]?.content} වචනෙ ලියන්න'
                                                  : 'refresh',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                      const SizedBox(height: 30),

                                      //----actions
                                      PrimaryButtonWidget(
                                        title: 'හදුනාගන්න',
                                        onPressedFunc: () async {
                                          await handleSubmit(context);
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      PrimaryButtonWidget(
                                        title: 'මකන්න',
                                        onPressedFunc: () {
                                          _controller.clear();
                                        },
                                      ),
                                      const SizedBox(height: 40),

                                      //----time and results
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'කාලය',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  _elapsedSeconds.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'වැරදි ගණන',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  gameController
                                                          .submitResponseData
                                                          .isNotEmpty
                                                      ? gameController
                                                          .submitResponseData[0]
                                                          .wrongCount
                                                          .toString()
                                                      : '0',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'වාර ගණන',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  gameController
                                                          .submitResponseData
                                                          .isNotEmpty
                                                      ? gameController
                                                          .submitResponseData[0]
                                                          .roundCount
                                                          .toString()
                                                      : '1',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
    ));
  }

  Future<void> handleSubmit(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    {
      final signatureImage = await _controller.toPngBytes();
      _stopTimer();
      if (signatureImage != null) {
        debugPrint('Signature image created');
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/signature.png';
        final signatureFile = File(filePath);
        await signatureFile.writeAsBytes(signatureImage);

        String predictedLetter = await uploadImage(signatureFile);
        debugPrint('Upload result: $predictedLetter');
        setState(() {
          feedbackMessage = 'Predicted letter: $predictedLetter';
        });
        debugPrint(_elapsedSeconds.toString());
        gameController.submitAnswer(
          context,
          SubmitAnswerModel(
            userId: prefs.getString(UUID) ?? '',
            letterOrWord: gameController.instructionsData[0]?.content,
            writtenLetterOrWord: predictedLetter,
            type: widget.gameMode,
            usedTime: _elapsedSeconds,
            wrongCount: gameController.submitResponseData.isNotEmpty
                ? gameController.submitResponseData[0]?.wrongCount
                : 0,
            roundCount: gameController.submitResponseData.isNotEmpty
                ? gameController.submitResponseData[0]?.roundCount
                : 1,
          ),
        );
        _controller.clear();
        //showResultsDialog(context, gameController);
        //gameController.submitResponseData[0]?.
        showResultsDialog(
          context,
          gameController,
          widget.gameMode,
        );
      } else {
        debugPrint('No signature to upload');
        setState(() {
          feedbackMessage = 'No signature to upload';
        });
      }
    }
  }
}
