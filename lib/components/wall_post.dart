import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/like_button.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  List<String> likes;

  WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.likes,
    required this.postId,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  // get user

  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.likes.contains(currentUser!.email);
  }

  //toggle likes
  void toggleLikes() {
    setState(() {
      isLiked = !isLiked;
    });

    // Acess the document in fire base
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("User Post").doc(widget.postId);

    // if(isLiked){
    //   postRef.update(
    //      'Likes': FieldValue.arrayUnion([currentUser!.email]));
    // }else{
    //    postRef.update(
    //   'Likes': FieldValue.arrayRemove([currentUser!.email])
    //   );

    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //like button

            LikeButton(isLiked: isLiked, onTap: toggleLikes),
         const   SizedBox(
              width: 40,
            ),
            Column(
              //text we type and post
              children: [
               const  SizedBox(
                  height: 10,
                ),
                Text(widget.user),
                Text(widget.message)
              ],
            )
          ],
        ),
      ),
    );
  }
}
