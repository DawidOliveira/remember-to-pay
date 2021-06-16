import 'package:connectivity/connectivity.dart';
import 'package:remember_to_pay/app/repositories/note/note_repository.dart';
import 'package:remember_to_pay/app/services/note/note_service_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteService implements INoteService {
  SharedPreferences? _ps;
  final Connectivity _connectivity;
  final NoteRepository _noteRepository;

  NoteService(this._connectivity, this._noteRepository) {
    persistData();
  }

  void persistData() {
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event != ConnectivityResult.none) {
        (await _noteRepository.getNotes()).forEach((e) async {
          if (!e.synced) {
            await _noteRepository.addNoteDB(e.id, e.desc, e.date);
          }
        });
        await syncRemoveDB();
      }
    });
  }

  Future<void> syncRemoveDB() async {
    try {
      _ps = await SharedPreferences.getInstance();
      if (_ps!.getStringList('removeNotes') == null) return;
      _ps!.getStringList('removeNotes')!.forEach((element) async {
        await _noteRepository.removeNoteDB(element);
        await _noteRepository.removeLocalNotesID(element);
      });
    } catch (e) {
      print('syncRemoveDB $e');
    }
  }
}
