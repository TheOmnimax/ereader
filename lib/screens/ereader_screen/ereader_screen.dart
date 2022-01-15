import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/screens/ereader_screen/bloc/bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

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
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
              actions: [],
              backgroundColor: Colors.black,
            ),
            body: SafeArea(
              child: Text('Loading...'),
            ),
          );
        } else if (state is EbookDisplay) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.title,
                style: TextStyle(color: state.ereaderStyle.fontColor),
              ),
              actions: [],
              backgroundColor: state.ereaderStyle.backgroundColor,
              iconTheme: IconThemeData(
                color: state.ereaderStyle.fontColor, //change your color here
              ),
            ),
            body: SafeArea(
              // child: Text('Text'),
              child: Container(
                color: state.ereaderStyle.backgroundColor,
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    state.content,
                    textStyle: TextStyle(
                      color: state.ereaderStyle.fontColor,
                    ),
                  ),
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
