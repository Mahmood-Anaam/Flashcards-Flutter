import '../utils/db_helper.dart';

class FlashCard{
  int? id;
  final int deckId;
  final DateTime createdAt;
  String question;
  String answer;


  FlashCard({
    this.id,
    required this.createdAt,
    required this.deckId,
    required this.question,
    required this.answer,
  });




  Future<void> dbSave() async {
    id = await DBHelper().insert('card', {
      'question': question,
      'answer': answer,
      'deck_id': deckId,
    });
  }

  Future<void> dbUpdate() async {
    await DBHelper().update('card', {
      'id': id!,
      'question': question,
      'answer': answer,
      'deck_id': deckId,
    });
  }

  Future<void> dbDelete() async {
    if (id != null) {
      await DBHelper().delete('card', id!);

    }
  }
}
