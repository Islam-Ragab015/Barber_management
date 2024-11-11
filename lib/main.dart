import 'package:barber/features/add_service/controller/get_service_cubit/get_service_cubit.dart';
import 'package:barber/features/auth/view/User_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/cashe_helper.dart';
import 'features/add_service/controller/add_service_cubit/add_service_cubit.dart';
import 'features/add_service/firebase_sevice_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddServiceCubit(
            firebaseSeviceHelper: FirebaseSeviceHelper(),
          ),
        ),
        BlocProvider(
          create: (context) => GetServiceCubit(
            firebaseSeviceHelper: FirebaseSeviceHelper(),
          )..getAllData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const BarberDashboard(),
        home: const UserTypeScreen(),
      ),
    );
  }
}
