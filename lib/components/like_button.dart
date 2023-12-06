import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  bool isLiked = false;
  Function()? onTap;
  LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.pink : Colors.grey));
  }
}
