import 'package:flutter/material.dart';

import '../models/deck.dart';
import '../models/flashcard.dart';
import '../utils/db_helper.dart';
import 'editecard.dart';
import 'start_quiz.dart';

class CardList extends StatefulWidget {
  const CardList({super.key, required this.deck});
  final Deck deck;
  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool isSorted = false;
  Future<List<FlashCard>> _loadData() async {
    final data =
        await DBHelper().query('card', where: 'deck_id = ${widget.deck.id!}');
    final lst = data
        .map((e) => FlashCard(
              createdAt: DateTime.now(),
              id: e['id'] as int,
              question: e['question'] as String,
              answer: e['answer'] as String,
              deckId: e['deck_id'] as int,
            ))
        .toList();
    if (isSorted) {
      lst.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      lst.sort((a, b) => a.question.compareTo(b.question));
    }
    return lst;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadData(),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final cards = snapshot.data as List<FlashCard>;

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(95, 148, 236, 1),
                title: Text(
                  widget.deck.title,
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isSorted = !isSorted;
                        });
                      },
                      icon: const Icon(
                        Icons.sort_by_alpha,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return StartQuiz(
                            deck: widget.deck,
                            flashCards: [...cards],
                          );
                        }));
                      },
                      icon: const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      )),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return EditeCard(
                          card: null,
                          onDeletePressed: null,
                          onSavePressed: (question, answer) async {
                            final card = FlashCard(
                              createdAt: DateTime.now(),
                              question: question,
                              answer: answer,
                              deckId: widget.deck.id!,
                            );
                            await card.dbSave();
                            setState(() {
                              cards.add(card);
                            });
                          },
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
                      cards.length,
                      (index) => Card(
                          color: const Color.fromRGBO(192, 218, 245, 1),
                          child: Container(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return EditeCard(
                                              card: cards[index],
                                              onDeletePressed: () async {
                                                await cards[index].dbDelete();
                                                setState(() {
                                                  cards.removeAt(index);
                                                });
                                              },
                                              onSavePressed:
                                                  (question, answer) async {
                                                cards[index].question =
                                                    question;
                                                cards[index].answer = answer;
                                                await cards[index].dbUpdate();
                                                setState(() {});
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  Center(child: Text(cards[index].question)),
                                ],
                              ))))));
        }
      },
    );
  }
}
