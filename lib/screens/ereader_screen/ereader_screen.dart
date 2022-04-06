import 'package:clipboard/clipboard.dart';
import 'package:ereader/screens/ereader_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/show_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class EreaderMain extends StatelessWidget {
  const EreaderMain({
    Key? key,
    required this.ebookPath,
  }) : super(key: key);

  final String ebookPath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EreaderBloc(),
      child: EreaderScreen(
        ebookPath: ebookPath,
      ),
    );
  }
}

class EreaderScreen extends StatelessWidget {
  const EreaderScreen({
    Key? key,
    required this.ebookPath,
  }) : super(key: key);

  final String ebookPath;

  @override
  Widget build(BuildContext context) {
    OverlayEntry? currentOverlay;

    // Create a text overlay for options on what to do with selected text.
    void textSelected({
      required TextSelection selection,
      SelectionChangedCause? cause, // Currently not used
      required String plainText,
      required int contentLength,
      double? appBarHeight = 0,
      required Size screenSize,
    }) {
      appBarHeight = appBarHeight ?? 0;
      final selectionStart = selection.start;
      final selectedText = plainText.substring(selectionStart, selection.end);
      print(selectedText);
      // https://medium.com/flutter/how-to-float-an-overlay-widget-over-a-possibly-transformed-ui-widget-1d15ca7667b6
      if (selectedText == '') {
        if (currentOverlay?.mounted ?? false) {
          currentOverlay?.remove();
        }
      } else {
        if (currentOverlay?.mounted ?? false) {
          currentOverlay?.remove();
        }

        final double overlayTop;
        if (selectionStart / contentLength < 0.33) {
          overlayTop = appBarHeight + 15 + (screenSize.height / 2);
        } else {
          overlayTop = appBarHeight + 15;
        }

        print('Working...');
        currentOverlay = overlayPopup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                selectedText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              LaunchButton(
                title: 'Wikipedia',
                url: 'https://en.wikipedia.org/wiki/' + selectedText,
              ),
              TextButton(
                onPressed: () {
                  FlutterClipboard.copy(selectedText);
                },
                child: Text('Copy'),
              )
            ],
          ),
          screenWidth: screenSize.width,
          top: overlayTop,
        );
        Overlay.of(context)?.insert(currentOverlay!);
      } // End overlay being created
    } // End function to create text overlay

    return BlocBuilder<EreaderBloc, EreaderState>(
      builder: (context, state) {
        final pages = state.pages;
        final pageNum = state.pageNum;
        print('There are ${pages.length} pages');
        print('It is on page $pageNum');
        TextStyle textStyle = TextStyle(
          color: Colors.black,
          height: 2,
        );
        final screenSize = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(),
          body: Builder(
            builder: (BuildContext context) {
              final appBarHeight = Scaffold.of(context).appBarMaxHeight;
              print('Adding...');
              if (state is EbookLoading) {
                context.read<EreaderBloc>().add(
                      LoadBook(
                        workingHeight: screenSize.height - (appBarHeight ?? 0),
                        workingWidth: screenSize.width,
                        style: textStyle,
                      ),
                    );
                return Text('Loading...');
              } else {
                if (pages.length == 0) {
                  return SafeArea(child: Text('Nothin\'!'));
                } else {
                  return SafeArea(
                    child: PageView.builder(itemBuilder: (context, index) {
                      final page = pages[index];
                      final pageContent = page.content;
                      final plainText = pageContent.toPlainText();
                      final contentLength = plainText.length;
                      return SelectableText.rich(
                        pageContent,
                        style: textStyle,
                        onSelectionChanged: (selection, cause) {
                          textSelected(
                            selection: selection,
                            plainText: plainText,
                            contentLength: contentLength,
                            appBarHeight: appBarHeight,
                            screenSize: screenSize,
                          );
                        }, // End function when text is selected
                        toolbarOptions: ToolbarOptions(
                          copy: false,
                          selectAll: false,
                        ),
                      );
                    }),
                  );
                }
              }
            },
          ),
        );

        // print(state.content);
      },
    );
  }
}

class LaunchButton extends StatelessWidget {
  const LaunchButton({
    required this.title,
    required this.url,
    Key? key,
  }) : super(key: key);

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await launch(url);
      },
      child: Text(title),
    );
  }
}
