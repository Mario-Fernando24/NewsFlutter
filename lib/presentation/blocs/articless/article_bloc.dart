import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tareas/domain/models/news_model.dart';
import '../../../domain/datasources/data_source.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  
  final TaskDataSource _dataSource = TaskDataSource();

  ArticleBloc() : super(ArticleInitial()) {
    on<AddArticleEvent>(_addArticleEvent);
    on<GetArticleEvent>(_getArticleEvent);
  }

  void _getArticleEvent(GetArticleEvent event, emit) async {
    try {
       final  article = await _dataSource.getAllTasks();
       print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
       for (var element in article) {
         print(element.author);
       }
       
       print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    } catch (error) {
      print(error.toString());
    }
  }

  void _addArticleEvent(AddArticleEvent event, emit) async {
    try {
       Article articleee = Article(
         author: event.author,
         title: event.title,
         description: event.description,
         url: event.url,
         urlToImage: event.urlToImage,
       );
       print("===========================================");
       print(articleee.title);
       print("===========================================");
       final article = _dataSource.addTask(articleee);

    } catch (error) {
      print(error.toString());
    }
  }
}
