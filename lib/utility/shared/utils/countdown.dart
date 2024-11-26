import 'dart:async';

class Countdown {
  late Timer _timer;
  Duration _duration;
  late Function(Duration) _onTick;
  late Function() _onFinish;


  Countdown(this._duration, {required Function(Duration) onTick, required Function() onFinish}){
    _onTick = onTick;
    _onFinish = onFinish;
  }

  void start() {
    if (_duration.inMilliseconds > 0) {
      _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
        _duration -= const Duration(milliseconds: 10);
        _onTick(_duration);
        if (_duration.inMilliseconds <= 0) {
          stop();
          _onFinish();
        }
      });
    }
  }

  void stop() {
    _timer.cancel();
  }
}

class CountdownStream {
  final DateTime targetDate;
  late Timer _timer;
  late StreamController<Duration> _streamController;

  CountdownStream({required this.targetDate}) {
    _streamController = StreamController<Duration>.broadcast(
      onListen: _startTimer,
      onCancel: _stopTimer,
    );
  }

  Stream<Duration> get stream => _streamController.stream;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final remainingTime = targetDate.difference(DateTime.now());
      _streamController.add(remainingTime);

      if (remainingTime.isNegative) {
        _streamController.close();
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void dispose() {
    _streamController.close();
  }
}

