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
    final appBloc = context.watch<AppBloc>();

    return BlocBuilder<DownloadEbooksBloc, DownloadEbooksState>(
        builder: (context, blocState) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Download'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Builder(builder: (state) {
                if (blocState is ListBooks) {
                  final ebookButtons = <EbookButton>[];
                  for (final ebook in blocState.ebookList) {
                    ebookButtons.add(
                        EbookButton(ebookMetadata: ebook, onPressed: () {}));
                  }

                  return ListBuilder(widgets: ebookButtons);
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      );
    });
  }
}
