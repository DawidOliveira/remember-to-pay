import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/repositories/note/note_repository_interface.dart';
import 'package:remember_to_pay/app/repositories/user/user_repository.dart';
import 'package:remember_to_pay/app/services/notification/notification_service.dart';
import 'package:remember_to_pay/app/shared/models/note.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteRepository extends ChangeNotifier implements INoteRepository {
  SharedPreferences? _ps;
  final FirebaseFirestore _firestore;
  final notes = RxNotifier<List<NoteModel>>([]);
  final NotificationService _notificationService;
  final Connectivity _connectivity;
  final UserRepository _userRepository;

  NoteRepository(this._firestore, this._notificationService, this._connectivity,
      this._userRepository) {
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

  @override
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

  @override
  Future<void> addNoteDB(String id, String desc, DateTime date) async {
    try {
      _ps = await SharedPreferences.getInstance();
      await _firestore
          .collection('users')
          .doc(_userRepository.user.value!.id)
          .collection('notes')
          .doc(id)
          .set({
        'desc': desc,
        'date': date,
        'synced': true,
      });
      final notesAux = _ps!
              .getStringList('notes')
              ?.map((e) => NoteModel.fromJson(e))
              .toList() ??
          <NoteModel>[];

      notesAux.firstWhere((element) => element.id == id)..changeSynced(true);

      await _ps!
          .setStringList('notes', notesAux.map((e) => e.toJson()).toList());

      notes.value.firstWhere((element) => element.id == id).changeSynced(true);
    } catch (e) {
      print('addNoteDB $e');
    }
  }

  @override
  Future<NoteModel?> removeNote(String id) async {
    try {
      _ps = await SharedPreferences.getInstance();
      final notesAux = _ps!
              .getStringList('notes')
              ?.map((e) => NoteModel.fromJson(e))
              .toList() ??
          [];
      final note = notesAux.firstWhere((element) => element.id == id);
      notesAux.remove(note);
      await _ps!
          .setStringList('notes', notesAux.map((e) => e.toJson()).toList());
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
      notes.value.removeWhere((element) => element.id == id);
      return note;
    } catch (e) {
      print('removeNote $e');
      return null;
    }
  }

  Future<void> removeNoteDB(String id) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userRepository.user.value!.id)
          .collection('notes')
          .doc(id)
          .delete();
    } catch (e) {
      print('removeNoteDB $e');
    }
  }

  Future<void> getNotesDBBackup() async {
    try {
      List<NoteModel> listAux = [];
      await _notificationService.cancelAllNotifications();
      (await _firestore
              .collection('users')
              .doc(_userRepository.user.value!.id)
              .collection('notes')
              .get())
          .docs
          .forEach((element) async {
        listAux.add(
          NoteModel(
            id: element.id,
            desc: element['desc'],
            date: Timestamp((element['date'] as Timestamp).seconds,
                    (element['date'] as Timestamp).nanoseconds)
                .toDate(),
          ),
        );
        await _notificationService.sendNotification(
          id: element.id,
          title: 'Hey, você tem conta para pagar hoje!',
          body: element['desc'],
          date: Timestamp((element['date'] as Timestamp).seconds,
                  (element['date'] as Timestamp).nanoseconds)
              .toDate(),
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
