import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/article_bloc.dart';
import 'data/article_repo.dart';
import 'package:article_lab5/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Article App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BlocProvider(
        create: (BuildContext context) =>
            ArticleBloc(repository: ArticleRepositoryImpl()),
        child: HomePage(),
      ),
    );
  }
}
