import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tareas/presentation/blocs/articless/article_bloc.dart';

class NewsSavePage extends StatefulWidget {
  const NewsSavePage({super.key});

  @override
  State<NewsSavePage> createState() => _NewsSavePageState();
}

class _NewsSavePageState extends State<NewsSavePage> {
  late ArticleBloc articleBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      articleBloc = BlocProvider.of<ArticleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsSavePage"),
      ),
    );
  }
}
