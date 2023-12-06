import 'package:flutter/material.dart';
import 'package:social_media/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? profilePage;
  final void Function()? signOut;
  const MyDrawer({required this.profilePage, required this.signOut,super.key, });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          //header
          DrawerHeader(
              child: Icon(
            Icons.person,
            color: Colors.white,
            size: 60,
          )),

          //home list tile
          MyListTile(
            icon: Icons.home,
            text: "H O M E",
            onTap: (() => Navigator.pop(context)),
          
          ),
          //profile list tile
          MyListTile(
              icon: Icons.person,
              text: "P R O F I L E",
              onTap: 
                profilePage
              ),
          //logout list tile
          MyListTile(icon: Icons.logout, text: "L O G O U T", onTap: signOut)
        ],
      ),
    );
  }
}
