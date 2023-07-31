import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tareas/domain/models/news_model.dart';
import 'package:tareas/domain/repositories/news_repositoies.dart';

import '../constants/constant.dart';

class NewsRepositoryImpl implements NewsRepository {
  @override
  Future<List<Article>> getNews() async {
    try {

      final resp = await await http.get(Uri.parse(
          '${AppConstants.UrlNoticias}/top-headlines?apiKey=${AppConstants.ApiKey}&country=us'));

      final data = json.decode(resp.body);

      if (resp.statusCode == 200) {
        final List<dynamic> article = data['articles'];

        return article.map((news) => Article.fromJson(news)).toList();
      } else if (resp.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

    @override
  Future<List<Article>> getNewsFilterCountry(country) async {

    try {

      final resp = await await http.get(Uri.parse(
          '${AppConstants.UrlNoticias}/top-headlines?apiKey=${AppConstants.ApiKey}&country=${country}'));

      final data = json.decode(resp.body);

      if (resp.statusCode == 200) {
        final List<dynamic> article = data['articles'];

        return article.map((news) => Article.fromJson(news)).toList();
      } else if (resp.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
