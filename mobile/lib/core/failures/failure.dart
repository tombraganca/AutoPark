class Failure implements Exception {
  final String msg;
  final StackTrace? stackTrace;
  Failure(this.msg, [this.stackTrace]);
}
