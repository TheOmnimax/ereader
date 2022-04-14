import 'package:ereader/bloc/bloc.dart';
import 'package:ereader/bloc/ereader_bloc.dart';
import 'package:ereader/constants/constants.dart';
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
    final appBloc = context.watch<AppBloc>();

    return BlocBuilder<DownloadEbooksBloc, DownloadEbooksState>(
        builder: (context, blocState) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Download'),
        ),
        body: SafeArea(
          child: Builder(builder: (state) {
            if (blocState is InitialState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Loading book list...'),
                  ),
                  bigLoading,
                ],
              );
            } else {
              final ebookButtons = <EbookButton>[];
              for (final ebook in blocState.ebookList) {
                ebookButtons.add(
                  EbookButton(
                      ebookMetadata: ebook,
                      onPressed: () {
                        context.read<DownloadEbooksBloc>().add(
                              DownloadEbook(
                                filename: ebook.filePath,
                              ),
                            );
                      }),
                );
              } // End FOR
              return Column(
                children: [
                  Expanded(child: ListBuilder(widgets: ebookButtons)),
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
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
                  })
                ],
              );
            }
          }),
        ),
      );
    });
  }
}
