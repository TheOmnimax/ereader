// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc observer.
class MainBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('Bloc error: ${bloc.toString()}, error: $error, trace: $stackTrace');
  }
}
