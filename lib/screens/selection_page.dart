import 'package:ereader/file_explorer/ebook_metadata.dart';
import 'package:ereader/shared_parts/main_scaffold.dart';
import 'package:flutter/material.dart';
import '../file_explorer/doc_selection.dart';

class DocSelection extends StatefulWidget {
  const DocSelection({Key? key}) : super(key: key);

  @override
  _DocSelectionState createState() => _DocSelectionState();
}

class _DocSelectionState extends State<DocSelection> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: buildDocRows(getAllDocs()),
          ).toList(),
        ),
        kebab: () {});
  }
}

// buildDocRows(getAllDocs())
