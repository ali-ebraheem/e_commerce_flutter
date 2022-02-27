import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<bool> savedd = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var profileCubit = ProjectCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Profile',
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
              body: ConditionalBuilder(
                condition: state is GetProfileLoadingState ||
                    state is GetFollowersLoadingState ||
                    state is GetFollowingLoadingState,
                builder: (context) => Center(
                    child: CircularProgressIndicator(
                  color: switchColors,
                )),
                fallback: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      profileItem(
                          followers:
                              ProjectCubit.get(context).followersModel!.data,
                          context: context,
                          numFollowers: ProjectCubit.get(context)
                              .followersModel!
                              .data!
                              .length,
                          numFollowing: ProjectCubit.get(context)
                              .followingModel!
                              .data!
                              .length,
                          folloings:
                              ProjectCubit.get(context).followingModel!.data!,
                          getFollowers: () {
                            ProjectCubit.get(context).getFollowers(
                                userId: ProjectCubit.get(context)
                                    .profile!
                                    .data![0]
                                    .id);
                            ProjectCubit.get(context)
                                .getFollowing(userId: myId);
                          },
                          getFollowing: () {
                            ProjectCubit.get(context).getFollowing(
                                userId: ProjectCubit.get(context)
                                    .profile!
                                    .data![0]
                                    .id);
                          },
                          name: profileCubit.profile!.data![0].name,
                          image: profileCubit.profile!.data![0].picture),
                      ConditionalBuilder(
                          condition: email !=
                              ProjectCubit.get(context).profile!.data![0].email,
                          fallback: (context) => Center(child: Container()),
                          builder: (context) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 35,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: secondColor,
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 110,
                                            child: Text(
                                              '${profileCubit.profile!.data![0].phone}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: switchColors),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.phone,
                                            color: switchColors,
                                          )
                                        ]),
                                  ),
                                  SizedBox(
                                    width: 105,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        ProjectCubit.get(context)
                                            .changeFollowState();
                                        if (ProjectCubit.get(context)
                                                .followingState ==
                                            true) {
                                          ProjectCubit.get(context)
                                              .addFollowing(
                                                  fllowingId:
                                                      ProjectCubit.get(context)
                                                          .profile
                                                          ?.data![0]
                                                          .id);
                                        } else {
                                          ProjectCubit.get(context)
                                              .deleteFollowing(
                                                  fllowingId:
                                                      ProjectCubit.get(context)
                                                          .profile
                                                          ?.data![0]
                                                          .id);
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: ProjectCubit.get(context)
                                                        .followingState ==
                                                    true
                                                ? Colors.black54
                                                : switchColors,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            ProjectCubit.get(context)
                                                        .followingState ==
                                                    true
                                                ? 'following'
                                                : 'follow +',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ))
                                ],
                              )),
                      ConditionalBuilder(
                          condition: email !=
                              ProjectCubit.get(context).profile!.data![0].email,
                          fallback: (context) => Center(child: Container()),
                          builder: (context) => SizedBox(
                                height: 20,
                              )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          height: 1,
                          color: Colors.black38,
                        ),
                      ),
                      ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 20),
                            child: categoryItem(
                                price: ProjectCubit.get(context)
                                    .profile
                                    ?.data![0]
                                    .products![index]
                                    .price,
                                body: ProjectCubit.get(context)
                                    .profile
                                    ?.data![0]
                                    .products![index]
                                    .body,
                                image: ProjectCubit.get(context)
                                    .profile
                                    ?.data![0]
                                    .products![index]
                                    .images![0]
                                    .url,
                                title: ProjectCubit.get(context)
                                    .profile
                                    ?.data![0]
                                    .products![index]
                                    .title,
                                saved: savedd[index],
                                changeSaved: () {
                                  savedd[index] = ProjectCubit.get(context)
                                      .changeSavedState(savedd[index]);
                                },
                                context: context)),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 0,
                        ),
                        itemCount: ProjectCubit.get(context)
                            .profile!
                            .data![0]
                            .products!
                            .length,
                        shrinkWrap: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
