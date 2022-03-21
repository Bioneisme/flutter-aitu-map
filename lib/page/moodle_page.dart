import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoodlePage extends StatefulWidget {
  const MoodlePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoodlePageState();
}

class _MoodlePageState extends State<MoodlePage> {
  late WebViewController _MoodleController;
  double progress = 0;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          if (await _MoodleController.canGoBack()) {
            _MoodleController.goBack();
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
                      if (await _MoodleController.canGoBack()) {
                        _MoodleController.goBack();
                      }
                      return;
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                IconButton(
                    onPressed: () async {
                      if (await _MoodleController.canGoForward()) {
                        _MoodleController.goForward();
                      }
                      return;
                    },
                    icon: const Icon(Icons.arrow_forward_ios)),
                IconButton(
                    onPressed: () => _MoodleController.reload(),
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
                    _MoodleController = controller;
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
