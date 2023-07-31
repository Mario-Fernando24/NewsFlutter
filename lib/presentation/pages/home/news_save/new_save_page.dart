import 'package:flutter/material.dart';
import 'package:tareas/constants/constant.dart';
import 'package:tareas/domain/models/news_model.dart';
import 'package:tareas/presentation/blocs/articless/article_bloc.dart';
import 'package:tareas/presentation/blocs/connecty/connecty_bloc.dart';
import 'package:tareas/presentation/blocs/news/news_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tareas/presentation/pages/home/news/news_detail_page.dart';

import '../../../utils/colors.dart';

class NewsSavePage extends StatefulWidget {
  const NewsSavePage({super.key});

  @override
  State<NewsSavePage> createState() => _NewsSavePageState();
}

class _NewsSavePageState extends State<NewsSavePage> {
  late ArticleBloc articleBloc;
 

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.getArticleEvent();
  }

  @override
  void dispose() {
    articleBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorblackLite,
          centerTitle: true,
          title: Text("Noticias Guardadas",style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold),
            )),
        backgroundColor: colorblackLite,
        body: BlocBuilder<ConnectyBloc, ConnectyState>(
          builder: (context, state) {
            return !state.isAllGranted
                ? SafeArea(
                    child: SingleChildScrollView(
                    child: Column(
                      children: [
                        
                        _newsList(context)
                      ],
                    ),
                  ))
                : Text("mario fernando ");
          },
        ));
  }


  Widget _newsList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 2,
        right: 2,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.77,
        child: StreamBuilder<List<Article>>(
          stream: articleBloc.newSaveController,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final pro = snapshot.data!;
              if (pro.length > 0) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: pro.length,
                    itemBuilder: (context, index) {
                      final news = pro[index];
                      return SingleChildScrollView(
                        child: Column(
                          children: [listNews(news)],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 90),
                  child: const Text(
                        "No tienes noticias guardada",
                        style: TextStyle(fontSize: 20, color: colorThree),
                      
                    
                  ),
                ));
              }
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar los noticias'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget listNews(Article news) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppConstants.detailNewDetailSavePage,
            arguments: news),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  news.urlToImage ?? 'https://via.placeholder.com/150',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  news.title ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                child: Text(
                  "Fuente" ,
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

