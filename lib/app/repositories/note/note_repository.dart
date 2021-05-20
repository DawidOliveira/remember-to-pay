import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/repositories/note/note_repository_interface.dart';
import 'package:remember_to_pay/app/shared/models/note.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteRepository extends ChangeNotifier implements INoteRepository {
  SharedPreferences? _ps;
  final FirebaseFirestore _firestore;
  final notes = RxNotifier<List<NoteModel>>([]);

  NoteRepository(this._firestore) {
    init();
  }

  Future<void> init() async {
    notes.value = await getNotes();
    notes.notifyListeners();
  }

  @override
  Future<NoteModel?> getNote(String id) async {
    try {
      _ps = await SharedPreferences.getInstance();

      final notesAux = _ps!
              .getStringList('notes')
              ?.map((e) => NoteModel.fromJson(e))
              .toList() ??
          <NoteModel>[];

      final note = notesAux.firstWhere((element) => element.id == id);

      return note;
    } catch (e) {
      print('getNote $e');
      return null;
    }
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    try {
      _ps = await SharedPreferences.getInstance();

      final notesAux = _ps!
              .getStringList('notes')
              ?.map((e) => NoteModel.fromJson(e))
              .toList() ??
          <NoteModel>[];

      return notesAux;
    } catch (e) {
      print('getNotes $e');
      return List.empty();
    }
  }

  Future<void> getNotesDBBackup() async {
    try {
      List<NoteModel> listAux = [];
      (await _firestore.collection('notes').get()).docs.forEach((element) {
        listAux.add(
          NoteModel(
            id: element.id,
            desc: element['desc'],
            date: Timestamp((element['date'] as Timestamp).seconds,
                    (element['date'] as Timestamp).nanoseconds)
                .toDate(),
          ),
        );
      });
      await _ps!
          .setStringList('notes', listAux.map((e) => e.toJson()).toList());
      notes.value = await getNotes();
      notes.notifyListeners();
    } catch (e) {
      print('getNotesDBBackup $e');
    }
  }
}
