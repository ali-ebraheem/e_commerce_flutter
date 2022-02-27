import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:project_collage/Shared/network/cacheHelper.dart';
import 'package:project_collage/Shared/network/dio_helper.dart';
import 'package:project_collage/models/CategoryProductModel.dart';
import 'package:project_collage/models/CommentModel.dart';
import 'package:project_collage/models/FollowingModel.dart';
import 'package:project_collage/models/loginModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:project_collage/models/UserProductModel.dart';
import 'package:project_collage/models/profileForSpecificUser.dart';

class ProjectCubit extends Cubit<ProjectStates> {
  ProjectCubit() : super(ProjectInitialStates());
  static ProjectCubit get(context) => BlocProvider.of(context);

  bool changeSavedState(savedState) {
    savedState = !savedState;
    emit(SavedState());
    return savedState;
  }

  bool changeFollowState() {
    followingState = !followingState;
    emit(FollowState());
    return followingState;
  }

  bool changeFollowingState(bool followState) {
    followState = !followState;
    emit(FollowState());
    return followState;
  }

  late LoginModel userData;
  void getUserInformation({@required token}) {
    DioHelper.getData(url: 'user', token: token).then((value) {
      userData = LoginModel.fromMap(value.data);
    });
  }

  double changeIndex({@required indeex}) {
    int index = indeex;
    print(indeex);
    emit(ChangeIndexIndicator());
    return index.toDouble();
  }

  List<String> folloddState = [
    'iusher',
    'iuerogio',
  ];

  void postProduct(
      {@required image,
      @required title,
      @required body,
      @required categoryId,
      @required brand,
      @required condition,
      @required price}) {
    DioHelper.postData(
            url: storeProduct,
            data: {
              'image': image,
              'title': title,
              'body': body,
              'category_id': categoryId,
              'product_city': 'baghdad',
              'brand': brand,
              'condition': condition,
              'price': price
            },
            token: token)
        .then((value) {
      imagesDashboard.clear();
      getProductForUser();
      emit(PostProductSuccussState());
      print(value.data);
    }).catchError((error) {
      emit(PostProductErrorState());
      print(error.toString());
    });
  }

  String categoryDropdownvalue = 'Category :';
  dynamic changeCategoryDropdownvalue({@required dropdownvaluee}) {
    this.categoryDropdownvalue = dropdownvaluee;
    emit(Changedropdownvalue());
    return dropdownvaluee;
  }

  String conditionDropdownvalue = 'Condition :';
  dynamic changeConditionDropdownvalue({@required dropdownvalue}) {
    this.conditionDropdownvalue = dropdownvalue;
    emit(Changedropdownvalue());
    return dropdownvalue;
  }

  final ImagePicker picker = ImagePicker();

