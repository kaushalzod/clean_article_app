abstract class Failure implements Exception {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class StorageFailure extends Failure {
  StorageFailure({required super.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
}
