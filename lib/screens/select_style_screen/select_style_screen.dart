import 'package:ereader/screens/select_style_screen/bloc/bloc.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/shared_widgets/custom_style/style_preview.dart';
import 'package:ereader/shared_widgets/list_builder.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/custom_style_screen/custom_style_screen.dart';

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
        Navigator.pushNamed(
          context,
          '/custom_style',
        ).then((_) {
          context.read<SelectStyleBloc>().add(
                const LoadPage(),
              );
        });
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
          popupItems: createPopupMenuList(
            itemList: [
              'Item 1',
              'Item 2',
            ],
          ),
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
          PopupMenu(
            onSelected: popupItemSelected,
            itemList: ['Add new style'],
          ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child:
                      ListBuilder(widgets: styleListBuilder(state.allStyles)),
                ),
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
    this.popupItems = const <PopupMenuEntry<String>>[],
  });

  final Function() onPressed;
  final EreaderStyle ereaderStyle;
  final List<PopupMenuEntry<String>> popupItems;

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
      kebabColor: ereaderStyle.fontColor,
      kebabFunction: (String selectedItem) {
        switch (selectedItem) {
          case kMoveUp:
            {
              print('Move up');
              context.read<SelectStyleBloc>().add(
                    StyleMove(
                      ereaderStyle: ereaderStyle,
                      move: -1,
                    ),
                  );
              break;
            }
          case kMoveDown:
            {
              print('Move down');
              context.read<SelectStyleBloc>().add(
                    StyleMove(
                      ereaderStyle: ereaderStyle,
                      move: 1,
                    ),
                  );
              break;
            }
          case kEdit:
            {
              print('Edit');

              Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (context) => CustomStyleMain(
                          defaultStyle: ereaderStyle,
                        )),
              );

              // Navigator.pushNamed(context, '/custom_style',
              //     arguments: <String, dynamic>{
              //       'style': ereaderStyle,
              //     }).then((_) {
              //   context.read<SelectStyleBloc>().add(
              //         const LoadPage(),
              //       );
              // });
              break;
            }
          case kDelete:
            {
              print('Delete');
              context.read<SelectStyleBloc>().add(
                    StyleDelete(
                      ereaderStyle: ereaderStyle,
                    ),
                  );
              break;
            }
          default:
            {
              print('Invalid');
            }
        }
      },
      itemList: const <String>[
        kMoveUp,
        kMoveDown,
        kEdit,
        kDelete,
      ],
    );
  }
}
