import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';

class FollowingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<bool> followState = [];

    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
          for (var i = 0; i < 1000; i++) {
            followState.add(true);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Following',
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
            body: ConditionalBuilder(
                condition: state is GetFollowingLoadingState,
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
                            itemBuilder: (context, index) => followingItem(
                              followState[index],
                              () {
                                followState[index] = ProjectCubit.get(context)
                                    .changeFollowingState(followState[index]);
                              },
                              context,
                              ProjectCubit.get(context)
                                  .followingModel!
                                  .data![index],
                            ),
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Divider(
                                height: 1,
                                color: Colors.black38,
                              ),
                            ),
                            itemCount: ProjectCubit.get(context)
                                .followingModel!
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
