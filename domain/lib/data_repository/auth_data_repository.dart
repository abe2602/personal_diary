abstract class AuthDataRepository {
  Future<void> signIn(String password);
  Future<void> signUp(String username, String password);
}