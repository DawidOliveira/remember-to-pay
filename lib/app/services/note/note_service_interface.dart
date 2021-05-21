import 'package:remember_to_pay/app/shared/models/note.dart';

abstract class INoteService {
  Future<NoteModel?> addNote(String id, String desc, DateTime date);
  Future<void> addNoteDB(String id, String desc, DateTime date);
  Future<NoteModel?> removeNote(String id);
  Future<void> removeNoteDB(String id);
  Future<void> syncRemoveDB();
  Future<void> removeLocalNotesID(String id);
  void persistData();
}
