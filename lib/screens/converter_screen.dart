// Copyright 2010-2023 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
// import 'dart:ui' as ui;
// import 'dart:html' as html;

import '../common/ui_strings.dart';
// import '../services/portmark_converter.dart';
import '../widgets/main_button.dart';
import '../widgets/card_with_header.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  late TextEditingController _controller;

  // late html.TextAreaElement _textArea;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    // _textArea = html.TextAreaElement()
    //   ..wrap = 'off'
    //   ..style.width = '100%'
    //   ..style.height = '100%';

    // ui.platformViewRegistry.registerViewFactory(
    //   'textarea',
    //   (int viewId) {
    //     return _textArea;
    //   },
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onConvertPressed() {
    // convertUrlsToPortmarks(_controller.text);
    // print(_textArea.value);
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
            onPressed: () {},
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
    // return SizedBox(
    //   width: MediaQuery.of(context).size.width,
    //   height: 300,
    //   child: const HtmlElementView(viewType: "textarea"),
    // );
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
