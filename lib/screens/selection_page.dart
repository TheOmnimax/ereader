import 'package:ereader/file_explorer/ebook_metadata.dart';
import 'package:ereader/shared_widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import '../file_explorer/doc_selection.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
      if (value == 'eReader style') {
        Navigator.pushNamed(context, '/style_selection');
      }
    }

    return MainScaffold(
      child: ListView(
          /*
          children: ListTile.divideTiles(
            context: context,
            tiles: buildDocRows(getAllDocs()),
          ).toList(),
        */
          ),
      popupMenuButton: PopupMenuButton<String>(
        onSelected: handleClick,
        itemBuilder: (BuildContext context) {
          return {'eReader style'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
    );
  }
}
