import 'package:flutter/material.dart';
import '../data/api_model.dart';

class ArticleDetailPage extends StatelessWidget {
  Articles article;

  ArticleDetailPage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text("Article App"),
      ),
      body: Column(
        children: [
          Container(
            child: Hero(
              tag: article.urlToImage,
              child: Image.network(article.urlToImage),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    article.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.all(5.0),
                  child: Text(
                    article.publishedAt,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    article.content,
                    style: TextStyle(
                      color: Colors.white,
                      //fontWeight: FontWeight,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
