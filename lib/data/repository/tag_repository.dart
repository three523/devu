import 'package:devu_app/data/model/tag.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TagRepository {
  final Box<Tag> tagBox = Hive.box<Tag>('Tag');

  ExpenseRepository() {
    _init();
  }

  void _init() {
    if (tagBox.keys.isEmpty) {
      Map<String, Tag> tagList = {
        '충동구매': Tag('충동구매', Colors.red.value),
        '고정수입': Tag('고정수입', Colors.green.value),
        '예금': Tag('저축', Colors.blue.value),
      };
      tagBox.putAll(tagList);
    }
  }

  List<Tag> getTagList() {
    return tagBox.values.toList();
  }

  List<Tag> createTag(Tag tag) {
    tagBox.put(tag.name, tag);
    return getTagList();
  }

  List<Tag> removeTag(Tag tag) {
    tagBox.delete(tag.name);
    return getTagList();
  }
}
