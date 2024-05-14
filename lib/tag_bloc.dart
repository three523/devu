import 'package:devu_app/data/repository/tag_repository.dart';
import 'package:devu_app/tag_event.dart';
import 'package:devu_app/tag_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  final TagRepository _tagRepository;

  TagBloc(this._tagRepository)
      : super(TaginitState(_tagRepository.getTagList())) {
    on<CreateTagEvent>((event, emit) {
      final tagList = _tagRepository.createTag(event.tag);
      emit(TagSucessState(tagList));
    });
    on<DeleteTagEvent>((event, emit) {
      final tagList = _tagRepository.removeTag(event.tag);
      emit(TagSucessState(tagList));
    });
    on<GetTagEvent>((event, emit) {
      final tagList = _tagRepository.getTagList();
      emit(TagSucessState(tagList));
    });
  }
}
