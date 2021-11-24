import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/article_bloc.dart';
import '../bloc/article_state.dart';
import '../data/api_model.dart';
import '../bloc/article_event.dart';
import 'detail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleBloc articleBloc;
  int status = 0;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                title: Text("Article App"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      articleBloc.add(FetchArticleEvent());
                    },
                  ),
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_news.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BlocListener<ArticleBloc, ArticleState>(
                  listener: (context, state) {
                    if (state is ArticleErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      if (state is ArticleInitialState) {
                        return Loading();
                      } else if (state is ArticleLoadingState) {
                        return Loading();
                      } else if (state is ArticleLoadedState) {
                        return ArticleList(state.articles);
                      } else if (state is ArticleErrorState) {
                        return ErrorUi(state.message);
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToDetail(BuildContext context, Articles article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(
        article: article,
      );
    }));
  }

  Widget Loading() {
    return Center(
      child: SpinKitDoubleBounce(
        color: Colors.deepPurple,
        size: 100.0,
      ),
    );
  }

  Widget ErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget ArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Container(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Hero(
                    tag: articles[pos].urlToImage,
                    child: Image.network(
                      articles[pos].urlToImage,
                      fit: BoxFit.cover,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                title: Text(articles[pos].title,
                    style: TextStyle(
                      color: Colors.black,
                    )),
                // subtitle: Text(articles[pos].publishedAt),
              ),
              decoration: new BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onTap: () {
              navigateToDetail(context, articles[pos]);
            },
            onLongPress: () {
              setState(() {
                articles.removeAt(pos);
              });
            },
          ),
        );
        SizedBox(
          height: 5,
        );
      },
    );
  }
}
