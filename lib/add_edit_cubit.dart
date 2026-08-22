import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AddEditState {}

class AddEditIntial extends AddEditState {}

class AddEditError extends AddEditState {
  final String message;
  AddEditError(this.message);
}

class AddEditSuccess extends AddEditState {
  final Map<String, String> noteData;
  AddEditSuccess(this.noteData);
}

class AddEditCubit extends Cubit<AddEditState> {
  AddEditCubit() : super(AddEditIntial());

  void saveNote(String title, String content) {
    if (title.trim().isEmpty) {
      emit(AddEditError("Title cannot be empty"));
      return;
    }

    emit(AddEditSuccess({'title': title.trim(), 'content': content.trim()}));
  }
}
