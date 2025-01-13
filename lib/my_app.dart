import 'package:etranzazct_test/app/routes/app_routes.dart';
import 'package:etranzazct_test/app/routes/routes.dart';
import 'package:etranzazct_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:etranzazct_test/features/auth/presentation/bloc/auth_events.dart';
import 'package:etranzazct_test/features/home/presentation/bloc/api_image_bloc.dart';
import 'package:etranzazct_test/features/home/presentation/bloc/api_image_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ApiImageBloc()..add(LoadImageEvent())),
        BlocProvider(create: (_) => AuthBloc()..add(CheckAuthStatusEvent()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        onGenerateRoute: (settings) => Routes.onGenerateRoutes(settings),
        initialRoute: AppRoutes.login,
      ),
    );
  }
}
