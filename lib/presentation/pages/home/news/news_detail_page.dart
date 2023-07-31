import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tareas/domain/models/news_model.dart';
import 'package:tareas/presentation/utils/colors.dart';
import 'package:tareas/presentation/widgets/validate.dart';

import '../../../blocs/articless/article_bloc.dart';

class DetailNewsDetailPage extends StatefulWidget {
  final Article? articleModel;

  DetailNewsDetailPage({required this.articleModel});

  @override
  State<DetailNewsDetailPage> createState() => _DetailCharactersPageState();
}

class _DetailCharactersPageState extends State<DetailNewsDetailPage> {
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
              _textOptions(),
              _button()
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

  Widget _textOptions() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Column(children: [
          Row(
            children: [
              const Text(
                "Publicado:  ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: colorPrimary),
              ),
              Text(widget.articleModel!.publishedAt.toString() ?? ""),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Text(
                "Fuente:  ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: colorPrimary),
              ),
              Text(widget.articleModel!.source!.name.toString() ?? ""),
            ],
          ),
          const SizedBox(height: 5),
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

  Widget _button() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.05,
        child: ElevatedButton(
          onPressed: () {
            setState(()async {
              articleBloc.add(AddArticleEvent(
                  widget.articleModel!.author.toString(),
                  widget.articleModel!.title ?? "no",
                  widget.articleModel!.description ?? "no",
                  widget.articleModel!.url.toString() ?? "no",
                  widget.articleModel!.urlToImage.toString() ?? ""));
                  showModalAddArticleSQL(context, "Satisfactorio", "Se guardo la noticia correctamente");
              articleBloc.add(GetArticleEvent());
            });
          },
          style: ElevatedButton.styleFrom(
            primary: colorPrimary,
            onPrimary: colorThree,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text('Guardar noticias', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
