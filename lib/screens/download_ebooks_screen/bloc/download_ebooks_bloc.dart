import 'dart:convert';
import 'dart:io';
import 'package:ereader/bloc/ereader_bloc.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';
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

  Future<String> _getEbookList(String auth) async {
    final uri = Uri.parse('https://ereader-341202.uc.r.appspot.com/list-all');

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
    } else {
      final ebookDictListRaw = await _getEbookList(auth);
      final ebookDictList = json.decode(ebookDictListRaw) as List;
      final ebookList = <EbookMetadata>[];
      // final data = EbookMetadataJsonList.fromJson(ebookDictList);
      // print(data);

      for (final ebookData in ebookDictList) {
        final ebookDict = ebookData as Map<String, dynamic>;
        // ebookDict['authors'] = ebookDict['authors'] as List<String>;
        ebookList.add(await EbookMetadata.fromServerJson(ebookDict));
      }

      emit(ListBooks(ebookList: ebookList));
    }
  }

  Future _downloadEbook(
      DownloadEbook event, Emitter<DownloadEbooksState> emit) async {}
}
