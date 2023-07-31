import '../models/news_model.dart';

abstract class NewsRepository {
  Future<List<Article>> getNews();
  Future<List<Article>> getNewsFilterCountry(String country);
}
