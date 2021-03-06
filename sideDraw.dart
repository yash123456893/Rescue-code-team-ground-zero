import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDraw extends StatelessWidget {
  final name;
  final profilePicture;
  SideDraw(this.name, this.profilePicture);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "profile");
              },
              child: Column(
                children: <Widget>[
                  Container(
                    height: 113,
                    width: 113,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff7c94b6),
                      image: DecorationImage(
                        image: profilePicture == null
                            ? new ExactAssetImage('assets/profilepic.png')
                            : NetworkImage(profilePicture),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '$name',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.ambulance,
              size: 30,
              color: Colors.red,
            ),
            title: Text("Call Ambulance"),
            title: Text("Vaccine availability"),
            subtitle: Text("For Urgent actions."),
            onTap: () {
              Navigator.pushNamed(context, 'ambulance');
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.fileMedical,
              size: 30,
              color: Colors.red,
            ),
            title: Text("Near Hospitals"),
            subtitle: Text("To contact with the nearest hospital"),
            onTap: () {
              Navigator.pushNamed(context, 'doctors');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              size: 30,
              color: Colors.red,
            ),
            title: Text("About Us "),
            subtitle: Text("About the capstone group."),
            onTap: () {
              Navigator.pushNamed(context, 'about');
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.angleLeft,
              size: 30,
              color: Colors.red,
            ),
            title: Text("Log Out"),
            subtitle: Text("End your session."),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove("uid");
              await prefs.remove("type");
              final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

              await _firebaseMessaging.deleteInstanceID();

              Navigator.pushReplacementNamed(context, 'welcome');
            },
          ),
        ],
      ),
    );
  }
}
