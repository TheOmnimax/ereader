import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ereader/bloc/ereader_bloc.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';
import 'package:ereader/utils/file_explorer/files.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'bloc.dart';

class DownloadEbooksBloc
    extends Bloc<DownloadEbooksEvent, DownloadEbooksState> {
  DownloadEbooksBloc({required this.appBloc}) : super(const InitialState()) {
    on<GetEbookList>(_loadEbookList);
    on<DownloadEbook>(_downloadEbook);
  }

  final AppBloc appBloc;
  final fileReadWrite = const FileReadWrite(relativePath: 'ebooks');

  Future<bool> fileExists(String filename) async {
    final exists = await fileReadWrite.exists(filename: filename);
    return exists;
  }

  Future<String> _getEbookList(String auth) async {
    final uri = Uri.parse('https://ereader-341202.uc.r.appspot.com/list-all');

    if (auth == '') {
    } else {}

    final headers = {
      HttpHeaders.authorizationHeader: auth,
    };

    final response = await http.post(
      uri,
      headers: headers,
    );

    final statusCode = response.statusCode;
    final responseBodyRaw = response.body;

    print('Body:');
    print(responseBodyRaw);

    return responseBodyRaw;

    // if (statusCode == 200) {
    //   final responseBodyDynamicList = jsonDecode(responseBodyRaw) as List;
    //   final responseBody = <Map<String, dynamic>>[];
    //   print(responseBodyDynamicList);
    //
    //   return responseBodyDynamicList;
    // } else {
    //   return <Map<String, dynamic>>[];
    // }
  }

  Future _loadEbookList(
      GetEbookList event, Emitter<DownloadEbooksState> emit) async {
    final auth = await appBloc.authToken;
    if (auth == '') {
      emit(const NoLogin());
    } else {
      final ebookDictListRaw = await _getEbookList(auth);
      final ebookDictList = json.decode(ebookDictListRaw) as List;
      final ebookList = <EbookMetadata>[];

      for (final ebookData in ebookDictList) {
        final ebookDict = ebookData as Map<String, dynamic>;
        ebookList.add(await EbookMetadata.fromServerJson(ebookDict));
      }

      emit(ListBooks(ebookList: ebookList));
    }
  }

  Future _downloadEbook(
      DownloadEbook event, Emitter<DownloadEbooksState> emit) async {
    emit(state.copyWith(
      status: LoadingStatus.working,
      info: 'Downloading...',
    ));
    final auth = await appBloc.authToken;

    final uri =
        Uri.parse('https://ereader-341202.uc.r.appspot.com/download-ebook');

    final headers = {
      HttpHeaders.authorizationHeader: auth,
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: event.filename,
    );

    final statusCode = response.statusCode;
    final responseBodyRaw = response.body;

    if (statusCode >= 400) {
      emit(state.copyWith(
        status: LoadingStatus.error,
        info: '$statusCode error',
      ));
      return;
    }

    final codeUnits = responseBodyRaw.codeUnits;
    final successAdd = await fileReadWrite.addFileByName(event.filename);
    final successCreate = await fileReadWrite.writeBytes(
      filename: event.filename,
      contents: codeUnits,
    );
    emit(state.copyWith(
      status: LoadingStatus.ready,
      info: 'Complete!',
    ));
  }
}
