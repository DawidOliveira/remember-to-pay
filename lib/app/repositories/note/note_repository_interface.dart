import 'package:remember_to_pay/app/shared/models/note.dart';

abstract class INoteRepository {
  Future<List<NoteModel>> getNotes();
  Future<NoteModel?> getNote(String id);
  Future<void> getNotesDBBackup();
  Future<NoteModel?> addNote(String id, String desc, DateTime date);
  Future<void> addNoteDB(String id, String desc, DateTime date);
  Future<NoteModel?> removeNote(String id);
  Future<void> removeNoteDB(String id);
  Future<void> removeLocalNotesID(String id);
}
