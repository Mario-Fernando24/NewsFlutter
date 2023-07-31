import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tareas/domain/models/news_model.dart';
import 'package:tareas/presentation/utils/colors.dart';
import 'package:tareas/presentation/widgets/validate.dart';

import '../../../blocs/articless/article_bloc.dart';

class DetailNewSaveDetailPage extends StatefulWidget {
  final Article? articleModel;

  DetailNewSaveDetailPage({required this.articleModel});

  @override
  State<DetailNewSaveDetailPage> createState() => _DetailCharactersPageState();
}

class _DetailCharactersPageState extends State<DetailNewSaveDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.articleModel!.author ?? ""),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _image(context),
              _textName(),
              _textDescription(),
              _textAuthor()
            ],
          ),
        ));
  }

  Widget _image(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Container(
            child: Image.network(
          widget.articleModel!.urlToImage ?? 'https://via.placeholder.com/150',
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.50,
          fit: BoxFit.cover,
        ))
      ],
    ));
  }

  Widget _textName() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Text(
        widget.articleModel!.title ?? "",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Text(
        widget.articleModel!.description ?? "",
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }


  Widget _textAuthor() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 90, left: 30, right: 30),
        child: Column(children: [
         
          Row(
            children: [
              const Text(
                "Autor:  ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: colorPrimary),
              ),
              Text(widget.articleModel!.author.toString() ?? ""),
            ],
          ),
          const SizedBox(height: 10),
        ]));
  }


 
}
