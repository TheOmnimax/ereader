import 'package:ereader/screens/select_style_screen/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ereader/shared_widgets/custom_style/style_preview.dart';
import 'package:ereader/shared_widgets/list_builder.dart';
import 'package:ereader/screens/select_style_screen/bloc/bloc.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectStyleMain extends StatelessWidget {
  const SelectStyleMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectStyleBloc()..add(const LoadPage()),
      child: const SelectStyleScreen(),
    );
  }
}

class SelectStyleScreen extends StatelessWidget {
  const SelectStyleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void popupItemSelected(String value) {
      if (value == 'Add new style') {
        Navigator.pushNamed(context, '/custom_style');
      }
    }

    List<Widget> styleListBuilder(List<EreaderStyle> ereaderStyles) {
      print('About to create list with:');
      print(ereaderStyles);
      final widgetList = <Widget>[];
      for (final value in ereaderStyles) {
        final listItem = StyleListItem(
          onPressed: () {
            context
                .read<SelectStyleBloc>()
                .add(StyleSelected(ereaderStyle: value));
          },
          ereaderStyle: value,
        );
        widgetList.add(listItem);
      }
      print('Widget list:');
      print(widgetList);
      return widgetList;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select style'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: popupItemSelected,
            itemBuilder: (BuildContext context) {
              return {'Add new style'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: BlocBuilder<SelectStyleBloc, SelectStyleScreenState>(
        builder: (context, state) {
          final ereaderStyle = state.selectedEreaderStyle;
          final allStyles = state.allStyles;
          print('All styles in bloc builder:');
          print(allStyles);

          if (state is SelectStyleLoading) {
            return Text('Loading...');
          }
          return SafeArea(
            child: Column(
              children: <Widget>[
                StylePreview(ereaderStyle: ereaderStyle),
                ListBuilder(widgets: styleListBuilder(state.allStyles)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StyleListItem extends StatelessWidget {
  const StyleListItem({
    required this.onPressed,
    required this.ereaderStyle,
  });

  final Function() onPressed;
  final EreaderStyle ereaderStyle;

  @override
  Widget build(BuildContext context) {
    return ListItem(
      backgroundColor: ereaderStyle.backgroundColor,
      mainButton: TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          primary: ereaderStyle.fontColor,
        ),
        onPressed: onPressed,
        child: Text(
          ereaderStyle.name,
          style: TextStyle(
            color: ereaderStyle.fontColor,
          ),
        ),
      ),
      kebabFunction: () {},
    );
  }
}
