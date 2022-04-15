import 'package:ereader/constants/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

const bigLoading = SpinKitDualRing(
  color: themeColor,
);

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({
    required this.status,
    Key? key,
  }) : super(key: key);

  final LoadingStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == LoadingStatus.working) {
      return const SpinKitDualRing(
        color: themeColor,
        size: 10,
      );
    } else if (status == LoadingStatus.ready) {
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    } else if (status == LoadingStatus.error) {
      return const Icon(
        Icons.error,
        color: Colors.red,
      );
    } else if (status == LoadingStatus.warning) {
      return const Icon(
        Icons.warning,
        color: Colors.orange,
      );
    } else {
      return Container();
    }
  }
}
