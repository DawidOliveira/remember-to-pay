import 'package:rx_notifier/rx_notifier.dart';

class DrawerWidgetController {
  final currentIndex = RxNotifier<int>(0);

  void changeCurrentIndex(int value) => currentIndex.value = value;
}
