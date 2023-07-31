import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tareas/domain/models/news_model.dart';
import 'package:tareas/presentation/widgets/validate.dart';
import '../../../domain/datasources/data_source.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState>  {
  final TaskDataSource _dataSource = TaskDataSource();
   final StreamController<List<Article>> _newSaveController =
      StreamController<List<Article>>.broadcast();

  Stream<List<Article>> get newSaveController => _newSaveController.stream;

  ArticleBloc() : super(ArticleInitial()) {
    on<AddArticleEvent>(_addArticleEvent);
  }

  void getArticleEvent() async {
    try {
      final article = await _dataSource.getAllTasks();
      _newSaveController.add(article);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _addArticleEvent(AddArticleEvent event, emit) async {
    try {
      Article articleee = Article(
        author: event.author,
        title: event.title,
        description: event.description,
        url: event.url,
        urlToImage: event.urlToImage,
      );

      final article = await _dataSource.addTask(articleee);

      if (article) {
        emit(ArticleSuccessState(data: true));
      } else {
        emit(ArticleSuccessState(data: false));
      }
    } catch (error) {
      print(error.toString());
    }
  }

   void dispose() {
    _newSaveController.close();
  }
}
