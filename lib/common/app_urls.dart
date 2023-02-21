// Copyright 2010-2023 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

/// URLs used in the app.
class AppUrls {
  AppUrls._();

  static const String _appId = 'portmarks';
  static const String _editionId = 'web';

  static const String support =
      'https://www.aurelitec.com/support/?utm_source=$_appId&utm_medium=app&utm_campaign=${_appId}_${_editionId}_drawer';

  static const String help =
      'https://www.aurelitec.com/$_appId/?utm_source=$_appId&utm_medium=app&utm_campaign=${_appId}_${_editionId}_appbar';

  static const String viewSource = 'https://github.com/aurelitec/portmarks';
}
