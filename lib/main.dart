import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_parse/search/bloc/search_bloc.dart';
import 'package:hh_parse/search/start_screen.dart';

void main() async {
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SearchBloc(),
          ),
        ],
        child: const MyApp(),

      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
    );
  }
}