import 'package:remember_to_pay/app/repositories/note/note_repository_interface.dart';
import 'package:remember_to_pay/app/shared/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteRepository implements INoteRepository {
  SharedPreferences? _ps;
  @override
  Future<NoteModel?> getNote(String id) async {
    try {
      _ps = await SharedPreferences.getInstance();

      final notes = _ps!
              .getStringList('notes')
              ?.map((e) => NoteModel.fromJson(e))
              .toList() ??
          <NoteModel>[];

      final note = notes.firstWhere((element) => element.id == id);

      return note;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    try {
      _ps = await SharedPreferences.getInstance();

      final notes = _ps!
              .getStringList('notes')
              ?.map((e) => NoteModel.fromJson(e))
              .toList() ??
          <NoteModel>[];

      return notes;
    } catch (e) {
      print(e);
      return List.empty();
    }
  }
}
