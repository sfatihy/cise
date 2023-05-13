import 'package:cise/database/tagDatabaseModel.dart';
import 'package:cise/product/colorConstants.dart';
import 'package:cise/product/iconConstants.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/product/paddingConstants.dart';
import 'package:cise/viewModel/tagsRowCubit.dart';
import 'package:cise/widget/CustomHeightSpace.dart';
import 'package:cise/widget/CustomModalBottomSheet.dart';
import 'package:cise/widget/CustomSnackBar.dart';
import 'package:cise/widget/TextFromFieldContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

SizedBox CustomTagsRow({
  required List<Tag> tags,
  required int currentTag,
  required BuildContext contextTagsRow,
  }) {

  return SizedBox(
    height: 50,
    child: Stack(
      children: [
        Container(
          height: 50,
          padding: PaddingConstants.bodyLPadding,
          child: ListView.builder(
            itemCount: tags.length - 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(int.parse(tags[index].tagColor ?? "0xFFFFFFFF")),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: currentTag == tags[index].id ? Theme.of(context).colorScheme.primary : ColorConstants.backgroundDarkColor,
                      width: currentTag == tags[index].id ? 2 : 0,
                      style: BorderStyle.solid
                    ),
                  ),
                  padding: PaddingConstants.allSmallPadding,
                  margin: index < tags.length - 2 ? PaddingConstants.bodyRPadding : EdgeInsets.only(right: 48),
                  child: Center(
                    child: Text(
                      "#${tags[index].tagName}",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ),
                ),
                onTap: () {
                  context.read<TagsRowCubit>().changeCurrentTagIndex(tags[index].id ?? 0);
                  context.read<TagsRowCubit>().setTags();
                },
                onLongPress: () {
                  var firstContext = context;
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: firstContext,
                    builder: (firstContext) {
                      Tag tag = tags[index];
                      return CustomModalBottomSheet(
                        widget: Column(
                          children: [
                            Form(
                              key: context.read<TagsRowCubit>().updateTagFormKey,
                              child: TextFormFieldContainer(
                                child: TextFormField(
                                  controller: context.read<TagsRowCubit>().newTagNameController,
                                  decoration: InputDecoration(
                                    hintText: tag.tagName
                                  ),
                                ),
                              ),
                            ),
                            CustomHeightSpace(),
                            SlidePicker(
                              pickerColor: Color(int.parse(tag.tagColor ?? "0xFFFFFFFF")),
                              enableAlpha: false,
                              onColorChanged: (Color c) {
                                context.read<TagsRowCubit>().changeColor(c);
                              },
                            ),
                            CustomHeightSpace(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.15,
                                ),
                                OutlinedButton.icon(
                                  icon: IconConstants.saveIcon,
                                  label: Text(LocaleKeys.updateTag.value),
                                  onPressed: () async {
                                    if (context.read<TagsRowCubit>().updateTagFormKey.currentState!.validate()) {
                                      if (context.read<TagsRowCubit>().newTagNameController.text.length > 0 || context.read<TagsRowCubit>().colorController != ColorConstants.primaryColor) {

                                        Tag updatedTag = Tag(
                                          id: tag.id,
                                          tagName: context.read<TagsRowCubit>().newTagNameController.text.length > 0 ? context.read<TagsRowCubit>().newTagNameController.text.toString() : tag.tagName,
                                          tagCreatedDate: tag.tagCreatedDate,
                                          tagColor: context.read<TagsRowCubit>().colorController == ColorConstants.primaryColor ? tag.tagColor : "0x${context.read<TagsRowCubit>().colorController.value.toRadixString(16).toUpperCase()}"
                                        );

                                        await context.read<TagsRowCubit>().updateTag(updatedTag);

                                        Navigator.pop(context);

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          CustomSnackBar(text: updatedTag.tagName.toString() + " changed!")
                                        );
                                      }
                                      else {
                                        print("Nothing changed!!!");
                                      }
                                    }
                                    else {
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: IconConstants.deleteIcon,
                                  tooltip: LocaleKeys.deleteTag.value,
                                  onPressed: () {
                                    var firstContext = context;
                                    showDialog(
                                      barrierDismissible: false,
                                      context: firstContext,
                                      builder: (firstContext) {
                                        return AlertDialog(
                                          title: Text(LocaleKeys.alertDelete.value),
                                          content: Text(LocaleKeys.permissionDeleteTagContent.value + tag.tagName + " ?"),
                                          actions: [
                                            MaterialButton(
                                              child: Text("Delete"),
                                              onPressed: () async {
                                                await context.read<TagsRowCubit>().deleteTag(tag.id!);
                                                Navigator.pop(context);
                                                Navigator.pop(context);

                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  CustomSnackBar(
                                                    text: tag.tagName.toString() + " deleted!"
                                                  )
                                                );
                                              },
                                            ),
                                            MaterialButton(
                                              child: Text("Don't"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  ).then((value) =>
                  {
                    context.read<TagsRowCubit>().setTags()
                  });
                },
              );
            },
          ),
        ),
        Builder(
          builder: (context) {
            return Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton.small(
                child: IconConstants.addIcon,
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: contextTagsRow,
                    builder: (contextTagsRow) {
                      return StatefulBuilder(
                        builder: (contextTagsRow, setState) {
                          return CustomModalBottomSheet(
                            widget: Column(
                              children: [
                                Form(
                                  key: context.read<TagsRowCubit>().tagFormKey,
                                  child: TextFormFieldContainer(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: "Tag Name",
                                        border: InputBorder.none
                                      ),
                                      minLines: 1,
                                      maxLines: 1,
                                      controller: context.read<TagsRowCubit>().tagNameController,
                                      validator: (value) {
                                        if (value!.length < 2) {
                                          return "Must be at least 2 characters";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const CustomHeightSpace(),
                                SlidePicker(
                                  pickerColor: Theme.of(context).colorScheme.primary,
                                  enableAlpha: false,
                                  onColorChanged: (Color c) {
                                    context.read<TagsRowCubit>().changeColor(c);
                                  },
                                ),
                                const CustomHeightSpace(),
                                OutlinedButton.icon(
                                  icon: IconConstants.addIcon,
                                  label: Text("Add Tag"),
                                  onPressed: () async {
                                    if (context.read<TagsRowCubit>().tagFormKey.currentState!.validate()) {
                                      Tag newTag = Tag(
                                        tagName: context.read<TagsRowCubit>().tagNameController.text,
                                        tagCreatedDate: DateTime.now().microsecondsSinceEpoch.toString(),
                                        tagColor: "0x${context.read<TagsRowCubit>().colorController.value.toRadixString(16).toUpperCase()}"
                                      );

                                      Tag result = await context.read<TagsRowCubit>().createTag(newTag);

                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        CustomSnackBar(text: result.tagName.toString() + " added!")
                                      );
                                    }
                                    else {

                                    }
                                  },
                                )
                              ],
                            )
                          );
                        }
                      );
                    }).then((value) =>
                    {
                      context.read<TagsRowCubit>().setTags()
                    });
                },
              )
            );
          }
        ),
      ],
    ),
  );
}