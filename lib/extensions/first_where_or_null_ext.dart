extension FirstWhereOrNullExt<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }

  T? get firstElementOrNull {
    try {
      return first;
    } catch (e) {
      return null;
    }
  }
}
