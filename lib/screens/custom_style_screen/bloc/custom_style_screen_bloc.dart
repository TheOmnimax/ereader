import 'dart:convert';

import 'package:ereader/screens/custom_style_screen/bloc/custom_style_screen_event.dart';
import 'package:ereader/screens/custom_style_screen/bloc/custom_style_screen_state.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomStyleBloc extends Bloc<CustomStyleEvent, CustomStyleState> {
  CustomStyleBloc() : super(const CustomStyleState()) {
    on<UpdateStyle>(_styleChanged);
    on<ModuleSelected>(_moduleSelected);
    on<SavePreferences>(_savePreferences);
    // on<LoadPreferences>(_loadPreferences);
  }

  EreaderStyle ereaderStyle = const EreaderStyle();

  void _styleChanged(UpdateStyle event, Emitter<CustomStyleState> emit) {
    final newStyle = EreaderStyle(
      backgroundColor:
          event.backgroundColor ?? state.ereaderStyle.backgroundColor,
      fontColor: event.fontColor ?? state.ereaderStyle.fontColor,
      fontSize: event.fontSize ?? state.ereaderStyle.fontSize,
      fontFamily: event.fontFamily ?? state.ereaderStyle.fontFamily,
      margins: event.margins ?? state.ereaderStyle.margins,
      name: event.name ?? state.ereaderStyle.name,
    );
    emit(state.copyWith(ereaderStyle: newStyle));
  }

  void _moduleSelected(ModuleSelected event, Emitter<CustomStyleState> emit) {
    emit(
      state.copyWith(
        selectedModule: event.selectedModule,
      ),
    );
  }

  Future<void> _savePreferences(
      SavePreferences event, Emitter<CustomStyleState> emit) async {
    final prefName = event.ereaderStyle.name;
    final jsonData = event.ereaderStyle.toJson();
    final prefs = await SharedPreferences.getInstance();
    final allPreferences = prefs.getString('preferences') ?? '{}';
    final preferenceJson = jsonDecode(allPreferences) as Map<String, dynamic>;
    preferenceJson[prefName] = jsonData;
    final newPrefString = jsonEncode(preferenceJson);
    await prefs.setString('preferences', newPrefString);
    emit(state.copyWith());
  }

  // void _loadPreferences(LoadPreferences event, Emitter<CustomStyleState> emit) {
  //   var stringData = event.preferencesString;
  //   print('String data:');
  //   print(stringData);
  //   var newStyle = EreaderStyle.fromStringData(stringData);
  //   emit(StyleAdjusted(ereaderStyle: newStyle));
  // }
}
