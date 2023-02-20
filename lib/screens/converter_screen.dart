// Copyright 2010-2023 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'package:flutter/material.dart';

import '../../utils/utils.dart' as utils;
import '../common/app_urls.dart';
import '../common/ui_strings.dart';
import '../services/portmark_converter.dart';
import '../widgets/card_with_header.dart';
import '../widgets/main_button.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onConvertPressed() {
    final List<String> urls = const LineSplitter().convert(_controller.text);
    portmarkUrls(urls);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          textColor: Colors.white60,
          title: Text(
            UIStrings.conv_screenTitle,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: const Text(UIStrings.conv_screenSubtitle),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              utils.launchUrlExternal(context, AppUrls.help);
            },
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: _buildUrlsToConvert(size),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: MainButton(
          icon: const Icon(Icons.file_download),
          label: const Text(UIStrings.conv_convertButton),
          onPressed: _onConvertPressed,
        ),
      ),
    );
  }

  Widget _buildUrlsToConvert(Size size) {
    return CardWithHeader(
      title: UIStrings.conv_urlsCardTitle,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          stepWidth: size.width,
          child: TextField(
            controller: _controller,
            maxLines: null,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: UIStrings.conv_enterUrlsHint,
            ),
          ),
        ),
      ),
    );
  }
}
