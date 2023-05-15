// API
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

const String API_URL = "http://reqres.in/api";

const String API_USERS_TOTAL = "total";
const String API_USERS_PER_PAGE = "per_page";
const String API_USERS_DATA = "data";
const String API_USERS_PAGE = "page";

const String API_RESOURCES_TOTAL = "total";
const String API_RESOURCES_PER_PAGE = "per_page";
const String API_RESOURCES_DATA = "data";

// User
const String API_USER_ID = "id";
const String API_USER_EMAIL = "email";
const String API_USER_FIRSTNAME = "first_name";
const String API_USER_LASTNAME = "last_name";
const String API_USER_AVATAR = "avatar";
const String USERS_PAGE_INDEX = "pageIndex";

// Resource
const String API_RESOURCE_ID = "id";
const String API_RESOURCE_NAME = "name";
const String API_RESOURCE_COLOR = "color";
const String API_RESOURCE_YEAR = "year";
const String API_RESOURCE_PANTONE_VALUE = "pantone_value";

// App Title
const String APP_TITLE = "SWD Nucleus Tech Team - ReqRes consumer";

// App Themes
final APP_DEFAULT_THEME = ThemeData(
  fontFamily: 'Circular',
  primaryColor: Colors.indigo.shade400,
  cardColor: Colors.grey[200],
  canvasColor: Colors.grey[400],
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
  useMaterial3: true,
);

final APP_DARK_THEME = ThemeData(
  fontFamily: 'Circular',
  primaryColor: Colors.indigo.shade400,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.amber,
    brightness: Brightness.dark,
  ),
  cardColor: Colors.grey[600],
  canvasColor: Colors.blueGrey[700],
  scaffoldBackgroundColor: Colors.grey[700],
  useMaterial3: true,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);
