import 'package:ereader/constants/constants.dart';
import 'package:ereader/file_explorer/ebook_metadata.dart';
import 'package:ereader/screens/ebook_selection_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    List<Widget> createEbookWidgetList(
      List<EbookMetadata> ebookMetadataList, {
      SortType sort = SortType.author,
      Direction direction = Direction.down,
    }) {
      final ebookWidgetList = <Widget>[];

      if (sort == SortType.author) {
        ebookMetadataList.sort((a, b) => a.author.compareTo(b.author));
      } else if (sort == SortType.title) {
        ebookMetadataList.sort((a, b) => a.title.compareTo(b.title));
      }

      if (direction == Direction.up) {
        ebookMetadataList = ebookMetadataList.reversed.toList();
      }

      for (final ebookMetadata in ebookMetadataList) {
        ebookWidgetList.add(EbookListItem(
          ebookMetadata: ebookMetadata,
        ));
      }

      return ebookWidgetList;
    }

    return BlocBuilder<EbookSelectionBloc, EbookSelectionState>(
        builder: (context, state) {
      // TODO: Can I do this, or should it be a class?
      ListTile getLoginTile() {
        if ((state is EbookSelectionMainState) && (state.username != '')) {
          return ListTile(
            title: Text(state.username),
            trailing: TextButton(
              child: Text('Log out'),
              onPressed: () async {
                await showPopup(
                  context: context,
                  title: 'Log out',
                  buttons: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Stay'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // TODO: Is there a shorthand for this? I do it a lot.
                        context.read<EbookSelectionBloc>().add(const LogOut());
                      },
                      child: const Text('Log out'),
                    ),
                  ],
                  body: Text(
                    'Are you sure you would like to log out?',
                  ),
                );
              },
            ),
          );
        }

        return ListTile(
          title: Text('Log in'),
          onTap: () {
            Navigator.pushNamed(context, '/login').then((value) {
              context.read<EbookSelectionBloc>().add(const LoadPage());
            });
          },
        );
      }

      Widget getSafeArea() {
        if (state is EbookSelectionLoading) {
          return Text('Loading');
        } else {
          return ListBuilder(
            widgets: createEbookWidgetList(
              state.ebookList,
            ),
          );
        }
      }

      return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              getLoginTile(),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('eReader'),
          actions: <Widget>[
            PopupMenuButton<String>(
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
          ],
        ),
        body: SafeArea(
          child: getSafeArea(),
        ),
      );
    });
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
      mainButton: TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          primary: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(ebookMetadata.title),
            Text(ebookMetadata.author),
          ],
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/ereader', arguments: <String, dynamic>{
            'path': ebookMetadata.filePath,
          });
        },
      ),
      kebabFunction: (selectedItem) async {
        switch (selectedItem) {
          case 'Delete':
            {
              await showPopup(
                context: context,
                title: 'Delete eBook',
                body: Text('Are you sure you would like to delete this eBook?'),
                buttons: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Keep'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<EbookSelectionBloc>().add(DeleteEbook(
                            deletePath: ebookMetadata.filePath,
                          ));
                    },
                    child: const Text('Delete'),
                  ),
                ],
              );
            }
        }
      },
      itemList: const <String>['Delete'],
    );
  }
}
