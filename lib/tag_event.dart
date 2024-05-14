import 'package:devu_app/data/model/tag.dart';

sealed class TagEvent {}

final class LoadTag extends TagEvent {}

final class LoadTagAllEvent extends TagEvent {}

final class CreateTagEvent extends TagEvent {
  final Tag tag;
  CreateTagEvent(this.tag);
}

final class DeleteTagEvent extends TagEvent {
  final Tag tag;
  DeleteTagEvent(this.tag);
}

final class GetTagEvent extends TagEvent {
  GetTagEvent();
}
