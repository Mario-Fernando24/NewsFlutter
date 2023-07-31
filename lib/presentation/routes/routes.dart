import 'package:flutter/material.dart';
import 'package:tareas/constants/constant.dart';
import 'package:tareas/domain/models/news_model.dart';
import 'package:tareas/presentation/pages/home/news/news_detail_page.dart';
import 'package:tareas/presentation/pages/home/news/news_page.dart';
import 'package:tareas/presentation/pages/home/news_save/new_save_page.dart';
import 'package:tareas/presentation/pages/home_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  AppConstants.homePage: (_) => const HomePageNews(),
  AppConstants.newsPage: (_) => const NewsPage(),
  AppConstants.newsSavePage: (_) => const NewsSavePage(),

  //Detail news
  AppConstants.detailNewPage: (context) {
    final Article articleModel =
        ModalRoute.of(context)!.settings.arguments as Article;
    return DetailNewsDetailPage(articleModel: articleModel);
  },
  
};
