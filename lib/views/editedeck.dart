import 'package:flutter/material.dart';
import '../models/deck.dart';

class EditeDeck extends StatefulWidget {
  const EditeDeck(
      {super.key,
      required this.deck,
      this.onSavePressed,
      this.onDeletePressed});

  final Deck? deck;
  final Function(String title)? onSavePressed;
  final VoidCallback? onDeletePressed;

  @override
  State<EditeDeck> createState() => _EditeDeckState();
}

class _EditeDeckState extends State<EditeDeck> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(
        text: widget.deck == null ? "" : widget.deck!.title);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(95, 148, 236, 1),
        title: Text(
          widget.deck == null ? 'Create New Deck' : 'Edite Deck',
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
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: "Deck name",
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
                              widget.onSavePressed!(_controller.text);
                            }

                            FocusScope.of(context).unfocus();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Save"),
                        ),
                        if (widget.deck != null)
                          const SizedBox(
                            width: 30,
                          ),
                        if (widget.deck != null)
                          TextButton(
                            onPressed: () async {
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
