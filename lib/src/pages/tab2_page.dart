import 'package:flutter/material.dart';
import 'package:noticias_app/src/models/category_model.dart';
import 'package:noticias_app/src/services/news_service.dart';
import 'package:noticias_app/src/theme/tema.dart';
import 'package:noticias_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),
            if (!newsService.isLoading)
              Expanded(
                child: ListarNoticias(newsService.getArticulosCategoria),
              ),
            if (newsService.isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                )
              )
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categorias;
    
    return Container(
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){
          final cName = categories[index].name;
          return Container(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _CategoryButton(categories[index]),
                  SizedBox(height: 5,),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                ],
              ),
            )
          );
        }
      )
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;
  const _CategoryButton(this.category);
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        final newService = Provider.of<NewsService>(context, listen: false);
        newService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name)
              ? miTema.accentColor
              : Colors.black54,
        ),
      )
    );
  }
}

