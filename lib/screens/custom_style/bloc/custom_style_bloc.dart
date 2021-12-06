import 'package:ereader/screens/custom_style/bloc/custom_style_event.dart';
import 'package:ereader/shared_data/ereader_style.dart';

import 'custom_style_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomStyleBloc extends Bloc<CustomStyleEvent, CustomStyleState> {
  CustomStyleBloc() : super(StyleInitial()) {
    on<ChangeBackgroundColor>(_backgroundChanged);
    on<LoadPreferences>(_loadPreferences);
  }

  EreaderStyle ereaderStyle = const EreaderStyle();

  void _backgroundChanged(
      ChangeBackgroundColor event, Emitter<CustomStyleState> emit) {
    var newStyle = EreaderStyle(
        // It says it prefers a const, but there is an error when I make it a const.
        backgroundColor: event.newColor);
    emit(StyleAdjusted(ereaderStyle: newStyle));
  }

  void _loadPreferences(LoadPreferences event, Emitter<CustomStyleState> emit) {
    var stringData = event.preferencesString;
    print('String data:');
    print(stringData);
    var newStyle = EreaderStyle.fromStringData(stringData);
    emit(StyleAdjusted(ereaderStyle: newStyle));
  }
}
