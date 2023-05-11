class APIException {
  final String error;

  APIException(this.error);

  @override
  String toString() => "APIException: $error";
}
