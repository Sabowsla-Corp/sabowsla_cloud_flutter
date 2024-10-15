enum AuthApiRoutes {
  login("login", "/api/v1/auth/login"),
  register("register", "/api/v1/auth/register"),
  deleteUser("deleteUser", "/api/v1/auth/delete"),
  forgotPassword("forgotPassword", "/api/v1/auth/forgotPassword"),
  confirmPasswordReset(
      "confirmPasswordReset", "/api/v1/auth/confirmPasswordReset"),
  confirmEmail("confirmEmail", "/api/v1/auth/confirmEmail"),
  getIdToken("getIdToken", "/api/v1/auth/getIdToken");

  final String route;
  final String name;
  const AuthApiRoutes(this.name, this.route);
}
