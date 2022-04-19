import 'package:ereader/bloc/bloc.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/download_ebooks_screen/bloc/bloc.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';
import 'package:ereader/screens/ebook_selection_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ereader_screen/ereader_screen.dart';

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

// TODO: Set to add event LoadPage() whenever screen on top is popped
// TODO: Fix opener of book

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
        // TODO: Update this to work better now that this is a list
        ebookMetadataList
            .sort((a, b) => a.authorList().compareTo(b.authorList()));
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

    final appBloc = context.watch<AppBloc>();
    return BlocBuilder<EbookSelectionBloc, EbookSelectionState>(
        builder: (context, state) {
      print('Username: ${appBloc.state.username}');
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
              LoginTile(
                username: appBloc.state.username,
                logout: () async {
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
                          context.read<AppBloc>().add(Logout());
                        },
                        child: const Text('Log out'),
                      ),
                    ],
                    body: Text(
                      'Are you sure you would like to log out?',
                    ),
                  );
                },
                login: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/download');
                },
                child: const Text('Download'),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('eReader'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  context.read<EbookSelectionBloc>().add(const LoadPage());
                },
                icon: const Icon(
                  Icons.sync,
                )),
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
            Text(ebookMetadata.authorList()),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => EreaderMain(
                ebookPath: ebookMetadata.filePath,
              ),
            ),
          );
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

class LoginTile extends StatelessWidget {
  const LoginTile({
    Key? key,
    this.username = '',
    required this.login,
    required this.logout,
  }) : super(key: key);

  final String username;
  final Function() login;
  final Function() logout;

  @override
  Widget build(BuildContext context) {
    if (username == '') {
      return ListTile(
        title: const Text('Log in'),
        onTap: login,
      );
    } else {
      return ListTile(
        title: Text(username),
        trailing: TextButton(
          onPressed: logout,
          child: const Text('Log out'),
        ),
      );
    }
  }
}
