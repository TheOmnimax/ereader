import 'package:ereader/bloc/bloc.dart';
import 'package:ereader/screens/ereader_screen/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EreaderMain extends StatelessWidget {
  const EreaderMain({
    required this.ebookPath,
    Key? key,
  }) : super(key: key);

  final String ebookPath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EreaderBloc() /*..add(LoadBook(ebookPath: ebookPath))*/,
      child: EreaderPage(
        ebookPath: ebookPath,
      ),
    );
  }
}

class EreaderPage extends StatelessWidget {
  const EreaderPage({
    required this.ebookPath,
    Key? key,
  }) : super(key: key);
  final String ebookPath;

  @override
  Widget build(BuildContext context) {
    final appBloc = context.watch<AppBloc>();
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
            body: Builder(builder: (context) {
              final screenHeight = MediaQuery.of(context).size.height;
              final appBarHeight = Scaffold.of(context).appBarMaxHeight;
              context.read<EreaderBloc>().add(LoadBook(
                    ebookPath: ebookPath,
                    widgetHeight: screenHeight - (appBarHeight ?? 0),
                  ));
              return const SafeArea(
                child: Text('Loading...'),
              );
            }),
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

          final ebookProcessed = state.ebookProcessed.parts[0];

          print('On page ${state.position}');
          print(ebookProcessed);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.title,
                style: TextStyle(
                  color: appBloc.state.currentStyle.fontColor,
                ),
              ),
              actions: [],
              backgroundColor: appBloc.state.currentStyle.backgroundColor,
              iconTheme: IconThemeData(
                color: appBloc.state.currentStyle.fontColor,
              ),
            ),
            body: Builder(builder: (context) {
              return SafeArea(
                child: PageView(),
              );
            }),
            // child: Text('Text'),
            // child: PageTurner(
            //   onLeft: onLeft,
            //   onRight: onRight,
            //   child: EbookViewer(
            //     htmlContent: ebookProcessed.parts[state.position],
            //     ereaderStyle: ereaderStyle,
            //   ),
            // ),
          );
        }
        return Text('Unknown state error');
      },
    );
  }
}
