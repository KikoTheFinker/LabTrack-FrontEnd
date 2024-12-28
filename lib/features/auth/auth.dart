import '../../core/utils/constants.dart';
import 'models/user.dart';

export 'models/user.dart';
export 'presentation/login_screen.dart';
export '../../state/auth_provider.dart';

class AuthService {
  static User? authenticateUser(String username, String password) {
    for (var user in users) {
      if (user.username == username && user.password == password) {
        return user;
      }
    }
    return null;
  }
}

