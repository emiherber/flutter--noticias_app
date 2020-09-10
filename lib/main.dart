import 'package:flutter/material.dart';
import 'package:noticias_app/src/pages/tabs_page.dart';
import 'package:noticias_app/src/services/news_service.dart';
import 'package:noticias_app/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService())
      ],
      child: MaterialApp(
        title: 'Material APP',
        theme: miTema,
        home: TabsPage(),
      )
    );
  }
}
