import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final curentUser = FirebaseAuth.instance.currentUser;

  Future<void> editField(String field) async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile Page"),
        backgroundColor: Colors.grey[900],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.person,
            color: Colors.black,
            size: 64,
          ),
          SizedBox(
            height: 10,
          ),

          ///user email
          Center(child: Text("${curentUser!.email}")),
          SizedBox(
            height: 20,
          ),
          ////user Details
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("My Details"),
          ),

          ///user name
          MyTextBox(
            text: "😄😄😄😄😄",
            sectionName: "User Name",
            onPressed: () => editField("user name"),
          ),

          ////bio
          MyTextBox(
            text: "C H I L L 😄  ",
            sectionName: "Bio",
            onPressed: () => editField("user name"),
          ),

          ///user posts
          ///
          ///
        ],
      ),
    );
  }
}
