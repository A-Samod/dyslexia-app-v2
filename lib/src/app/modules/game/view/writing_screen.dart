// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../../../widgets/icon_button_widget.dart';
// import '../../../widgets/primary_button_widget.dart';
// import '../widgets/results_dialog.dart';

// class WritingScreen extends StatefulWidget {
//   const WritingScreen({
//     super.key,
//     required this.title,
//   });

//   final String title;

//   @override
//   State<WritingScreen> createState() => _WritingScreenState();
// }

// class _WritingScreenState extends State<WritingScreen> {
//   @override
//   void initState() {
//     //---- show screen only for landscape mode
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: OrientationBuilder(
//         builder: (context, orientation) {
//           if (orientation == Orientation.portrait) {
//             return const Center(
//               child: Text('Turn your phone to landscape mode to continue.'),
//             );
//           } else {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(
//                     'assets/images/selectScreenBG.jpeg',
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Center(
//                   child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   children: [
//                     //----- writing area
//                     Expanded(
//                       flex: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Container(
//                           height: MediaQuery.of(context).size.height,
//                           decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.95),
//                               borderRadius: BorderRadius.circular(8.0)),
//                           child: const Center(child: Text('Text Area')),
//                         ),
//                       ),
//                     ),
//                     //----- overview area
//                     Expanded(
//                       flex: 1,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height,
//                           decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.7),
//                               borderRadius: BorderRadius.circular(8.0)),
//                           child: Column(
//                             children: [
//                               //----Icon buttons
//                               Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Row(
//                                   children: [
//                                     IconButtonWidget(
//                                       icon: Icons.arrow_back_ios_new,
//                                       onPressedFunc: () {
//                                         Navigator.pop(context);
//                                       },
//                                     ),
//                                     const Spacer(),
//                                     IconButtonWidget(
//                                       icon: Icons.mic,
//                                       onPressedFunc: () {},
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 10),

//                               //----title
//                               const Text(
//                                 'ට අකුර ලියන්න',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 30),

//                               //----actions
//                               PrimaryButtonWidget(
//                                 title: 'හදුනාගන්න',
//                                 onPressedFunc: () {
//                                   showResultsDialog(context);
//                                 },
//                               ),
//                               const SizedBox(height: 10),
//                               PrimaryButtonWidget(
//                                 title: 'මකන්න',
//                                 onPressedFunc: () {},
//                               ),
//                               const SizedBox(height: 40),

//                               //----time and results
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 20),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'කාලය',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         Spacer(),
//                                         Text(
//                                           '00.45',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'වැරදි ගණන',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         Spacer(),
//                                         Text(
//                                           '5',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'වාර ගණන',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         Spacer(),
//                                         Text(
//                                           '3',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//================================================================================================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../../widgets/icon_button_widget.dart';
import '../../../widgets/primary_button_widget.dart';
import '../widgets/results_dialog.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 9.0,
    penColor: const Color.fromARGB(255, 0, 0, 0), // Set pen color to black
    exportPenColor: const Color.fromARGB(255, 255, 255, 255), // For export
    exportBackgroundColor: const Color.fromARGB(255, 0, 0, 0), // For export
  );

  String feedbackMessage = "";

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
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
    super.dispose();
  }

  // Function to upload the image and receive predicted letter
  Future<String> uploadImage(File imageFile) async {
    try {
      print('Uploading image...');
      var request = http.MultipartRequest(
        'POST',
      //Uri.parse('http://192.168.1.15:4000/uploads'), // Update with your endpoint
       // Uri.parse('http://10.0.2.2/uploads')
       Uri.parse('http://10.0.2.2:4000/uploads')
       // http://20.255.49.219:6000/uploads
      // Uri.parse('http://20.255.49.219:6000/uploads')
      );
      
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      print('Uploading image close ...');
      var response = await request.send();
      if (response.statusCode == 200) {
         print('Uploading image 2 ...');
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
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return const Center(
              child: Text('Turn your phone to landscape mode to continue.'),
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Spacer(),
                                      IconButtonWidget(
                                        icon: Icons.mic,
                                        onPressedFunc: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),

                                //----title
                                const Text(
                                  'ට අකුර ලියන්න',
                                  style: TextStyle(
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
                                    final signatureImage = await _controller.toPngBytes();
                                    if (signatureImage != null) {
                                      print('Signature image created');
                                      final tempDir = await getTemporaryDirectory();
                                      final filePath = '${tempDir.path}/signature.png';
                                      final signatureFile = File(filePath);
                                      await signatureFile.writeAsBytes(signatureImage);

                                      String predictedLetter = await uploadImage(signatureFile);
                                      print('Upload result: $predictedLetter');
                                      setState(() {
                                        feedbackMessage =
                                            'Predicted letter: $predictedLetter';
                                      });
                                    } else {
                                      print('No signature to upload');
                                      setState(() {
                                        feedbackMessage = 'No signature to upload';
                                      });
                                    }
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'කාලය',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            '00.45',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'වැරදි ගණන',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            '5',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'වාර ගණන',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            '3',
                                            style: TextStyle(color: Colors.white),
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
    );
  }
}
//================================================================================================

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// class WritingScreen extends StatefulWidget {
//   final String type;

//   const WritingScreen({required this.type, Key? key}) : super(key: key);

//   @override
//   _WritingScreenState createState() => _WritingScreenState();
// }

// class _WritingScreenState extends State<WritingScreen> {
//   final FlutterTts flutterTts = FlutterTts();

//   String? content; // To store the fetched letter/word
//   int wrongCount = 0;
//   int roundCount = 1;
//   Stopwatch stopwatch = Stopwatch();

//   @override
//   void initState() {
//     super.initState();
//     _fetchLetterOrWord();
//     stopwatch.start();
//   }

//   @override
//   void dispose() {
//     stopwatch.stop();
//     super.dispose();
//   }

//   Future<void> _fetchLetterOrWord() async {
//     final url = Uri.parse('http://10.0.2.2:4000/api/letters/${widget.type}');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         content = data['data']['content'];
//       });
//     } else {
//       print('Failed to fetch letter/word');
//     }
//   }

//   Future<void> _submitMetrics() async {
//     final elapsedTime = stopwatch.elapsed.inSeconds;

//     final body = json.encode({
//       "userId": "pUZXK5VzDp2NBspNBp4o",
//       "letterOrWord": content,
//       "type": widget.type,
//       "usedTime": elapsedTime,
//       "wrongCount": wrongCount,
//       "roundCount": roundCount,
//     });

//     final url = Uri.parse('http://10.0.2.2:4000/api/user-activities/submit');
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: body,
//     );

//     if (response.statusCode == 200) {
//       print('Metrics submitted successfully');
//     } else {
//       print('Failed to submit metrics');
//     }
//   }

//   Future<void> _speak(String text) async {
//     await flutterTts.setLanguage("si-LK");
//     await flutterTts.setPitch(1.0);
//     await flutterTts.setSpeechRate(0.5);
//     await flutterTts.speak(text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Writing Screen')),
//       body: content == null
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   content!,
//                   style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
//                 ),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.mic),
//                   label: const Text('Speak'),
//                   onPressed: () => _speak(content!),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     await _submitMetrics();
//                     setState(() {
//                       wrongCount = 0;
//                       roundCount += 1;
//                     });
//                   },
//                   child: const Text('Submit'),
//                 ),
//               ],
//             ),
//     );
//   }
// }
