abstract class AuthDataRepository {
  Future<void> signIn(String username, String password);
}