part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();
  
  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}


class ArticleLoaded extends ArticleState {
  final List<Article> article;

  ArticleLoaded(this.article);
}

class ArticleSuccessState extends ArticleState {
  final bool data;

  ArticleSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}
