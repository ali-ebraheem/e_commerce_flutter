import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:project_collage/modules/Categories/Categories.dart';
import 'package:project_collage/modules/Following/Following.dart';
import 'package:project_collage/modules/Home/home.dart';
import 'package:project_collage/modules/Messages/Messages.dart';
import 'package:project_collage/modules/Profile/profile.dart';
import 'package:project_collage/modules/Saved/Saved.dart';
import 'package:project_collage/modules/Selling/Selling.dart';
import 'package:project_collage/modules/Setting/Setting.dart';

class NavegationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) => Drawer(
              child: Material(
                color: mainColor,
                child: ListView(
                  children: <Widget>[
                    buildHeader(
                        name: name,
                        email: email,
                        onClicked: () {
                          ProjectCubit.get(context).getProfileUser(id: myId);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                        }),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(height: 18),
                          buildMenuItem(
                            text: 'Home',
                            icon: Icons.home_outlined,
                            color: switchColors,
                            onClicked: () => selectedItem(context, 0),
                          ),
                          const SizedBox(height: 10),
                          buildMenuItem(
                            text: 'Messages',
                            icon: Icons.mail_outline,
                            color: switchColors,
                            onClicked: () => selectedItem(context, 1),
                          ),
                          const SizedBox(height: 10),
                          buildMenuItem(
                            text: 'Saved',
                            color: savedColor,
                            icon: Icons.favorite,
                            onClicked: () => selectedItem(context, 2),
                          ),
                          const SizedBox(height: 10),
                          buildMenuItem(
                            text: 'Selling',
                            color: switchColors,
                            icon: Icons.business,
                            onClicked: () => selectedItem(context, 3),
                          ),
                          const SizedBox(height: 10),
                          buildMenuItem(
                              text: 'Folowing',
                              color: switchColors,
                              icon: Icons.people,
                              onClicked: () {
                                ProjectCubit.get(context)
                                    .getFollowing(userId: myId);

                                selectedItem(context, 4);
                              }),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              height: 1,
                              color: switchColors,
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildMenuItem(
                            text: 'Categories',
                            color: switchColors,
                            icon: Icons.category_outlined,
                            onClicked: () => selectedItem(context, 5),
                          ),
                          const SizedBox(height: 10),
                          buildMenuItem(
                            text: 'Settings',
                            color: switchColors,
                            icon: Icons.settings_outlined,
                            onClicked: () => selectedItem(context, 6),
                          ),
                          const SizedBox(height: 10),
                          buildMenuItem(
                            text: 'About us',
                            color: switchColors,
                            icon: Icons.help_outline,
                            onClicked: () => selectedItem(context, 7),
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
  Color? color,
}) {
  final hoverColor = switchColors;

  return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        horizontalTitleGap: 5,
        leading: Icon(icon, color: color),
        title: Text(text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            )),
        hoverColor: hoverColor,
        onTap: onClicked,
      ));
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();

  switch (index) {
    case 0:
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen()));

      break;
    case 1:
      ProjectCubit.get(context).getAllConversation();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MessagesScreen()),
      );
      break;
    case 2:
      ProjectCubit.get(context).getFavorite();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SavedScreen()),
      );
      break;
    case 3:
      ProjectCubit.get(context).getProductForUser();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SellingScreen()),
      );
      break;
    case 4:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FollowingScreen()),
      );
      break;
    case 5:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CtaegoriesScreen()),
      );
      break;
    case 6:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingScreen()),
      );
      break;
  }
}

Widget buildHeader({
  required String name,
  required String email,
  required VoidCallback onClicked,
}) =>
    InkWell(
      onTap: onClicked,
      child: Container(
        color: switchColors,
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/Profile Image.png'),
                radius: 40,
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 180,
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 180,
                  child: Text(
                    email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
