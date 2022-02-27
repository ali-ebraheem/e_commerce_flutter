import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:project_collage/Shared/network/cacheHelper.dart';
import 'package:project_collage/Shared/network/dio_helper.dart';
import 'package:project_collage/models/loginModel.dart';
import 'package:project_collage/modules/Login/cubit/LoginStates.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool validationP = false;
  bool validationE = false;
  void loginUser({@required email, @required passowrd}) {
    emit(LoginLoadingStates());
    DioHelper.getData(url: login, data: {
      'email': email,
      'password': passowrd,
    }).then((value) {
      if (value.data['email'] == null && value.data['password'] == null) {
        validationP = false;
        validationE = false;
        emit(ValidStates());
        LoginModel userData = LoginModel.fromMap(value.data);
        CacheHelper.putData(key: 'token', value: userData.token);
        CacheHelper.putData(key: 'email', value: userData.user.email);
        CacheHelper.putData(key: 'name', value: userData.user.name);
        CacheHelper.putData(key: 'id', value: userData.user.id);
        CacheHelper.putData(key: 'RegisterSuccess', value: true);
        print(userData.token);
      } else {
        if (value.data['email'] == null) {
          validationP = true;
        } else if (value.data['password'] == null) {
          validationE = true;
        } else if (value.data['email'] != null &&
            value.data['password'] != null) {
          validationE = true;
          validationP = true;
        }
        emit(InvalidStates());
      }
      emit(LoginSuccessfulStates());
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorStates());
    });
  }

  bool obsecurechange({@required obsecure}) {
    obsecure = !obsecure;
    emit(IspassowrdStates());
    return obsecure;
  }
}
