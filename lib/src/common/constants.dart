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

// Routes
const String ROUTE_HOME = "/";
const String ROUTE_LOGIN = "/login";
const String ROUTE_USERS = "/users";
const String ROUTE_RESOURCES = "/resources";
const String ROUTE_ABOUT = "/about";

const String APP_NAME = "ReqRes Consumer";
const String USERS_TAB = "Users";
const String RESOURCES_TAB = "Resources";

const String ABOUT_TOOLTIP = "About";
const String LOGOUT_TOOLTIP = "Logout";
const String OK_BUTTON = "OK";
const String ERROR_BUTTON = "Error";

const String USERS_ERROR_TEXT = "An Error Occured. Please try again.";
const String USERS_REFRESH_TEXT = "Refresh";
const String USERS_NOT_FOUND = "No more Users found.";

const String LOGIN_TEXT = "Login";
const String REGISTER_TEXT = "Register";
const String EMAIL_TEXT = "Email";
const String PASSWORD_TEXT = "Password";
const String PASSWORD_TOO_SHORT = "Password too short.";
const String PASSWORD_EMPTY = "Empty Password.";

const String GOOGLE_LOGO_ASSET = "assets/google-logo.png";
const String ABOUT_ME_ASSET = "assets/about-img.png";
const String SIGN_IN_WITH_GOOGLE = "Sign In with Google";
const String CONTINUE_WITH_GOOGLE = "Continue with Google";
const ABOUT_ME_TEXT =
    """ Hello! I am Aman Ranjan, a first-year student pursuing CSE at BITS Pilani, Hyderabad Campus. I hail from Patna, Bihar but currently live in Navi Mumbai, Maharashtra. I am keenly interested in programming, music, and in general, learning new things. Solving puzzles is also an occasional pastime for me. """;

const APP_NOTIFICATION_CHANNEL_KEY = "req_res_consumer_app";
const APP_NOTIFICATION_CHANNEL_GROUP_KEY = "req_res_consumer_app_group";
const APP_NOTIFICATION_CHANNEL_GROUP_NAME = "ReqRes Consumer";
const APP_NOTIFICATION_CHANNEL_NAME = "ReqRes Consumer Notifications";
const APP_NOTIFICATION_CHANNEL_DESCRIPTION =
    "Displays notifications for the ReqRes Consumer app";

final userInfoThemes = {
  1: [
    Colors.blue.shade700,
    Colors.indigo.shade200,
  ],
  2: [
    Colors.pink.shade400,
    Colors.amber.shade300,
  ],
  3: [
    Colors.blue,
    Colors.teal.shade400,
  ],
  0: [
    Colors.blue.shade400,
    Colors.green.shade800,
  ],
};
