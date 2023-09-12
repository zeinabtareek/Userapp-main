abstract class ILocalAuth<T> {
  Future<bool?> setUser(T? user);

  Future<T?> getUser();
  Future<bool> isAuthenticated();
}




abstract class ISecureLocalAuth<T> {
  Future<void> saveAuthUserData(T? user);

  Future<T?> getAuthUserData();
  Future<bool> isContainsAuthUserData();
}
