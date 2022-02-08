import 'package:ereader/screens/ereader_screen/bloc/bloc.dart';
import 'package:ereader/screens/ereader_screen/ereader_widgets/ebook_viewer.dart';
import 'package:ereader/screens/ereader_screen/ereader_widgets/page_turner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EreaderMain extends StatelessWidget {
  const EreaderMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context);
    final arguments = modalRoute == null
        ? <String, dynamic>{}
        : modalRoute.settings.arguments as Map;

    final ebookPath = arguments['path'] as String;
    return BlocProvider(
      create: (_) => EreaderBloc()..add(LoadBook(ebookPath: ebookPath)),
      child: const EreaderPage(),
    );
  }
}

class EreaderPage extends StatelessWidget {
  const EreaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EreaderBloc, EreaderState>(
      builder: (context, state) {
        if (state is EbookLoading) {
          print('Loading page...');
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
              actions: [],
              backgroundColor: Colors.black,
            ),
            body: const SafeArea(
              child: Text('Loading...'),
            ),
          );
        } else if (state is EbookDisplay) {
          print('State is display');
          void onLeft() {
            context.read<EreaderBloc>().add(
                  TurnPage(
                    toPage: state.position - 1,
                  ),
                );
          }

          void onRight() {
            context.read<EreaderBloc>().add(
                  TurnPage(
                    toPage: state.position + 1,
                  ),
                );
          }

          final ereaderStyle = state.ereaderStyle;

          final ebookProcessed = state.ebookProcessed;

          print('On page ${state.position}');
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.title,
                style: TextStyle(color: ereaderStyle.fontColor),
              ),
              actions: [],
              backgroundColor: ereaderStyle.backgroundColor,
              iconTheme: IconThemeData(
                color: ereaderStyle.fontColor,
              ),
            ),
            body: SafeArea(
              // child: Text('Text'),
              child: PageTurner(
                onLeft: onLeft,
                onRight: onRight,
                child: EbookViewer(
                  htmlContent: ebookProcessed.parts[state.position],
                  ereaderStyle: ereaderStyle,
                ),
              ),
            ),
          );
        }
        return Text('Unknown state error');
      },
    );
  }
}
