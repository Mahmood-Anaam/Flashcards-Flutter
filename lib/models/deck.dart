import '../utils/db_helper.dart';

class Deck {
  int? id;
  final DateTime createdAt;
  String title;

  Deck({
    this.id,
    required this.createdAt,
    required this.title,
  });

  Future<void> dbSave() async {
    id = await DBHelper().insert('deck', {
      'title': title,
    });
  }

  Future<void> dbUpdate() async {
    await DBHelper().update('deck', {
      'id':id!,
      'title': title,
    });
  }

  Future<void> dbDelete() async {

    if (id != null) {
      await DBHelper().delete('deck', id!);
      final db = await DBHelper().db;
      await db.delete(
        'card',
        where: 'deck_id = ?',
        whereArgs: [id!],
      );
    }
  }
}
