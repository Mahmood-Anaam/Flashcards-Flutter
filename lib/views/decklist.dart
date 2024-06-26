// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../utils/db_helper.dart';
import 'package:provider/provider.dart';
import 'cardlist.dart';
import 'editedeck.dart';

class DeckList extends StatefulWidget {
  const DeckList({super.key});

  @override
  State<DeckList> createState() => _DeckListState();
}

class _DeckListState extends State<DeckList> {
  @override
  Widget build(BuildContext context) {
    final decks = Provider.of<List<Deck>?>(context);
    if (decks == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(95, 148, 236, 1),
          title: const Text(
            'Flashcards Decks',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  List<Deck> df = await DBHelper()
                      .initFromFileJson("assets/flashcards.json");
                  setState(() {
                    decks.addAll(df);
                  });
                },
                icon: const Icon(
                  Icons.download,
                  color: Colors.white,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return EditeDeck(
                    deck: null,
                    onSavePressed: (v) async {
                      final deck = Deck(createdAt: DateTime.now(), title: v);
                      await deck.dbSave();
                      setState(() {
                        decks.add(deck);
                      });
                    },
                    onDeletePressed: null,
                  );
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(4),
            children: List.generate(
                decks.length,
                (index) => Card(
                    color: const Color.fromRGBO(242, 228, 178, 1),
                    child: Container(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            InkWell(onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return CardList(deck: decks[index]);
                                },
                              ));
                            }),
                            Center(child: Text(decks[index].title)),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color.fromRGBO(117, 170, 232, 1),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return EditeDeck(
                                          deck: decks[index],
                                          onDeletePressed: () async {
                                            await decks[index].dbDelete();
                                            setState(() {
                                              decks.removeAt(index);
                                            });
                                          },
                                          onSavePressed: (v) async {
                                            decks[index].title = v;
                                            await decks[index].dbUpdate();
                                            setState(() {});
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ))))));
  }
}
