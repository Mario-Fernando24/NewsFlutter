part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class AddArticleEvent extends ArticleEvent {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  AddArticleEvent(this.author,this.title, this.description, this.url, this.urlToImage);
}

class GetArticleEvent extends ArticleEvent {


  GetArticleEvent();
}