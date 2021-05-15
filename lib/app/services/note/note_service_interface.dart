import 'package:remember_to_pay/app/shared/models/note.dart';

abstract class INoteService {
  Future<NoteModel?> addNote(String id, String desc, DateTime date);
  Future<NoteModel?> removeNote(String id);
}
