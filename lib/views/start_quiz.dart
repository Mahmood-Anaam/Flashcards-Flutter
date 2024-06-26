// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../models/flashcard.dart';

class StartQuiz extends StatefulWidget {
  StartQuiz({super.key, required this.deck, required this.flashCards});
  final Deck deck;
  List<FlashCard> flashCards;

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  bool showAnswer = false;
  int indexCard = 0;
  int numSeeCards = 1;
  int numSeeAnswers = 0;
  @override
  void initState() {
    shuffle(widget.flashCards);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(95, 148, 236, 1),
        title: Text(
          "${widget.deck.title} Quiz",
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
      ),
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Card(
                    color: showAnswer
                        ? const Color.fromRGBO(206, 229, 203, 1)
                        : const Color.fromRGBO(192, 218, 245, 1),
                    child: Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          showAnswer
                              ? widget.flashCards[indexCard].answer
                              : widget.flashCards[indexCard].question,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {

                        if (indexCard > 0) {
                          setState(() {
                            indexCard--;
                            showAnswer=false;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      )),
                  IconButton(
                      onPressed: () {
                        showAnswer = !showAnswer;
                        numSeeAnswers =
                            showAnswer ? numSeeAnswers + 1 : numSeeAnswers;
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.copy,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          indexCard =
                              (indexCard + 1) % widget.flashCards.length;
                          numSeeCards = indexCard + 1;
                          showAnswer=false;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                      )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "See ${indexCard+1} of ${widget.flashCards.length} cards",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Peeked at $numSeeAnswers of $numSeeCards answers",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
