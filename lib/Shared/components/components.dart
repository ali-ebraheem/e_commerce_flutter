import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Shared/network/cacheHelper.dart';
import 'package:project_collage/models/FollowingModel.dart';
import 'package:project_collage/modules/Followers/Followers.dart';
import 'package:project_collage/modules/Following/Following.dart';

const Color switchColors = Color(0xFF2AA3FF);
const Color mainColor = Color(0xFF74C3FF);
const Color savedColor = Color(0xFFFF4E4E);
const Color textColor = Color(0xFF4D4D4D);
const Color secondColor = Color(0xFFECECEC);
const String login = 'login';
const String register = 'register';
const String storeProduct = 'store_product';
const String userProducts = 'user_products';
const String profile = 'profile';
const String get_Following = 'getFollowing';
const String get_Followers = 'getFollowers';
const String deletefollowing = 'deletefollowing';
const String addfollowing = 'addfollowing';
const String categoryProducts = 'Products/category/';
const String allCategories = 'allCategories';
const String storeComment = 'store_comment';
const String ProductComments = 'Product_comments';
const String deleteComment = 'delete_comment';
const String conversations = 'Conversations';
const String conversationsStore = 'Conversations/store';
const String storeFavoriteItem = 'store_favorite_item';
const String favoritesProducts = 'favorites_Products';
const String deleteFavoriteItem = 'delete_favorite_item';
const String messages = 'messages';
const String changePasssword = 'change_password';
String token = CacheHelper.getData(key: 'token');
String email = CacheHelper.getData(key: 'email');
String name = CacheHelper.getData(key: 'name');
int myId = CacheHelper.getData(key: 'id');
Widget shortCutItem({
  @required String? name,
  @required IconData? icon,
}) =>
    Stack(children: [
      Container(
        height: 35,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: secondColor,
        ),
        child: Center(
          child: Text(
            "      $name",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Icon(icon)),
    ]);

Widget productHome(
        {@required String? image,
        @required String? name,
        @required String? price,
        @required context}) =>
    Container(
      height: 190,
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 120,
            width: 140,
            decoration: BoxDecoration(
              color: secondColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage('$image'),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              '$name',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                '$price\$',
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );

Widget messageItem(
        {required context,
        @required image,
        @required name,
        @required date,
        @required lastMessage}) =>
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(image),
                backgroundColor: switchColors,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        lastMessage == 'messageConversationModel1!.body'
                            ? 'there is not any message'
                            : lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    date,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ));
Widget categoriesItem({@required name, @required image}) => Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: secondColor),
          width: 180,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              '$name',
              style: TextStyle(
                  color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: 180,
          height: 130,
          child: Image(image: AssetImage(image)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: secondColor),
        ),
      ],
    );
Widget categoryItem({
  @required Function? deleteFavorite,
  @required Function? addFavorite,
  @required bool? saved,
  @required Function? changeSaved,
  @required context,
  @required String? image,
  @required title,
  @required body,
  @required price,
}) =>
    Container(
        height: 120,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 120,
              clipBehavior: Clip.antiAlias,
              child: Image(
                image: NetworkImage('$image'),
                fit: BoxFit.fill,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: secondColor),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
                width: 160,
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$price\$',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Spacer(),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  splashRadius: 1,
                  alignment: Alignment.topRight,
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black87,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 1),
                ),
                SizedBox(
                  height: 20,
                ),
                IconButton(
                  splashRadius: 1,
                  alignment: Alignment.bottomRight,
                  onPressed: () {
                    changeSaved!();
                    if (saved == false) {
                      addFavorite!();
                    } else {
                      deleteFavorite!();
                    }
                  },
                  icon: Icon(
                    saved! ? Icons.favorite : Icons.favorite_outline,
                    color: saved ? savedColor : switchColors,
                    size: 20,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                ),
              ],
            ))
          ],
        ));
Widget sellerItem(
        bool? followingState,
        Function following,
        context,
        String? image,
        String? name,
        Function postFollowing,
        Function deleteFollowing,
        String? profileEmail) =>
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage('$image'),
                backgroundColor: switchColors,
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                          condition: email != profileEmail,
                          fallback: (context) => Center(child: Container()),
                          builder: (context) => InkWell(
                              onTap: () {
                                print(email + profileEmail!);

                                if (followingState == false) {
                                  postFollowing();
                                } else {
                                  deleteFollowing();
                                }
                                following();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: followingState == true
                                        ? Colors.black54
                                        : switchColors,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    followingState == true
                                        ? 'following'
                                        : 'follow +',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                              )))
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 5, top: 20),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 35,
                  color: switchColors,
                ),
              ),
            ],
          ),
        ));
