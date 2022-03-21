import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoodlePage extends StatefulWidget {
  const MoodlePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoodlePageState();
}

class _MoodlePageState extends State<MoodlePage> {
  late WebViewController _moodleController;
  double progress = 0;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          if (await _moodleController.canGoBack()) {
            _moodleController.goBack();
          } else {
            return true;
          }
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Moodle'),
              backgroundColor: Colors.blueAccent,
              actions: [
                IconButton(
                    onPressed: () async {
                      if (await _moodleController.canGoBack()) {
                        _moodleController.goBack();
                      }
                      return;
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                IconButton(
                    onPressed: () async {
                      if (await _moodleController.canGoForward()) {
                        _moodleController.goForward();
                      }
                      return;
                    },
                    icon: const Icon(Icons.arrow_forward_ios)),
                IconButton(
                    onPressed: () => _moodleController.reload(),
                    icon: const Icon(Icons.replay)),
              ],
            ),
            body: Column(children: [
              LinearProgressIndicator(
                value: progress,
                color: Colors.blueAccent,
                backgroundColor: Colors.white,
              ),
              Expanded(
                child: WebView(
                  initialUrl: 'https://moodle.astanait.edu.kz/',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    _moodleController = controller;
                  },
                  onProgress: (progress) {
                    this.progress = progress / 100;
                    setState(() {});
                  },
                ),
              ),
            ])),
      );
}
