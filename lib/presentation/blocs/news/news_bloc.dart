import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tareas/data/news_repository_impl.dart';
import 'package:tareas/domain/models/news_model.dart';
import 'package:tareas/domain/repositories/news_repositoies.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepository newsRepository = NewsRepositoryImpl();

  final StreamController<List<Article>> _newsController =
      StreamController<List<Article>>.broadcast();

  Stream<List<Article>> get newsController => _newsController.stream;

  NewsBloc() : super(NewsInitial()) {
    on<FilterNewCountryEvent>(_handleFilterNewCountry);
  }

  void _handleFilterNewCountry(FilterNewCountryEvent event, emit) async {
    try {
      final news = await newsRepository.getNewsFilterCountry(event.filterNewCountry);
      _newsController.add(news);
    } catch (error) {
      print(error.toString());
    }
  }

  void getListNews() async {
    try {
      final news = await newsRepository.getNews();
      print("mariooooooooooooooo");

      _newsController.add(news);
    } catch (error) {
      print(error.toString());
    }
  }


  void dispose() {
    _newsController.close();
  }
}
