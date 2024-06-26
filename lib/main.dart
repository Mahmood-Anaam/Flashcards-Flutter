import 'package:flutter/material.dart';
import 'models/deck.dart';
import 'utils/db_helper.dart';
import 'views/decklist.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<List<Deck>> _loadData() async {
    final data = await DBHelper().query('deck');
    return data
        .map((e) => Deck(
      id: e['id'] as int,
      createdAt: DateTime.now(),
      title: e['title'] as String,
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureProvider<List<Deck>?>(
        create: (_) => _loadData(),
        initialData: null,
        child: const DeckList(),
      ),
    );
  }
}