Widget commentItem({
  @required image,
  @required name,
  @required date,
  @required body,
}) =>
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(image),
                  backgroundColor: switchColors,
                ),
                SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    width: 260,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          body,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              date,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
Widget profileItem({
  @required Function? cache,
  @required image,
  @required name,
  @required Function? getFollowers,
  @required Function? getFollowing,
  @required int? numFollowers,
  @required int? numFollowing,
  @required context,
  @required List<Data>? folloings,
  @required List<Data>? followers,
}) =>
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('$image'),
                  backgroundColor: switchColors,
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '$name',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                                onPressed: () {
                                  cache!();
                                  List<dynamic> followingId = [];
                                  for (var i = 0; i < folloings!.length; i++) {
                                    followingId.add(folloings[i].id);
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FollowersScreen(
                                            followingId: followingId,
                                            followers: followers,
                                          )));
                                  getFollowers!();
                                },
                                child: Column(children: [
                                  Text(
                                    numFollowers == null
                                        ? '0'
                                        : '$numFollowers',
                                    style: TextStyle(color: textColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Followers',
                                    style: TextStyle(color: textColor),
                                  )
                                ])),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: textColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  cache!();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FollowingScreen()));
                                  getFollowing!();
                                },
                                child: Column(children: [
                                  Text(
                                    numFollowing == null
                                        ? '0'
                                        : '$numFollowing',
                                    style: TextStyle(color: textColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(color: textColor),
                                  )
                                ]))
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                    splashRadius: 0.1,
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(top: 8),
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                      color: switchColors,
                    ))
              ],
            ),
          ),
        ));
Widget followingItem(bool followState, Function changeFollowState, context,
        Data? followingModel) =>
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${followingModel!.picture}'),
                radius: 30,
                backgroundColor: switchColors,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${followingModel.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: InkWell(
                      onTap: () {
                        print(followState);
                        changeFollowState();
                        if (!followState) {
                          ProjectCubit.get(context)
                              .addFollowing(fllowingId: followingModel.id);
                        } else {
                          ProjectCubit.get(context)
                              .deleteFollowing(fllowingId: followingModel.id);
                        }
                        print(followState);
                      },
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: followState ? Colors.black54 : switchColors,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 6),
                          child: Text(
                            followState ? 'Following' : 'Follow +',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      )))
            ],
          ),
        ));
Widget followersItem(bool followState, Function changeFollowState, context,
        Data? followingModel, List<dynamic> followingId) =>
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${followingModel!.picture}'),
                radius: 30,
                backgroundColor: switchColors,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${followingModel.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: InkWell(
                      onTap: () {
                        print(followState);
                        changeFollowState();
                        if (!followState) {
                          ProjectCubit.get(context)
                              .addFollowing(fllowingId: followingModel.id);
                        } else {
                          ProjectCubit.get(context)
                              .deleteFollowing(fllowingId: followingModel.id);
                        }
                        print(followState);
                      },
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: followState ? Colors.black54 : switchColors,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 6),
                          child: Text(
                            followState ? 'Following' : 'Follow +',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      )))
            ],
          ),
        ));
Widget notificationItem() => InkWell(
    onTap: () {},
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                child: Image(
                  image: AssetImage('assets/images/Profile Image.png'),
                ),
                backgroundColor: switchColors,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ali ebraheem',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'sent you a message: hello ali',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    '8:40 pm',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        )));
Widget imageItem({@required image, Function? removeItem}) =>
    Stack(alignment: AlignmentDirectional.topEnd, children: [
      Container(
        width: 95,
        height: 90,
        child: Container(
          width: 60,
          clipBehavior: Clip.antiAlias,
          height: 50,
          decoration: BoxDecoration(
            color: secondColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image(
            fit: BoxFit.fill,
            image: FileImage(image),
          ),
        ),
      ),
      CircleAvatar(
        radius: 12,
        backgroundColor: Colors.black38,
        child: IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            removeItem!();
          },
          icon: Center(
            child: Icon(
              Icons.close,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      )
    ]);
int findIndexWhere(List<String> people, String personName) {
  // Find the index of person. If not found, index = -1
  final index = people.indexWhere((element) => element == personName);
  return index;
}

class GlowingActionButton extends StatelessWidget {
  const GlowingActionButton({
    Key? key,
    required this.color,
    required this.icon,
    this.size = 45,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: Color.fromARGB(255, 32, 100, 156),
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(
                icon,
                size: 26,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
