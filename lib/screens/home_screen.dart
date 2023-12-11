import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/drawer.dart';
import 'package:social_media/components/text_field.dart';
import 'package:social_media/components/wall_post.dart';
import 'package:social_media/screens/profile_page.dart';
import 'package:social_media/screens/voice_recogniser.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();
  ScrollController scrollController = ScrollController();
//Signout method
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //post message to db

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Post").add({
        "User Email": currentUser.email,
        "Message": textController.text,
        "TimeStamp": Timestamp.now(),
        "Likes": []
      });
    }
  }

  ////go to profile page////

  goToProfilePage() {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return ProfilePage();
    })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text("Wall"),
        ),
        drawer: MyDrawer(
          profilePage: goToProfilePage,
          signOut: signOut,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // list view that we build posts
            Expanded(
                child: StreamBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      controller: scrollController,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return Center(
                          child: WallPost(
                            message: post["Message"],
                            user: post["User Email"],
                            postId: post.id,
                            likes: List<String>.from(post["Likes"] ?? []),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error :${snapshot.error}"),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
              stream: FirebaseFirestore.instance
                  .collection("User Post")
                  .orderBy("TimeStamp", descending: false)
                  .snapshots(),
            )),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: "",
                      obsecureText: false,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      postMessage();
                      textController.clear();
                    },
                    icon: const Icon(Icons.arrow_circle_up),
                  ),
                  IconButton(
                    onPressed: () async {
                      var result = await showFullScreenContentCreated(context);
                      if (result != null) {
                        setState(() {
                          textController.text = result;
                        });
                      }
                    },
                    icon: const Icon(Icons.mic),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Logged in as :${currentUser.email!}"),
            ),
          ],
        ));
  }
}

Future<String?> showFullScreenContentCreated(
  context,
) async {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          child: SizedBox(width: 400, height: 300, child: SpeechScreen()),
        ),
      );
    },
  );
}
