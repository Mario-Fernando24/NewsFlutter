import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tareas/presentation/blocs/articless/article_bloc.dart';
import 'package:tareas/presentation/blocs/news/news_bloc.dart';
import 'package:tareas/presentation/pages/home_page.dart';
import 'package:tareas/presentation/routes/routes.dart';

import 'constants/constant.dart';
import 'presentation/blocs/connecty/connecty_bloc.dart';

void main() async {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<NewsBloc>(create: (context) => NewsBloc()),
      BlocProvider<ConnectyBloc>(create: (context) => ConnectyBloc()),
      BlocProvider<ArticleBloc>(create: (context) => ArticleBloc())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tarea',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePageNews(),
      initialRoute: AppConstants.homePage,
      routes: appRoutes,
    );
  }
}
