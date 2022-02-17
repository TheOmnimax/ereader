import 'dart:convert';
import 'package:ereader/screens/custom_style_screen/bloc/custom_style_screen_event.dart';
import 'package:ereader/screens/custom_style_screen/bloc/custom_style_screen_state.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/shared_widgets/show_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ereader/file_explorer/files.dart';

class CustomStyleBloc extends Bloc<CustomStyleEvent, CustomStyleState> {
  CustomStyleBloc() : super(const CustomStyleState()) {
    on<UpdateStyle>(_styleChanged);
    on<ModuleSelected>(_moduleSelected);
    on<SavePreferences>(_savePreferences);
    // on<LoadPreferences>(_loadPreferences);
  }

  final FileReadWrite _fileReadWrite =
      const FileReadWrite(relativePath: 'styles/');
  final String _filename = 'savedStyles.json';

  // EreaderStyle ereaderStyle = const EreaderStyle();

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
    final newName = event.ereaderStyle.name;
    final jsonData = event.ereaderStyle.toJson();
    final styleList = await _fileReadWrite.getFileAsList(_filename);
    var alreadyExists = false;

    for (final style in styleList) {
      final styleName = style['name'] as String;
      if (newName == styleName) {
        alreadyExists = true;
        await showPopup(
          context: event.context,
          title: 'Warning: Name already exists',
          buttons: <Widget>[
            TextButton(
              child: const Text('Yes, update'),
              onPressed: () {
                Navigator.of(event.context).pop();
                var styleIndex = styleList.indexOf(style);
                styleList[styleIndex] = jsonData;
              },
            ),
            TextButton(
              child: const Text('No, continue editing'),
              onPressed: () {
                Navigator.of(event.context).pop();
              },
            ),
          ],
          body: const Text(
              'There is already a style with this name. Are you sure you would like to replace the old style with this new the style?'),
        );
        break;
      }
    }

    if (!alreadyExists) {
      styleList.add(jsonData);
    }

    final stringData = jsonEncode(styleList);
    print('Writing:');
    print(stringData);
    await _fileReadWrite.writeString(
      filename: _filename,
      contents: stringData,
    );
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