  XFile? imageFile;
  File? file;
  List imagesDashboard = [];
  List<String> images = [];
  void pickImage() {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      imageFile = value;
      file = File(imageFile!.path);
      print(file);
      imagesDashboard.add(file);
      uploadProfileImage();
      emit(PickImageState());
    });
  }

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageFile!.path).pathSegments.last}')
        .putFile(File(imageFile!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        images.add(value);
        print(value);
        emit(UploadImageSuccusState());
      }).catchError((error) {
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  void removeImage({@required index}) {
    imagesDashboard.removeAt(index);
    emit(RemoveImage());
  }

  ProductModel? productModel;
  void getProductForUser() {
    emit(GetProductLoadingState());
    DioHelper.getData(url: userProducts, token: token).then((value) {
      productModel = ProductModel.fromJson(value.data);
      print(productModel?.data![0].authorId);
      emit(GetProductSuccussState());
    }).catchError((error) {
      emit(GetProductErrorState());
      print(error.toString());
    });
  }

  bool followingState = false;
  Profile? profile;
  void getProfileUser({@required id}) {
    emit(GetProfileLoadingState());
    DioHelper.getData(url: 'profile', token: token, data: {'id': '$id'})
        .then((value) {
      profile = Profile.fromJson(value.data);
      print(profile?.data![0].name);
      print(profile?.data![0].isFollowing);
      CacheHelper.putData(
          key: 'isFollowing', value: profile?.data![0].isFollowing);
      followingState = CacheHelper.getData(key: 'isFollowing');
      getFollowing(userId: profile?.data![0].id);
      emit(GetFollowingLoadingState());
    }).catchError((error) {
      emit(GetProfileErrorState());
      print(error.toString());
    });
  }

  CategoryProductModel? categoryProductModel;
  void getCategoryProduct({@required indexCategory}) {
    emit(GetProductLoadingState());
    DioHelper.getData(url: categoryProducts + '$indexCategory').then((value) {
      categoryProductModel = CategoryProductModel.fromJson(value.data);
      print(categoryProductModel?.data![0]);
      emit(GetProductSuccussState());
    }).catchError((error) {
      emit(GetProductErrorState());
      print(error.toString());
    });
  }

  dynamic allCtaegories;
  void getCategories() {
    emit(GetCategoriesLoadingState());
    DioHelper.getData(url: allCategories).then((value) {
      allCtaegories = value.data;
      print(value.data);
      emit(GetCategoriesSuccussState());
    }).catchError((error) {
      emit(GetCategoriesErrorState());
      print(error.toString());
    });
  }

  void addFollowing({@required fllowingId}) {
    emit(PostFollowingLoadingState());
    DioHelper.postData(
            url: addfollowing, data: {'following_id': fllowingId}, token: token)
        .then((value) => emit(PostFollowingSuccussState()))
        .catchError((error) {
      print(error.toString());
      emit(PostFllowingErrorState());
    });
  }

  void deleteFollowing({@required fllowingId}) {
    emit(DeleteFollowingLoadingState());
    DioHelper.postData(
            url: deletefollowing,
            data: {'following_id': fllowingId},
            token: token)
        .then((value) => emit(DeleteFollowingSuccussState()))
        .catchError((error) {
      print(error.toString());
      emit(DeleteFllowingErrorState());
    });
  }

  FollowingModel? followingModel;
  void getFollowing({@required userId}) {
    emit(GetFollowingLoadingState());
    DioHelper.getData(
            url: get_Following, data: {'user_id': userId}, token: token)
        .then((value) {
      followingModel = FollowingModel.fromJson(value.data);
      print(followingModel);
      getFollowers(userId: profile?.data![0].id);
      emit(GetFollowersLoadingState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFollowingErrorState());
    });
  }

  FollowingModel? followersModel;
  void getFollowers({@required userId}) {
    emit(GetFollowersLoadingState());
    DioHelper.getData(
            url: get_Followers, data: {'user_id': userId}, token: token)
        .then((value) {
      followersModel = FollowingModel.fromJson(value.data);
      print(followersModel);
      emit(GetFollowersSuccussState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFollowersErrorState());
    });
  }

  void postComment({@required productID, @required body}) {
    emit(PostCommentLoadingState());
    DioHelper.postData(
        url: storeComment,
        token: token,
        data: {'product_id': productID, 'body': body}).then((value) {
      print(value.toString());
      getComment(productId: productID);
      emit(PostCommentSuccussState());
    }).catchError((error) {
      emit(PostCommentErrorState());
      print(error.toString());
    });
  }

  CommentModel? commentModel;
  void getComment({@required productId}) {
    emit(GetCommentLoadingState());
    DioHelper.getData(url: ProductComments, token: token, data: {
      'product_id': productId,
    }).then((value) {
      commentModel = CommentModel.fromJson(value.data);
      print(value.data);
      emit(GetCommentSuccussState());
    }).catchError((error) {
      emit(GetCommentErrorState());
      print(error.toString());
    });
  }

  void deleteComments({@required commentId}) {
    emit(DeleteCommentLoadingState());
    DioHelper.deleteData(url: deleteComment, token: token, data: {
      'comment_id': commentId,
    }).then((value) {
      print(value.toString());
      emit(DeleteCommentSuccussState());
    }).catchError((error) {
      emit(DeleteCommentErrorState());
      print(error.toString());
    });
  }
}
