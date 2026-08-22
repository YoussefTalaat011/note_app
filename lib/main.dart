import 'package:flutter/material.dart' ;

import 'package:flutter_bloc/flutter_bloc.dart' ;

import 'package:hive_flutter/hive_flutter.dart' ;

import 'note_model.dart' ;


class HiveDatabaseService

{
  static const String boxName = 'notes_box' ;

  static Future<void> initHive() async
  {

    await Hive.initFlutter() ;
    Hive.registerAdapter( NoteAdapter() ) ;
    await Hive.openBox<Note>( boxName ) ;

  }

  Box<Note> get _box => Hive.box<Note>( boxName ) ;

  Future<void> addNote(Note note) async
  {

    await _box.put( note.id , note ) ;

  }

  List<Note> getAllNotes()
  {

    return _box.values.toList() ;

  }

  List<Note> getFavoriteNotes()
  {

    return _box.values.where( (note) => note.isFavorite ).toList() ;

  }

  Future<void> updateNote(Note note) async
  {

    await _box.put( note.id , note ) ;

  }

  Future<void> deleteNote( String id ) async
  {

    await _box.delete(id) ;

  }


}



abstract class NotesEvent {}


class LoadNotesEvent extends NotesEvent {}
class AddNoteEvent extends NotesEvent
{

  final Note note ;
  AddNoteEvent( this.note ) ;

}

class UpdateNoteEvent extends NotesEvent
{

  final Note note ;
  UpdateNoteEvent( this.note ) ;

}

class DeleteNoteEvent extends NotesEvent
{

  final String id ;
  DeleteNoteEvent( this.id ) ;

}



abstract class NotesState {}


class NotesInitialState extends NotesState {}
class NotesLoadingState extends NotesState {}
class NotesLoadedState extends NotesState
{

  final List<Note> notes ;
  NotesLoadedState( this.notes ) ;

}

class NotesErrorState extends NotesState
{

  final String message ;
  NotesErrorState( this.message ) ;

}

class NotesBloc extends Bloc<NotesEvent, NotesState>
{
  final HiveDatabaseService dbService ;

  NotesBloc( this.dbService ) : super( NotesInitialState() )
  {
    on <LoadNotesEvent>(( event , emit )
    {

      emit ( NotesLoadingState() ) ;
      try
      {
        final notes = dbService.getAllNotes() ;
        emit ( NotesLoadedState ( notes ) ) ;
      }
      catch (e)
      {
        emit ( NotesErrorState ( ' There is an error ' ) ) ;
      }

    } ) ;

    on<AddNoteEvent>(( event , emit ) async
    {

      await dbService.addNote( event.note ) ;
      add( LoadNotesEvent() ) ;

    } ) ;

    on<UpdateNoteEvent>(( event , emit ) async
    {

      await dbService.updateNote( event.note ) ;
      add( LoadNotesEvent ()) ;

    } ) ;

    on<DeleteNoteEvent>(( event , emit ) async
    {

      await dbService.deleteNote( event.id ) ;
      add( LoadNotesEvent() ) ;

    } ) ;
  }
}



void main() async
{

  WidgetsFlutterBinding.ensureInitialized() ;

  await HiveDatabaseService.initHive() ;

  runApp
    (
    BlocProvider
      (
      create: (context) => NotesBloc( HiveDatabaseService() )..add( LoadNotesEvent() ) ,
      child: const MaterialApp
        (
        home: Scaffold
          (
          body: Center
            (
            child: Text(' Hive + BLoC is ready for the team! ') ,
          ) ,
        ) ,
      ) ,
    ) ,
  ) ;

}