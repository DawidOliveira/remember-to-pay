import 'package:remember_to_pay/app/services/note/note_service_interface.dart';
import 'package:remember_to_pay/app/shared/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteService implements INoteService {
  SharedPreferences? _ps;

  @override
  Future<NoteModel?> addNote(String id, String desc, DateTime date) async {
    try {
      _ps = await SharedPreferences.getInstance();
      final notes = _ps!
              .getStringList('notes')
              ?.map((e) => NoteModel.fromJson(e))
              .toList() ??
          <NoteModel>[];

      final note = NoteModel(id: id, desc: desc, date: date);
      notes.add(note);

      await _ps!.setStringList('notes', notes.map((e) => e.toJson()).toList());
      return note;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<NoteModel?> removeNote(String id) async {
    try {
      _ps = await SharedPreferences.getInstance();
      final notes = _ps!
              .getStringList('notes')
              ?.map((e) => NoteModel.fromJson(e))
              .toList() ??
          [];
      final note = notes.firstWhere((element) => element.id == id);
      notes.remove(note);
      await _ps!.setStringList('notes', notes.map((e) => e.toJson()).toList());
      return note;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
