class RouteNameBuilder {
  static const rootPath = '/';
  static const homePath = 'homePath';
  static const signUpPath = 'signUp';
  static const signInPath = 'signIn';
  static const postListPath = 'postList';

  static String signIn() => signUpPath;

  static String signUp() => signUpPath;

  static String root() => rootPath;

  static String postList() => postListPath;

  static String home() => homePath;
}
