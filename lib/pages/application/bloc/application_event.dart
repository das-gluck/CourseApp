abstract class AppEvent{
  const AppEvent();
}

class TriggeredAppEvent extends AppEvent{
  final int index;
  const TriggeredAppEvent(this.index):super();
}