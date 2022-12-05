import 'dart:convert';

import 'package:ereader/screens/select_style_screen/bloc/select_style_screen_event.dart';
import 'package:ereader/screens/select_style_screen/bloc/select_style_screen_state.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/utils/file_explorer/files.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectStyleBloc extends Bloc<SelectStyleEvent, SelectStyleScreenState> {
  SelectStyleBloc() : super(const SelectStyleLoading()) {
    on<LoadPage>(_loadPage);
    // on<StyleSelected>(_styleSelected);
    on<StyleMove>(_styleMove);
    on<StyleDelete>(_styleDelete);
  }

  final FileReadWrite _fileReadWrite =
      const FileReadWrite(relativePath: 'styles/');
  final String _savedStylesFile = 'savedStyles.json';
  final String _selectedStyleFile = 'selectedStyle.json';

  Future<List<EreaderStyle>> get _styleList async {
    final styleListRaw = await _fileReadWrite.getFileAsList(_savedStylesFile);

    final styleList = <EreaderStyle>[];

    for (final element in styleListRaw) {
      final jsonData = element as Map<String, dynamic>;
      styleList.add(EreaderStyle.fromJson(jsonData));
    }

    return styleList;
  }

  Future<bool> _saveStyleList(List<EreaderStyle> styleList) async {
    final jsonList = <Map<String, dynamic>>[];

    for (final element in styleList) {
      final processedElement = element.toJson();
      jsonList.add(processedElement);
    }

    final writer = await _fileReadWrite.writeString(
      filename: _savedStylesFile,
      contents: jsonEncode(jsonList),
    );

    return writer;
  }

  // Future<void> _styleSelected(
  //     StyleSelected event, Emitter<SelectStyleScreenState> emit) async {
  //   final stringData = jsonEncode(event.ereaderStyle);
  //   await _fileReadWrite.writeString(
  //     filename: _selectedStyleFile,
  //     contents: stringData,
  //   );
  //
  //   emit(state.copyWith(
  //     selectedEreaderStyle: event.ereaderStyle,
  //   ));
  // }

  Future<void> _loadPage(
    LoadPage event,
    Emitter<SelectStyleScreenState> emit,
  ) async {
    final allStyles = await _styleList;

    // Get currently selected style
    final selectedStyleMap =
        await _fileReadWrite.getFileAsMap(_selectedStyleFile);

    final EreaderStyle selectedStyle;
    if (selectedStyleMap.isEmpty) {
      selectedStyle = const EreaderStyle();
    } else {
      selectedStyle = EreaderStyle.fromJson(selectedStyleMap);
    }

    try {
      emit(
        SelectStyleMainState(
          allStyles: allStyles,
          selectedEreaderStyle: selectedStyle,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        const SelectStyleMainState(),
      );
    }
  }

  Future<void> _styleMove(
    StyleMove event,
    Emitter<SelectStyleScreenState> emit,
  ) async {
    final allStyles = await _styleList;
    final moveStyle = event.ereaderStyle;

    for (final style in allStyles) {
      if (style.name == moveStyle.name) {
        final oldPosition = allStyles.indexOf(style);
        final newPosition = oldPosition + event.move;
        if ((newPosition >= 0) && (newPosition < allStyles.length)) {
          allStyles
            ..remove(style)
            ..insert(newPosition, style);

          await _saveStyleList(allStyles);
          final updatedStyles = await _styleList;

          emit(
            SelectStyleMainState(
              allStyles: updatedStyles,
              selectedEreaderStyle: event.ereaderStyle,
            ),
          );
        }
        return;
      }
    }
  }

  Future<void> _styleDelete(
    StyleDelete event,
    Emitter<SelectStyleScreenState> emit,
  ) async {
    final allStyles = await _styleList;
    final moveStyle = event.ereaderStyle;

    for (final style in allStyles) {
      if (style.name == moveStyle.name) {
        allStyles.remove(style);

        await _saveStyleList(allStyles);

        final updatedStyles = await _styleList;

        emit(state.copyWith(allStyles: updatedStyles));

        return;
      }
    }
  }
}
