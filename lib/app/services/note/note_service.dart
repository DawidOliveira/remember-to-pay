import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:remember_to_pay/app/repositories/note/note_repository.dart';
import 'package:remember_to_pay/app/services/note/note_service_interface.dart';
import 'package:remember_to_pay/app/shared/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteService implements INoteService {
  SharedPreferences? _ps;
  final FirebaseFirestore _firestore;
  final Connectivity _connectivity;
  final NoteRepository _noteRepository;

  NoteService(this._firestore, this._connectivity, this._noteRepository) {
    init();
  }

  void init() {
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event != ConnectivityResult.none) {
        (await _noteRepository.getNotes()).forEach((e) {
          if (!e.synced) {
            addNoteDB(e.id, e.desc, e.date);
          }
        });
        await syncRemoveDB();
      }
    });
  }

  @override
  Future<NoteModel?> addNote(String id, String desc, DateTime date) async {
    try {
      _ps = await SharedPreferences.getInstance();
      final notes = _ps!
              .getStringList('notes')
              ?.map((e) => NoteModel.fromJson(e))
              .toList() ??
          <NoteModel>[];

      final note = NoteModel(id: id, desc: desc, date: date, synced: false);
      notes.add(note);

      await _ps!.setStringList('notes', notes.map((e) => e.toJson()).toList());
      if ((await _connectivity.checkConnectivity()) ==
              ConnectivityResult.mobile ||
          (await _connectivity.checkConnectivity()) ==
              ConnectivityResult.wifi) {
        await addNoteDB(id, desc, date);
      }
      return note;
    } catch (e) {
      print('addNote $e');
      return null;
    }
  }

  Future<void> addNoteDB(String id, String desc, DateTime date) async {
    try {
      _ps = await SharedPreferences.getInstance();
      await _firestore.collection('notes').doc(id).set({
        'desc': desc,
        'date': date,
        'synced': true,
      });
      final notes = _ps!
              .getStringList('notes')
              ?.map((e) => NoteModel.fromJson(e))
              .toList() ??
          <NoteModel>[];

      notes.firstWhere((element) => element.id == id)..changeSynced(true);

      await _ps!.setStringList('notes', notes.map((e) => e.toJson()).toList());

      _noteRepository.notes.value
          .firstWhere((element) => element.id == id)
          .changeSynced(true);
    } catch (e) {
      print('addNoteDB $e');
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
      final List<String> removeNotes = _ps!.getStringList('removeNotes') ?? [];
      removeNotes.add(id);
      await _ps!.setStringList(
        'removeNotes',
        removeNotes,
      );
      if ((await _connectivity.checkConnectivity()) !=
          ConnectivityResult.none) {
        await removeNoteDB(id);
        await removeLocalNotesID(id);
      }
      _noteRepository.notes.value.removeWhere((element) => element.id == id);
      return note;
    } catch (e) {
      print('removeNote $e');
      return null;
    }
  }

  Future<void> removeNoteDB(String id) async {
    try {
      await _firestore.collection('notes').doc(id).delete();
    } catch (e) {
      print('removeNoteDB $e');
    }
  }

  Future<void> syncRemoveDB() async {
    try {
      _ps = await SharedPreferences.getInstance();
      if (_ps!.getStringList('removeNotes') == null) return;
      _ps!.getStringList('removeNotes')!.forEach((element) async {
        await removeNoteDB(element);
        await removeLocalNotesID(element);
      });
    } catch (e) {
      print('syncRemoveDB $e');
    }
  }

  Future<void> removeLocalNotesID(String id) async {
    try {
      _ps = await SharedPreferences.getInstance();
      final _removeNotes = _ps!.getStringList('removeNotes')
        ?..removeWhere((e) => e == id);
      await _ps!.setStringList('removeNotes', _removeNotes!);
    } catch (e) {
      print('removeLocalNotesID $e');
    }
  }
}
