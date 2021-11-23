import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'article_event.dart';
import 'article_state.dart';
import '../data/api_model.dart';
import '../data/article_repo.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;

  ArticleBloc({@required this.repository}) : super(null);

  @override
  ArticleState get initialState => ArticleInitialState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticleEvent) {
      yield ArticleLoadingState();
      try {
        List<Articles> articles = await repository.getArticles();
        yield ArticleLoadedState(articles: articles);
      } catch (e) {
        yield ArticleErrorState(message: e.toString());
      }
    }
  }
}
