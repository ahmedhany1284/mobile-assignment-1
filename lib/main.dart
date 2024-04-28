import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assignment_1/core/routes/app_router.dart';
import 'package:mobile_assignment_1/core/utils/cacheHelper.dart';
import 'package:mobile_assignment_1/core/utils/constatns.dart';
import 'package:mobile_assignment_1/features/home/cubit/home_cubit.dart';
import 'package:mobile_assignment_1/features/login/cubit/cubit.dart';
import 'package:mobile_assignment_1/features/register/cubit/cubit.dart';
import 'package:mobile_assignment_1/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();

AppConst.token=CacheHelper.getData(key: 'token')??'';
  print('token from main --> ${AppConst.token}');
  AppConst.userProfile=CacheHelper.getData(key: 'userProfile');
  // print('userProfile from main --> ${AppConst.userProfile!.toJson().toString()}');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => HomeCubit()..getData()),


      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          // scaffoldBackgroundColor: Colors.blueGrey,
          // textTheme:ThemeData.dark().textTheme,
        ),
      ),
    );
  }
}

