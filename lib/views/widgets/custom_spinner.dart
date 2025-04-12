import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afyaai/utils/constants.dart';

final spinkit = SpinKitWave(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(decoration: BoxDecoration(color: kWhite));
  },
);