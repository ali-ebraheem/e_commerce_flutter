import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:project_collage/modules/Categories/Categories.dart';
import 'package:project_collage/modules/Dashboard/Dashboard.dart';
import 'package:project_collage/modules/Messages/Messages.dart';
import 'package:project_collage/modules/NavigationDrawer/navegationDrawer.dart';
import 'package:project_collage/modules/Notification/Notification.dart';
import 'package:project_collage/modules/Saved/Saved.dart';
import 'package:project_collage/modules/Selling/Selling.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
              drawer: NavegationDrawer(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: switchColors,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                child: Icon(
                  Icons.add_business_rounded,
                  size: 30,
                ),
              ),
              appBar: AppBar(
                leading: Builder(
                  builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: CircleAvatar(
                      radius: 20,
                      backgroundColor: secondColor,
                      child: Icon(
                        Icons.menu_rounded,
                        color: switchColors,
                        size: 26,
                      ),
                    ),
                  ),
                ),
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: switchColors,
                  ),
                  height: 25,
                  width: 100,
                ),
                elevation: 0,
                actions: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: secondColor,
                        child: IconButton(
                          onPressed: () {
                            ProjectCubit.get(context).getAllConversation();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessagesScreen()),
                            );
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/Chat bubble Icon.svg",
                            height: 22,
                            width: 22,
                            color: switchColors,
                          ),
                        ),
                      )),
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
                  condition: state is GetProductLoadingState ||
                      state is GetCategoriesLoadingState ||
                      state is GetCategoriesErrorState,
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
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
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
                            //Shortcuts
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ProjectCubit.get(context)
                                            .getProductForUser();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SellingScreen()),
                                        );
                                      },
                                      child: shortCutItem(
                                          name: 'selling',
                                          icon: Icons.business),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CtaegoriesScreen()),
                                        );
                                      },
                                      child: shortCutItem(
                                          name: 'categories',
                                          icon: Icons.category_outlined),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ProjectCubit.get(context).getFavorite();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SavedScreen()),
                                        );
                                      },
                                      child: shortCutItem(
                                          name: 'saved',
                                          icon: Icons.favorite_outline),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                                physics: BouncingScrollPhysics()),
                            SizedBox(
                              height: 10,
                            ),
                            //Products
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 20, bottom: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Recommended',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 35,
                                      color: switchColors,
                                    ),
                                  ],
                                )),
                            Container(
                              height: 190,
                              child: Column(children: [
                                Expanded(
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      width: 0,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    primary: false,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: productHome(
                                          image: "assets/images/tshirt.png",
                                          name: 'tshirt meduim',
                                          price: '100',
                                          context: context),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'glaps',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 35,
                                      color: switchColors,
                                    ),
                                  ],
                                )),
                            Container(
                              height: 190,
                              child: Column(children: [
                                Expanded(
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Container(),
                                    scrollDirection: Axis.horizontal,
                                    primary: false,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: productHome(
                                          image: "assets/images/glap.png",
                                          name: 'glap',
                                          price: '100',
                                          context: context),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'tshirt',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 35,
                                      color: switchColors,
                                    ),
                                  ],
                                )),
                            Container(
                              height: 190,
                              child: Column(children: [
                                Expanded(
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Container(),
                                    scrollDirection: Axis.horizontal,
                                    primary: false,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: productHome(
                                          image:
                                              "assets/images/product 1 image.png",
                                          name: 'tshirt',
                                          price: '100',
                                          context: context),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Fashion',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 35,
                                      color: switchColors,
                                    ),
                                  ],
                                )),
                            Container(
                              height: 190,
                              child: Column(children: [
                                Expanded(
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Container(),
                                    scrollDirection: Axis.horizontal,
                                    primary: false,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: productHome(
                                          image: "assets/images/shoes2.png",
                                          name: 'shoes',
                                          price: '100',
                                          context: context),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'electronic',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 35,
                                      color: switchColors,
                                    ),
                                  ],
                                )),
                            Container(
                              height: 190,
                              child: Column(children: [
                                Expanded(
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Container(),
                                    scrollDirection: Axis.horizontal,
                                    primary: false,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: productHome(
                                          image:
                                              "assets/images/ps4_console_white_1.png",
                                          name: 'ps4_console',
                                          price: '100',
                                          context: context),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      )),
            ));
  }
}
