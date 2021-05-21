import 'package:remember_to_pay/app/shared/models/note.dart';

abstract class INoteRepository {
  Future<List<NoteModel>> getNotes();
  Future<NoteModel?> getNote(String id);
  Future<void> getNotesDBBackup();
}
