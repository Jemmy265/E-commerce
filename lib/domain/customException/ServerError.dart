class ServerError implements Exception {
  String? errorMessage;
  String? statusMsg;
  int? httpResponseCode;

  ServerError({this.errorMessage, this.statusMsg, this.httpResponseCode});
}