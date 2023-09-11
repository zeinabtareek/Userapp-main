abstract class ILocalAuth<T> {
  Future<bool?> setUser(T user);

  Future<T?> getUser();
  Future<bool> isAuthenticated();
}
