import 'package:flutter/material.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';

class DocRow extends StatelessWidget {
  final EbookMetadata docData;

  DocRow({required this.docData});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.black,
      //   ),
      // ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              docData.title,
            ),
            Text(docData.authors.toString()),
          ],
        ),
      ),
    );
  }
}

class DocSelection extends StatelessWidget {
  final List<Widget> docRows;
  DocSelection({required this.docRows});
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
  List<ListTile> docRows = [];
  for (EbookMetadata doc in docList) {
    docRows.add(
      ListTile(
        title: Text('${doc.title}\n${doc.authors.toString()}'),
        onTap: () {
          print('${doc.title}');
        },
      ),
    );
  }
  return docRows;
}
