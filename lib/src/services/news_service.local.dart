import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticias_app/src/models/category_model.dart';
import 'package:noticias_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _TOKEN = '5f810ca8c9b94cb5847ac7119dfdbf0c';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];
  List<Category> categorias = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.futbol, 'sport'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  String _selectedCategory = 'business';

  bool _isLoading = true;

  NewsService() {
    this.getTopHeadLines();
    categorias.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this._isLoading = true;
    this.getArticlesByCategory(this._selectedCategory);
    notifyListeners();
  }

  List<Article> get getArticulosCategoria => this.categoryArticles[this.selectedCategory];

  bool get isLoading => this._isLoading;

  getTopHeadLines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_TOKEN&country=ar';
    final resp = await http.get(url);
    final NewsResponse = newsResponseFromJson(resp.body);
    this.headLines.addAll(NewsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async{
    if(this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }
    final url = '$_URL_NEWS/top-headlines?apiKey=$_TOKEN&country=ar&category=$category';
    final resp = await http.get(url);
    final NewsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[category].addAll(NewsResponse.articles);
    this._isLoading = false;
    notifyListeners();
  }
}