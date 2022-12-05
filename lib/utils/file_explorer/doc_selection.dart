import 'package:ereader/utils/file_explorer/ebook_metadata.dart';
import 'package:flutter/material.dart';

class DocRow extends StatelessWidget {
  const DocRow({
    required this.docData,
    Key? key,
  }) : super(key: key);
  final EbookMetadata docData;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(
            docData.title,
          ),
          Text(docData.authorList()),
        ],
      ),
    );
  }
}

class DocSelection extends StatelessWidget {
  const DocSelection({
    required this.docRows,
    Key? key,
  }) : super(key: key);
  final List<Widget> docRows;
  // const DocSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: docRows,
    );
  }
}

List<ListTile> buildDocRows(List<EbookMetadata> docList) {
  final docRows = <ListTile>[];
  for (final doc in docList) {
    docRows.add(
      ListTile(
        title: Text('${doc.title}\n${doc.authorList()}'),
        onTap: () {
          print(doc.title);
        },
      ),
    );
  }
  return docRows;
}
