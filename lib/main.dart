import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/layout/social_app/social_layout.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/themes.dart';
import 'modules/social_app/social_login/social_login_screen.dart';
import 'shared/components/bloc _observer.dart';
import 'shared/components/constants.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('On Background messaging');
  showToast(text: 'On Background Messaging', toastStates: ToastStates.SUCCESS);
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'On Message', toastStates: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'Message On Opening Application', toastStates: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData( key: 'isDark');
  bool ? onBoarding = CacheHelper.getData(key: 'onBoarding');
  late Widget startWidget;
  token = CacheHelper.getData(key: 'token');
  print(token);
  // if(onBoarding != null){
  //   if(token != null){
  //     startWidget = ShopLayout();
  //   }else{
  //     startWidget = ShopLoginScreen();
  //   }
  // }else{
  //   startWidget = OnBoardingScreen();
  // }

  uId = CacheHelper.getData(key: 'uId');

  if(uId != null){
    startWidget = SocialLayout();
  }else{
    startWidget = SocialLoginScreen();
  }

  print(onBoarding);
  runApp(MyApp(
    isDark: isDark,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget{

  final bool ? isDark;
  // bool onBoarding = false;
  late Widget startWidget;
  MyApp({
    required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => NewsAppCubit()..changeThemeMode(fromShared: isDark),
        // ),
        // BlocProvider(
        //   create: (context) => ShopCubit()..getHomeData()..getCategoryData()..getFavorites()..getUserData(),
        // ),
        BlocProvider(
            create: (context) => SocialLayoutCubit()..getUserDate()..getPosts(),
        ),
      ],
      // child: BlocConsumer <NewsAppCubit , NewsAppStates>(
      child: BlocConsumer <SocialLayoutCubit , SocialLayoutStates>(
      listener: (context, state) {
        },
        builder: (context , state) {
          // NewsAppCubit cubit = NewsAppCubit.get(context);
          SocialLayoutCubit cubit = SocialLayoutCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            // themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }

}