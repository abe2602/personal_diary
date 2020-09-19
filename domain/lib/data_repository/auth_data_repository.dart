abstract class AuthDataRepository {
  Future<String> getUserName();
  Future<void> signIn(String password);
  Future<void> signUp(String username, String password);
}