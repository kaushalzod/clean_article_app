abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class StorageFailure extends Failure {
  StorageFailure({required super.errorMessage});
}
