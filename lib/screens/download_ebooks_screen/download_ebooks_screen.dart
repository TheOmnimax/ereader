import 'package:ereader/bloc/bloc.dart';
import 'package:ereader/bloc/ereader_bloc.dart';
import 'package:ereader/screens/download_ebooks_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadEbooksScreen extends StatelessWidget {
  const DownloadEbooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadEbooksBloc(appBloc: context.read<AppBloc>())
        ..add(const GetEbookList()),
      child: const DownloadEbooksMain(),
    );
  }
}

class DownloadEbooksMain extends StatelessWidget {
  const DownloadEbooksMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final downloadBloc = context.read<DownloadEbooksBloc>();

    return BlocBuilder<DownloadEbooksBloc, DownloadEbooksState>(
      builder: (context, blocState) {
        void downloadEbook(String filepath) {
          context.read<DownloadEbooksBloc>().add(
                DownloadEbook(
                  filename: filepath,
                ),
              );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Download'),
          ),
          body: SafeArea(
            child: Builder(
              builder: (state) {
                if (blocState is InitialState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('Loading book list...'),
                      ),
                      bigLoading,
                    ],
                  );
                } else if (blocState is NoLogin) {
                  return const Text(
                    'You are not logged in. Please log in to download eBooks.',
                  );
                } else {
                  final ebookButtons = <EbookButton>[];
                  for (final ebook in blocState.ebookList) {
                    ebookButtons.add(
                      EbookButton(
                        ebookMetadata: ebook,
                        onPressed: () async {
                          final exists =
                              await downloadBloc.fileExists(ebook.filePath);
                          if (exists) {
                            await showPopup(
                              context: context,
                              title: 'eBook already exists',
                              buttons: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    downloadEbook(ebook.filePath);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                              body: const Text(
                                'This file has already been downloaded. Would you like to download it again?',
                              ),
                            );
                          } else {
                            downloadEbook(ebook.filePath);
                          }
                        },
                      ),
                    );
                  } // End FOR
                  return Column(
                    children: [
                      Expanded(child: ListBuilder(widgets: ebookButtons)),
                      Builder(
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(blocState.info),
                                LoadingIcon(
                                  status: blocState.status,
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
