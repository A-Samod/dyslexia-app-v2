import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  @override
  void initState() {
    //---- show screen only for landscape mode
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
    super.dispose();
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
                  image: AssetImage(
                    'assets/images/selectScreenBG.jpeg',
                  ),
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
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(child: Text('Text Area')),
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
                              borderRadius: BorderRadius.circular(8.0)),
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
                                onPressedFunc: () {
                                  showResultsDialog(context);
                                },
                              ),
                              const SizedBox(height: 10),
                              PrimaryButtonWidget(
                                title: 'මකන්න',
                                onPressedFunc: () {},
                              ),
                              const SizedBox(height: 40),

                              //----time and results
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'කාලය',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Spacer(),
                                        Text(
                                          '00.45',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'වැරදි ගණන',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Spacer(),
                                        Text(
                                          '5',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'වාර ගණන',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Spacer(),
                                        Text(
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
                    )
                  ],
                ),
              )),
            );
          }
        },
      ),
    );
  }
}
