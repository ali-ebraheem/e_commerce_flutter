import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Shared/network/cacheHelper.dart';
import 'package:project_collage/Shared/network/dio_helper.dart';
import 'package:project_collage/modules/Home/home.dart';
import 'package:project_collage/modules/Login/login.dart';
import 'Shared/bloc_observer.dart';
import 'Shared/components/components.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  var loginState = CacheHelper.getData(key: 'RegisterSuccess');
  if (loginState == null) {
    loginState = false;
  }
  print(loginState);
  await Firebase.initializeApp().then((value) {
    print('Firebase Initialized Successfully');
  }).catchError((error) {
    print('Firebase Initialized Error => ${error.toString()}');
  });
  runApp(MyApp(loginState));
}

class MyApp extends StatelessWidget {
  final bool? loginstate;
  MyApp(this.loginstate);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ProjectCubit()
          ..getProductForUser()
          ..getCategories()
          ..getSearchProduct(searchItem: 'jftyjtyjnfyjhfgjtfyj'),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              buttonTheme: ButtonThemeData(buttonColor: Colors.black),
              primaryColor: switchColors,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: Colors.white,
              )),
          home: loginstate! ? HomeScreen() : LoginScreen(),
        ));
  }
}
