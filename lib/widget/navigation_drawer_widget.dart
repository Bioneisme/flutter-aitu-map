import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/page/moodle_page.dart';
import 'package:flutter_app/page/schedule_page.dart';
import 'package:flutter_app/page/settings_page.dart';

class NavigationDrawerWidget extends StatelessWidget{
  final padding = const EdgeInsets.symmetric(horizontal: 50);

  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 12),
            buildMenuItem(text: 'University map', icon: Icons.map_outlined,
                onClicked: () => selectedItem(context, 0)),
            const SizedBox(),
            buildMenuItem(text: 'Schedule', icon: Icons.assignment,
                onClicked: () => selectedItem(context, 1)),
            // const SizedBox(height: 12),
            // const Divider(color: Colors.white70),
            // const SizedBox(height: 12),
            const SizedBox(),
            buildMenuItem(text: 'Moodle', icon: Icons.info,
                onClicked: () => selectedItem(context, 2)),
            const SizedBox(),
            buildMenuItem(text: 'Settings', icon: Icons.settings,
                onClicked: () => selectedItem(context, 3))
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
}) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index){
    switch (index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HomePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SchedulePage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MoodlePage(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SettingsPage(),
        ));
        break;
    }
  }

}