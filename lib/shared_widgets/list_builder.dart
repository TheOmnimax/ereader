import 'package:ereader/constants/constants.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';
import 'package:flutter/material.dart';

// Takes a list of widgets, and creates a scrollable widget
class ListBuilder extends StatelessWidget {
  const ListBuilder(
      {required this.widgets, this.missingWarning = 'None found!'});

  final List<Widget> widgets;
  final String missingWarning;

  @override
  Widget build(BuildContext context) {
    print('There are ${widgets.length} widgets');

    if (widgets.length == 0) {
      return Text(missingWarning);
    }
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      // padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return widgets[index];
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Color(0xffc4c4c4),
        height: 8,
        thickness: 2,
      ),
      itemCount: widgets.length,
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    required this.mainButton,
    required this.kebabFunction,
    required this.itemList,
    this.backgroundColor = Colors.white,
    this.kebabColor = Colors.black,
  });

  final Widget mainButton;
  final Color backgroundColor;
  final Function(String) kebabFunction;
  final List<String> itemList;
  final Color kebabColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: mainButton,
          ),
          PopupMenu(
            color: kebabColor,
            onSelected: kebabFunction,
            itemList: itemList,
          ),
        ],
      ),
    );
  }
}

class EbookButton extends StatelessWidget {
  const EbookButton({
    Key? key,
    required this.ebookMetadata,
    required this.onPressed,
  }) : super(key: key);

  final EbookMetadata ebookMetadata;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        primary: Colors.black,
      ),
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(ebookMetadata.title),
          Text(ebookMetadata.authors.toString()),
        ],
      ),
    );
  }
}

// class EbookListItem extends StatelessWidget {
//   const EbookListItem({
//     Key? key,
//     required this.ebookMetadata,
//   }) : super(key: key);
//
//   final EbookMetadata ebookMetadata;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListItem(
//       mainButton: TextButton(
//         style: TextButton.styleFrom(
//           alignment: Alignment.centerLeft,
//           primary: Colors.black,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(ebookMetadata.title),
//             Text(ebookMetadata.author),
//           ],
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute<void>(
//               builder: (context) => EreaderMain(
//                 ebookPath: ebookMetadata.filePath,
//               ),
//             ),
//           );
//         },
//       ),
//       kebabFunction: (selectedItem) async {
//         switch (selectedItem) {
//           case 'Delete':
//             {
//               await showPopup(
//                 context: context,
//                 title: 'Delete eBook',
//                 body: Text('Are you sure you would like to delete this eBook?'),
//                 buttons: <Widget>[
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text('Keep'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       context.read<EbookSelectionBloc>().add(DeleteEbook(
//                             deletePath: ebookMetadata.filePath,
//                           ));
//                     },
//                     child: const Text('Delete'),
//                   ),
//                 ],
//               );
//             }
//         }
//       },
//       itemList: const <String>['Delete'],
//     );
//   }
// }

class EbookSorter {
  const EbookSorter({required this.ebookMetadataList});

  final List<EbookMetadata> ebookMetadataList;

  List<Widget> getWidgetList(SortType sort, Direction direction) {
    final ebookWidgetList = <Widget>[];

    if (sort == SortType.author) {
      // TODO: Update this to work better now that this is a list
      ebookMetadataList
          .sort((a, b) => a.authors.toString().compareTo(b.authors.toString()));
    } else if (sort == SortType.title) {
      ebookMetadataList.sort((a, b) => a.title.compareTo(b.title));
    }

    final List<EbookMetadata> returnList;
    if (direction == Direction.up) {
      returnList = ebookMetadataList.reversed.toList();
    } else {
      returnList = ebookMetadataList;
    }

    // for (final ebookMetadata in returnList) {
    //   ebookWidgetList.add(EbookListItem(
    //     ebookMetadata: ebookMetadata,
    //   ));
    // }

    return ebookWidgetList;
  }
}
