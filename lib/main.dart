import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/navigation_drawer_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(AituMapApp());

class AituMapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AITU Map',
        theme: ThemeData(
            primaryColor: const Color.fromRGBO(50, 50, 50, 1),
            canvasColor: Colors.white),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  int _selectedIndex = 0;
  late PhotoViewController controller;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w300);
  late List _widgetOptions;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    controller = PhotoViewController()
      ..outputStateStream.listen(listener);

    _widgetOptions = [
      // center
      ['C1.2.1', 3, 6, "assets/C1.2.1.png"], // 0
      ['C1.2.2', 4, 7, "assets/C1.2.2.png"], // 1
      ['C1.2.3', 5, 8, "assets/C1.2.3.png"], // 2
      // left
      ['C1.1.1', 6, 0, "assets/C1.1.1.png"], // 3
      ['C1.1.2', 7, 1, "assets/C1.1.2.png"], // 4
      ['C1.1.3', 8, 2, "assets/C1.1.3.png"], // 5
      // right
      ['C1.3.1', 0, 3, "assets/C1.3.1.png"], // 6
      ['C1.3.2', 1, 4, "assets/C1.3.2.png"], // 7
      ['C1.3.3', 2, 5, "assets/C1.3.3.png"], // 8
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void listener(PhotoViewControllerValue value){
    setState((){});
  }

  void _changePage(int index) {
    setState(() {
      _pageIndex = index;
      controller.scale = 0.8;
      controller.reset();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageIndex = _selectedIndex;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavigationDrawerWidget(),
      appBar: AppBar(title: const Text('AITU Map')),
      body: Column(children: <Widget>[
        Expanded(
            child: Container(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Text(_widgetOptions.elementAt(_pageIndex)[0],
                    style: optionStyle))),
        Expanded(
            flex: 10,
            child: Center(
                child: Stack(children: [
              PhotoView( // center
                  imageProvider: AssetImage(_widgetOptions.elementAt(_pageIndex)[3]),
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.white),
                  initialScale: PhotoViewComputedScale.contained * 1.1,
                  controller: controller,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1.8),
              Align( // right
                  alignment: const Alignment(0.95, 0),
                  child: IconButton(
                      onPressed: () => {_changePage(_widgetOptions.elementAt(_pageIndex)[2])},
                      icon: const Icon(Icons.arrow_forward_ios))),
              Align( // left
                  alignment: const Alignment(-0.95, 0),
                  child: IconButton(
                      onPressed: () => {_changePage(_widgetOptions.elementAt(_pageIndex)[1])},
                      icon: const Icon(Icons.arrow_back_ios))),
            ])))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/first_level.png")),
            label: '1st floor',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/second_level.png")),
            label: '2nd floor',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/third_level.png")),
            label: '3rd floor',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
