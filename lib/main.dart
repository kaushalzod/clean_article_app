import 'package:article_app/core/di/get_it.dart';
import 'package:article_app/features/articles/presentation/pages/home_screen.dart';
import 'package:article_app/features/articles/presentation/provider/articles_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(
    ChangeNotifierProvider(
      child: MaterialApp(home: HomeScreen()),
      create: (context) => getIt<ArticlesProvider>()..getArticles(),
    ),
  );
}
