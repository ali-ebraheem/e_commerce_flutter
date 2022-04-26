import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_collage/Shared/components/components.dart';
import '../../Cubit/cubit.dart';
import '../../Cubit/states.dart';

class ChatScreen extends StatelessWidget {
  final name;
  final image;
  ChatScreen({@required this.name, @required this.image});
  @override
  Widget build(BuildContext context) {
    ProjectCubit.get(context).listenToDatabase();

    return Builder(builder: (BuildContext context) {
      return BlocConsumer<ProjectCubit, ProjectStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [],
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(image),
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
                            name,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(fontSize: 14, color: textColor),
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
                    ProjectCubit.get(context)
                        .messageConversationModel!
                        .data!
                        .clear();
                    ProjectCubit.get(context).getAllConversation();
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Column(children: [
                Expanded(
                  child: ConditionalBuilder(
                    condition:
                        ProjectCubit.get(context).messageConversationModel ==
                            null,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: switchColors,
                      )),
                    ),
                    fallback: (context) => messageList(
                        messages: ProjectCubit.get(context)
                                    .messageConversationModel!
                                    .data ==
                                null
                            ? []
                            : new List.from(ProjectCubit.get(context)
                                .messageConversationModel!
                                .data!
                                .reversed)),
                  ),
                ),
                actionBar(
                    message: () {
                      ProjectCubit.get(context).realTimeDatabase(
                          text: controller.text,
                          conversationId:
                              ProjectCubit.get(context).converastionid);
                    },
                    sendMessage: () {
                      ProjectCubit.get(context).sendMessage(
                          conversationId:
                              ProjectCubit.get(context).converastionid,
                          body: controller.text);
                    },
                    count: () {}),
              ]),
            );
          });
    });
  }

  Widget messageList({@required messages}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: messages.length,
        reverse: true,
        separatorBuilder: (context, index) {
          if (index == messages.length - 1) {
            return dateLable(time: messages[index].createdAt);
          }
          if (messages.length == 1) {
            return const SizedBox.shrink();
          } else if (index >= messages.length - 1) {
            return const SizedBox.shrink();
          } else if (index <= messages.length) {
            final message = messages[index];
            final nextMessage = messages[index + 1];
            if (message.createdAt.substring(0, 10) !=
                nextMessage.createdAt.substring(0, 10)) {
              return dateLable(time: message.createdAt);
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
            if (message.userId == myId) {
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
  return ConditionalBuilder(
      condition: message.body == 'messageConversationModel1!.body',
      builder: (c) {
        return SizedBox();
      },
      fallback: (c) => Padding(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 20),
                      child: Text('${message.body}'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '${message.createdAt.substring(11, 16)}',
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
          ));
}

@override
Widget messageOwnTile({@required message}) {
  return ConditionalBuilder(
      condition: message.body == 'messageConversationModel1!.body',
      builder: (c) {
        return SizedBox();
      },
      fallback: (c) => Padding(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 20),
                      child: Text('${message.body}',
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '${message.createdAt.substring(11, 16)}',
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
          ));
}

Widget dateLable({@required time}) {
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
            time.substring(0, 10),
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

Widget actionBar(
    {@required Function? message,
    @required Function? sendMessage,
    @required Function? count}) {
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
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: GlowingActionButton(
            color: switchColors,
            icon: Icons.send_rounded,
            onPressed: () {
              count!();
              sendMessage!();
              message!();
              controller.clear();
            },
          ),
        ),
      ],
    ),
  );
}
