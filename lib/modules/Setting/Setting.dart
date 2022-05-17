import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:project_collage/modules/ChangePassowrd/changePassowd.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: secondColor,
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/icons/Bell.svg",
                    height: 22,
                    width: 22,
                    color: switchColors,
                  ),
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Account',
                style: TextStyle(color: switchColors, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                },
                child: Text(
                  'Change passowrd',
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Notifications',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Sign out',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              color: Colors.black38,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'General',
                style: TextStyle(color: switchColors, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Theme',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Country',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Language',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Customer Service',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              color: Colors.black38,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'About',
                style: TextStyle(color: switchColors, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Verson',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Contact with us',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
