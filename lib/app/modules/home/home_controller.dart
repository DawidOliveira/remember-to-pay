import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/config.dart';
import 'package:remember_to_pay/app/repositories/note/note_repository.dart';
import 'package:remember_to_pay/app/services/auth/auth_service.dart';
import 'package:remember_to_pay/app/services/notification/notification_service.dart';
import 'package:remember_to_pay/app/shared/models/note.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomeController extends ChangeNotifier {
  final Config config;
  final NoteRepository _noteRepository;
  final AuthService _authService;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final list = RxNotifier<List<NoteModel>>([]);
  final currentIndex = RxNotifier<int>(0);

  HomeController(this.config, this._noteRepository, this._authService) {
    init();
  }

  Future<void> init() async {
    list.value = _noteRepository.notes.value;
  }

  void changeCurrentIndex(int value) => currentIndex.value = value;

  void setNoteInList(NoteModel note) {
    list.value.add(note);
    Modular.get<NotificationService>().sendNotification(
      body: note.desc,
      id: note.id,
      title: 'Hey, você tem conta para pagar hoje!',
      date: note.date,
    );
    list.notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<void> removeNote(NoteModel note) async {
    final response = await _noteRepository.removeNote(note.id);
    if (response != null) {
      list.value.remove(response);
      Modular.get<NotificationService>().cancelNotification(note.id);
      list.notifyListeners();
    }
  }
}
