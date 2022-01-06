import 'dart:convert';
import 'package:ereader/screens/select_style_screen/bloc/select_style_screen_event.dart';
import 'package:ereader/screens/select_style_screen/bloc/select_style_screen_state.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ereader/shared_data/shared_preferences.dart';

class SelectStyleBloc extends Bloc<SelectStyleEvent, SelectStyleScreenState> {
  SelectStyleBloc() : super(const SelectStyleLoading()) {
    on<LoadPage>(_loadPage);
    on<StyleSelected>(_styleSelected);
  }

  Future<List<EreaderStyle>> _getStyles() async {
    final allStylesRaw =
        await SharedPreferenceTool.getListPreferences('preferences') as List;

    print('Retrieved raw data');

    final allStyles = <EreaderStyle>[];

    for (final element in allStylesRaw) {
      final jsonData = element as Map<String, dynamic>;
      print(jsonData);
      allStyles.add(EreaderStyle.fromJson(jsonData));
    }

    return allStyles;
  }

  void _styleSelected(
      StyleSelected event, Emitter<SelectStyleScreenState> emit) async {
    final allStyles = await _getStyles();

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

      // TODO: Apply settings to the state
      print('About to emit state...');
      emit(
        SelectStyleMainState(
          allStyles: allStyles,
          selectedEreaderStyle: firstEreaderStyle,
        ),
      );
    } catch (e) {
      var ereaderSettings = const EreaderStyle();
      print('About to emit state...');
      emit(SelectStyleMainState(
        allStyles: allStyles,
        selectedEreaderStyle: ereaderSettings,
      ));
    }
  }
}
