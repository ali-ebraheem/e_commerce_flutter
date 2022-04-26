import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/modules/Notification/Notification.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/states.dart';
import '../../Shared/components/components.dart';
import '../Chat/ChatScreen.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
            body: ConditionalBuilder(
                condition: state is GetConversatinLoadingState,
                builder: (context) => Center(
                        child: CircularProgressIndicator(
                      color: switchColors,
                    )),
                fallback: (context) => SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Search
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
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
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  ProjectCubit.get(context).createConversation(
                                      userId: ProjectCubit.get(context)
                                          .conversationModel!
                                          .data![index]
                                          .user!
                                          .id);
                                  ProjectCubit.get(context)
                                      .getMessageForConversation(
                                          conversationId:
                                              ProjectCubit.get(context)
                                                  .conversationModel!
                                                  .data![index]
                                                  .id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                                name: ProjectCubit.get(context)
                                                    .conversationModel!
                                                    .data![index]
                                                    .user!
                                                    .name,
                                                image: ProjectCubit.get(context)
                                                    .conversationModel!
                                                    .data![index]
                                                    .user!
                                                    .picture,
                                              )));
                                },
                                child: messageItem(
                                    context: context,
                                    date: ProjectCubit.get(context)
                                                .conversationModel!
                                                .data![index]
                                                .lastMessage ==
                                            null
                                        ? ''
                                        : ProjectCubit.get(context)
                                            .conversationModel!
                                            .data![index]
                                            .lastMessage!
                                            .createdAt!
                                            .substring(11, 16),
                                    image: ProjectCubit.get(context)
                                        .conversationModel!
                                        .data![index]
                                        .user!
                                        .picture,
                                    lastMessage: ProjectCubit.get(context)
                                                .conversationModel!
                                                .data![index]
                                                .lastMessage ==
                                            null
                                        ? 'there is not any message'
                                        : ProjectCubit.get(context)
                                            .conversationModel!
                                            .data![index]
                                            .lastMessage!
                                            .body,
                                    name: ProjectCubit.get(context)
                                        .conversationModel!
                                        .data![index]
                                        .user!
                                        .name)),
                            separatorBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                height: 1,
                                color: Colors.black38,
                              ),
                            ),
                            itemCount: ProjectCubit.get(context)
                                .conversationModel!
                                .data!
                                .length,
                            shrinkWrap: true,
                          ),
                        ],
                      ),
                    )),
          );
        });
  }
}
