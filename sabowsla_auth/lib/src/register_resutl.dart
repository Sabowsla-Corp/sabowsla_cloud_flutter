enum RegisterResult { success, alreadyExists, failure, unknown }

extension RegisterResultExtension on String {
  RegisterResult? toRegisterResult() {
    switch (this) {
      case 'success':
        return RegisterResult.success;
      case 'email-already-in-use':
        return RegisterResult.alreadyExists;
      case 'failure':
        return RegisterResult.failure;
      default:
        return null;
    }
  }
}
