import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:project_collage/models/FollowingModel.dart';
import 'package:project_collage/modules/Notification/Notification.dart';

class FollowersScreen extends StatelessWidget {
  final List<dynamic>? followingId;
  final List<Data>? followers;
  FollowersScreen({@required this.followingId, @required this.followers});
  @override
  Widget build(BuildContext context) {
    List<dynamic>? followingIds = followingId;

    List<bool> followState = [];
    for (var i = 0; i < followers!.length; i++) {
      followState.add(followingIds!.contains(followers![i].id));
    }
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Followers',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: textColor),
                ),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    ProjectCubit.get(context).getFollowing(
                        userId: ProjectCubit.get(context).profile!.data![0].id);
                    ProjectCubit.get(context).getFollowers(
                        userId: ProjectCubit.get(context).profile!.data![0].id);
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
                condition: state is GetFollowersLoadingState ||
                    state is GetFollowingLoadingState,
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
                        itemBuilder: (context, index) => followersItem(
                          followState[index],
                          () {
                            followState[index] = ProjectCubit.get(context)
                                .changeFollowingState(followState[index]);
                          },
                          context,
                          ProjectCubit.get(context)
                              .followersModel!
                              .data![index],
                          followingId!,
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Divider(
                            height: 1,
                            color: Colors.black38,
                          ),
                        ),
                        itemCount: ProjectCubit.get(context)
                            .followersModel!
                            .data!
                            .length,
                        shrinkWrap: true,
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
