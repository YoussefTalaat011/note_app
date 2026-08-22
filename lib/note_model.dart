import 'package:hive/hive.dart' ;

part 'note_model.g.dart' ;


@HiveType(typeId: 0)

class Note extends HiveObject

{

  @HiveField(0)
  final String id ;

  @HiveField(1)
  final String title ;

  @HiveField(2)
  final String content ;

  @HiveField(3)
  final String createdAt ;

  @HiveField(4)
  final String updatedAt ;

  @HiveField(5)
  final bool isFavorite ;

  @HiveField(6)
  final int colorIndex ;



  Note
    (
      {
        required this.id ,
        required this.title ,
        required this.content ,
        required this.createdAt ,
        required this.updatedAt ,
        this.isFavorite = false ,
        this.colorIndex = 0 ,
      }
    ) ;



  Note copyWith
    (
      {
        String? id ,
        String? title ,
        String? content ,
        String? createdAt ,
        String? updatedAt ,
        bool? isFavorite ,
        int? colorIndex ,
      }
    )
    {
      return Note
        (
          id: id ?? this.id ,
          title: title ?? this.title ,
          content: content ?? this.content ,
          createdAt: createdAt ?? this.createdAt ,
          updatedAt: updatedAt ?? this.updatedAt ,
          isFavorite: isFavorite ?? this.isFavorite ,
          colorIndex: colorIndex ?? this.colorIndex ,
        ) ;
    }


}