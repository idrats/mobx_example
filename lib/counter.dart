import 'package:mobx/mobx.dart';
part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() => value++;
}

// class Counter {
//   Counter() {
//     increment = Action(_increment);
//   }

//   final _value = Observable(0);
//   int get value => _value.value;
//   set value(int val) => _value.value = val;

//   Action increment;

//   void _increment() {
//     _value.value++;
//   }
// }
