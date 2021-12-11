import 'dart:async';

class Validators {

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
          sink.add(email);
        } else {
          sink.addError('Enter a valid email');
        }
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length > 3) {
          sink.add(password);
        } else {
          sink.addError('Password must be at least 4 characters');
        }
      }
  );

  final validateName = StreamTransformer<String, String>.fromHandlers(
      handleData: (name, sink) {
        if (name.length > 2) {
          sink.add(name);
        } else {
          sink.addError('Name must be at least 3 characters');
        }
      }
  );

  final validateDescription = StreamTransformer<String, String>.fromHandlers(
    handleData: (description, sink) {
      if (description.length > 9) {
        sink.add(description);
      } else {
        sink.addError('Description must be at least 10 characters');
      }
    }
  );
}