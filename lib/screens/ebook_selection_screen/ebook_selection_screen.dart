import 'package:ereader/file_explorer/ebook_storage.dart';
import 'package:ereader/screens/ebook_selection_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/main_scaffold.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/shared_widgets/list_builder.dart';
import 'package:ereader/file_explorer/ebook_metadata.dart';

// TODO: Integrate with bloc using BlocBuilder

class EbookSelectionMain extends StatelessWidget {
  const EbookSelectionMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EbookSelectionBloc()..add(const LoadPage()),
      child: const SelectionPage(),
    );
  }
}

class SelectionPage extends StatelessWidget {
  const SelectionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void kebabFunction(String value) {
      switch (value) {
        case 'eReader style':
          {
            Navigator.pushNamed(context, '/style_selection');
            break;
          }
        case 'Add eBook':
          {
            context.read<EbookSelectionBloc>().add(const GetNewEbook());
          }
      }
    }

    List<Widget> createEbookWidgetList(List<EbookMetadata> ebookMetadataList) {
      final ebookWidgetList = <Widget>[];

      for (final ebookMetadata in ebookMetadataList) {
        ebookWidgetList.add(EbookListItem(
          ebookMetadata: ebookMetadata,
        ));
      }

      return ebookWidgetList;
    }

    return MainScaffold(
      popupMenuButton: PopupMenuButton<String>(
        onSelected: kebabFunction,
        itemBuilder: (BuildContext context) {
          return {'eReader style', 'Add eBook'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
      // child: Image(
      //   image: AssetImage('assets/media/default_cover.png'),
      // ),
      child: BlocBuilder<EbookSelectionBloc, EbookSelectionState>(
        builder: (context, state) {
          if (state is EbookSelectionLoading) {
            return Text('Loading...');
          }

          return ListBuilder(
            widgets: createEbookWidgetList(
              state.ebookList,
            ),
          );
        },
      ),
    );
  }
}

class EbookListItem extends StatelessWidget {
  const EbookListItem({
    required this.ebookMetadata,
  });

  final EbookMetadata ebookMetadata;

  @override
  Widget build(BuildContext context) {
    return ListItem(
      mainButton: Column(
        children: <Widget>[
          Text(ebookMetadata.title),
          Text(ebookMetadata.author),
        ],
      ),
      kebabFunction: (selectedItem) {},
      itemList: const <String>[],
    );
  }
}
