enum LoadingStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isLoading =>
      this == LoadingStatus.initial || this == LoadingStatus.loading;
  bool get isError => this == LoadingStatus.error;
  bool get isLoaded => this == LoadingStatus.loaded;
}

enum NetworkStatus {
  online,
  offline;

  bool get isOnline => this == NetworkStatus.online;
  bool get isOffline => this == NetworkStatus.offline;
}
