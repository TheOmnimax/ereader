import 'dart:convert';

import 'package:ereader/screens/select_style_screen/bloc/select_style_screen_event.dart';
import 'package:ereader/screens/select_style_screen/bloc/select_style_screen_state.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/shared_data/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectStyleBloc extends Bloc<SelectStyleEvent, SelectStyleScreenState> {
  SelectStyleBloc() : super(const SelectStyleLoading()) {
    on<LoadPage>(_loadPage);
    on<StyleSelected>(_styleSelected);
    on<StyleMove>(_styleMove);
    on<StyleDelete>(_styleDelete);
  }

  Future<List<EreaderStyle>> _getStyles() async {
    final allStylesRaw =
        await SharedPreferenceTool.getListPreferences('preferences') as List;

    // Use these to clear all preferences
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('preferences', '[]');

    print('Retrieved raw data');

    final allStyles = <EreaderStyle>[];

    for (final element in allStylesRaw) {
      final jsonData = element as Map<String, dynamic>;
      print(jsonData);
      allStyles.add(EreaderStyle.fromJson(jsonData));
    }

    return allStyles;
  }

  Future<void> _styleSelected(
      StyleSelected event, Emitter<SelectStyleScreenState> emit) async {
    final allStyles = await _getStyles();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedStyle', jsonEncode(event.ereaderStyle));

    // TODO: Set so uses current list of styles instead of reloading
    emit(SelectStyleMainState(
      allStyles: allStyles,
      selectedEreaderStyle: event.ereaderStyle,
    ));
  }

  // TODO: Check why emitter class has to be "SelectStyleScreenState" and not "SelectStyleLoading"
  Future<void> _loadPage(
      LoadPage event, Emitter<SelectStyleScreenState> emit) async {
    print('In the bloc...');

    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('preferences', '[]');

    final allStyles = await _getStyles();

    // TODO: get random key from list, and apply one of them to be applied when the page first loads. Currently loads the first one in the list.
    print('Preferences:');
    print(allStyles);

    try {
      final firstEreaderStyle = allStyles[0];
      print('About to emit state...');
      emit(
        SelectStyleMainState(
          allStyles: allStyles,
          selectedEreaderStyle: firstEreaderStyle,
        ),
      );
    } catch (e) {
      const ereaderSettings = EreaderStyle();
      print('About to emit state...');
      emit(SelectStyleMainState(
        allStyles: allStyles,
        selectedEreaderStyle: ereaderSettings,
      ));
    }
  }

  Future<void> _styleMove(
      StyleMove event, Emitter<SelectStyleScreenState> emit) async {
    final allStyles =
        await SharedPreferenceTool.getListPreferences('preferences') as List;
    print('Old length: ${allStyles.length}');
    final moveStyle = event.ereaderStyle;

    for (final style in allStyles) {
      print('Name: ${style['name']}');
      if (style['name'] == moveStyle.name) {
        final oldPosition = allStyles.indexOf(style);
        print('Old position: $oldPosition');
        final newPosition = oldPosition + event.move;
        print('New position: $newPosition');
        if ((newPosition >= 0) && (newPosition < allStyles.length)) {
          allStyles
            ..remove(style)
            ..insert(newPosition, style);

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('preferences', jsonEncode(allStyles));

          final updatedStyles = await _getStyles();
          emit(SelectStyleMainState(
            allStyles: updatedStyles,
            selectedEreaderStyle: event.ereaderStyle,
          ));
        }
        print('New length: ${allStyles.length}');
        return;
      }
    }
    emit(state.copyWith());
  }

  Future<void> _styleDelete(
      StyleDelete event, Emitter<SelectStyleScreenState> emit) async {
    final allStyles =
        await SharedPreferenceTool.getListPreferences('preferences') as List;
    print('Old length: ${allStyles.length}');
    final moveStyle = event.ereaderStyle;

    print('Move style: ${moveStyle.name}');
    print('All styles: ${allStyles}');

    for (final style in allStyles) {
      print('Name: ${style['name']}');
      if (style['name'] == moveStyle.name) {
        final oldPosition = allStyles.indexOf(style);
        print('Old position: $oldPosition');
        allStyles.remove(style);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('preferences', jsonEncode(allStyles));

        final updatedStyles = await _getStyles();
        print('New length: ${updatedStyles.length}');

        print(updatedStyles);
        emit(SelectStyleMainState(
          allStyles: updatedStyles,
          selectedEreaderStyle: event.ereaderStyle,
        ));

        // TODO: Find why copyWith is not working

        // print('Emitting...');
        // emit(state.copyWith(allStyles: updatedStyles));
        // print('Emitted.');
        return;
      }
    }
    emit(state.copyWith());
  }
}
