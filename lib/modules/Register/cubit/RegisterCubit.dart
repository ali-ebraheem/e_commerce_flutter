import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:project_collage/Shared/network/cacheHelper.dart';
import 'package:project_collage/Shared/network/dio_helper.dart';
import 'package:project_collage/models/LoginModel.dart';
import 'package:project_collage/modules/Register/cubit/RegisterStates.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool obsecurechange({@required obsecure}) {
    obsecure = !obsecure;
    emit(IspassowrdStates());
    return obsecure;
  }

  bool validationE = false;
  bool validationP = false;
  void registerUser({@required email, @required passowrd, @required name}) {
    emit(RegisterLoadingStates());
    DioHelper.postData(url: register, data: {
      'name': name,
      'password': passowrd,
      'role': 'user',
      'city': 'baghdad',
      'email': email,
      'phone': '234324'
    }).then((value) {
      DioHelper.getData(url: login, data: {
        'email': email,
        'password': passowrd,
      }).then((value) {
        if (value.data['email'] == null && value.data['password'] == null) {
          validationE = false;
          validationP = false;
          LoginModel userData = LoginModel.fromMap(value.data);
          CacheHelper.putData(key: 'token', value: userData.token);
          CacheHelper.putData(key: 'email', value: userData.user.email);
          CacheHelper.putData(key: 'name', value: userData.user.name);
          CacheHelper.putData(key: 'id', value: userData.user.id);
          CacheHelper.putData(key: 'RegisterSuccess', value: true);
          print(userData.token);
          emit(ValidStates());
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

        emit(GetRegisterSuccessfulStates());
      }).catchError((error) {
        print(error.toString());
        emit(GetRegisterErrorStates());
      });
      emit(RegisterSuccessfulStates());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorStates());
    });
  }
}
