import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../data/api_model.dart';

abstract class ArticleState extends Equatable {}

class ArticleInitialState extends ArticleState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ArticleLoadingState extends ArticleState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ArticleLoadedState extends ArticleState {
  List<Articles> articles;

  ArticleLoadedState({@required this.articles});

  @override
  List<Object> get props => throw UnimplementedError();
}

class ArticleErrorState extends ArticleState {
  String message;

  ArticleErrorState({@required this.message});

  @override
  List<Object> get props => throw UnimplementedError();
}
