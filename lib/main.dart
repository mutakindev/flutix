import 'package:bwa_flutix/bloc/blocs.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:bwa_flutix/ui/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(
            create: (_) => UserBloc(),
          ),
          BlocProvider(
            create: (_) => ThemeBloc(),
          ),
          BlocProvider(
            create: (_) => MovieBloc()..add(FetchMovies()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              theme: themeState.themeData,
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            );
          },
        ),
      ),
    );
  }
}
