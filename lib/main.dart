import 'package:community/bussines_logic/app_cubit.dart';
import 'package:community/bussines_logic/data_cubit.dart';
import 'package:community/core/screens.dart';
import 'package:community/presentation/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:sizer/sizer.dart';

import 'core/my_bloc_observer.dart';
import 'data/local/my_cache.dart';
import 'data/remote/data_providers/my_dio.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('onBack');
/*  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          body: message.notification?.body,
          title: message.notification?.title,
          backgroundColor: Colors.red,
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          displayOnBackground: true,
          displayOnForeground: true));*/
  print(message.notification?.title);
}

void main() async {
  /* await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'channelName',
        channelDescription: 'channelDescription',
        channelShowBadge: true,
        importance: NotificationImportance.Max,
        locked: true,

      )
    ],
    debug: true,
  );*/

  await MyDio.dioInit();
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterNotificationChannel.registerNotificationChannel(
    description: 'channel description',
    id: 'id',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'channel name',
    visibility: NotificationVisibility.VISIBILITY_PUBLIC,
    allowBubbles: true,
    enableVibration: true,
    enableSound: true,
    showBadge: true,
  );
  final firbaseMessaging = FirebaseMessaging.instance;
  await firbaseMessaging.requestPermission();
  final token = await firbaseMessaging.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    // print('in it');
    //print(event.notification?.body);
    // print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('oppened');
    print(event.notification?.title.toString());
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  await MyCache.initCache();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouter appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
          BlocProvider(create: (context) => DataCubit()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
          debugShowCheckedModeBanner: false,
        ),
      );
    });
  }
}
