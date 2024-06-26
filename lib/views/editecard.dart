import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class EditeCard extends StatefulWidget {
  const EditeCard(
      {super.key,
      required this.card,
      this.onSavePressed,
      this.onDeletePressed});

  final FlashCard? card;
  final Function(String question, String answer)? onSavePressed;
  final VoidCallback? onDeletePressed;

  @override
  State<EditeCard> createState() => _EditeCardState();
}

class _EditeCardState extends State<EditeCard> {
  late TextEditingController _quesController;
  late TextEditingController _answerController;
  @override
  void initState() {
    _quesController = TextEditingController(
        text: widget.card == null ? "" : widget.card!.question);
    _answerController = TextEditingController(
        text: widget.card == null ? "" : widget.card!.answer);
    super.initState();
  }

  @override
  void dispose() {
    _quesController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(95, 148, 236, 1),
        title: Text(
          widget.card == null ? 'Create New Card' : 'Edite Card',
          style: const TextStyle(
            color: Colors.white,
          ),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _quesController,
                      decoration: const InputDecoration(
                        labelText: "Question",
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _answerController,
                      decoration: const InputDecoration(
                        labelText: "Answer",
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (widget.onSavePressed != null) {
                              widget.onSavePressed!(
                                  _quesController.text, _answerController.text);
                            }

                            FocusScope.of(context).unfocus();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Save"),
                        ),
                        if (widget.card != null)
                          const SizedBox(
                            width: 30,
                          ),
                        if (widget.card != null)
                          TextButton(
                            onPressed: () {
                              if (widget.onDeletePressed != null) {
                                widget.onDeletePressed!();
                              }

                              FocusScope.of(context).unfocus();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Delete"),
                          )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
