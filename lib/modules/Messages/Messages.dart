import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/modules/Notification/Notification.dart';

import '../../Shared/components/components.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()),
                    );
                  },
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
          mainAxisSize: MainAxisSize.min,
          children: [
            //Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: secondColor,
                  ),
                  width: double.infinity,
                  height: 40,
                  child: TextField(
                      style: TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: SvgPicture.asset(
                            "assets/icons/Search Icon.svg",
                            height: 20,
                            width: 20,
                            color: Colors.black87,
                          ),
                        ),
                        border: InputBorder.none,
                      ))),
            ),
            SizedBox(
              height: 20,
            ),

            ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => messageItem(context: context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Divider(
                  height: 1,
                  color: Colors.black38,
                ),
              ),
              itemCount: 10,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
