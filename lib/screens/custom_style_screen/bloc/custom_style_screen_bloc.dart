import 'package:ereader/screens/custom_style_screen/bloc/custom_style_screen_event.dart';
import 'package:ereader/shared_data/ereader_style.dart';

import 'custom_style_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomStyleBloc extends Bloc<CustomStyleEvent, CustomStyleState> {
  CustomStyleBloc() : super(StyleInitial()) {
    on<UpdateStyle>(_styleChanged);
    on<LoadPreferences>(_loadPreferences);
  }

  EreaderStyle ereaderStyle = const EreaderStyle();

  void _styleChanged(UpdateStyle event, Emitter<CustomStyleState> emit) {
    final newStyle = EreaderStyle(
      backgroundColor: event.backgroundColor,
      fontColor: event.fontColor,
      fontSize: event.fontSize,
      fontFamily: event.fontFamily,
      margins: event.margins,
    );
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
