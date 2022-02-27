import 'package:flutter/material.dart';
import 'package:project_collage/Shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.person),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ali ebraheem',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: textColor),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'online',
                    style: TextStyle(
                      color: Color.fromARGB(255, 89, 187, 92),
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(children: [
        Expanded(
          child: messageList(messages: [
            {
              "id": '3',
              "body":
                  "igroigjortoghoir ohtgoehrtgo hrtogihoeit ierohtgoih rthgo ihrtgj",
              "date": "12:12"
            },
            {
              "id": '4',
              "body": "gtregrtg tegre ggggertg gertg rtg",
              "date": "12:12"
            },
            {"id": '3', "body": "hdrtjhoij drhpo", "date": "12:12"},
            {"id": '4', "body": "hoihasohid", "date": "12:12"},
            {
              "id": '3',
              "body": "thdrth ipohiopidrtohi ptohrt",
              "date": "12:12"
            },
            {"id": '3', "body": "hdrthiu poritho", "date": "12:12"},
            {"id": '3', "body": "htrhhtdrho htdrh", "date": "12:12"},
            {"id": '3', "body": "yghsrtgo otrhoi tyrh ", "date": "12:12"}
          ]),
        ),
        actionBar(),
      ]),
    );
  }

  Widget messageList({@required messages}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: messages.length + 1,
        reverse: true,
        separatorBuilder: (context, index) {
          if (index == messages.length - 1) {
            return dateLable();
          }
          if (messages.length == 1) {
            return const SizedBox.shrink();
          } else if (index >= messages.length - 1) {
            return const SizedBox.shrink();
          } else if (index <= messages.length) {
            final message = messages[index];
            final nextMessage = messages[index + 1];
            if (true) {
              return dateLable();
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        },
        itemBuilder: (context, index) {
          if (index < messages.length) {
            final message = messages[index];
            if (index.isEven) {
              return messageOwnTile(message: message);
            } else {
              return messageTile(message: message);
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

const _borderRadius = 26.0;

@override
Widget messageTile({@required message}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: secondColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(_borderRadius),
                topRight: Radius.circular(_borderRadius),
                bottomRight: Radius.circular(_borderRadius),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
              child: Text('${message!['body']}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '11:12 pm',
              style: const TextStyle(
                color: textColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

@override
Widget messageOwnTile({@required message}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Align(
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: switchColors,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_borderRadius),
                bottomRight: Radius.circular(_borderRadius),
                bottomLeft: Radius.circular(_borderRadius),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
              child: Text(message["body"],
                  style: const TextStyle(
                    color: Colors.white,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '12:12 pm',
              style: const TextStyle(
                color: textColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

var dayInfo;
Widget dateLable() {
  if (false) {
    dayInfo = 'TODAY';
  } else if (true) {
    dayInfo = 'YESTERDAY';
  } else if (true) {
    dayInfo = '0';
  } else if (true) {
    dayInfo = '0';
  } else {
    dayInfo = '0';
  }
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Container(
        decoration: BoxDecoration(
          color: secondColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
          child: Text(
            dayInfo,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    ),
  );
}

final TextEditingController controller = TextEditingController();

Widget actionBar() {
  return SafeArea(
    bottom: true,
    top: false,
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 2,
                color: secondColor,
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.camera_alt_rounded,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              controller: controller,
              onChanged: (val) {},
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Type something...',
                border: InputBorder.none,
              ),
              onSubmitted: (_) => () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: GlowingActionButton(
            color: switchColors,
            icon: Icons.send_rounded,
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}
