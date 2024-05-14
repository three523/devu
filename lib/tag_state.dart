import 'package:devu_app/data/model/tag.dart';

sealed class TagState {}

class TaginitState extends TagState {
  final List<Tag> tagList;
  TaginitState(this.tagList);
}

class TagSucessState extends TagState {
  final List<Tag> tagList;
  TagSucessState(this.tagList);
}

class TagLoadingState extends TagState {}

class TagErrorState extends TagState {
  final String error;
  TagErrorState(this.error);
}
