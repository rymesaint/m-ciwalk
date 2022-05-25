class Resource<T> {
  T? data;
  Error? error;
  Metadata? metadata;

  Resource({
    this.data,
    this.metadata,
    this.error,
  });
}

class Error {
  String? message;
  Map<String, dynamic>? extensions;

  Error({this.message, this.extensions});
}

class Metadata {
  int? count;
  int? totalCount;

  Metadata({this.count, this.totalCount});
}
