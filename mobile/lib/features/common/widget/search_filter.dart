import 'package:flutter/material.dart';

class SearchFilterComponent extends StatelessWidget {
  const SearchFilterComponent({
    Key? key,
    required this.onChange,
    required this.onPressed,
    required this.controller,
    this.onTapOutside,
  }) : super(key: key);
  final Function(String?) onChange;
  final Function() onPressed;
  final TextEditingController controller;
  final void Function(PointerDownEvent)? onTapOutside;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: onTapOutside,
      onChanged: onChange,
      maxLength: 20,
      controller: controller,
      textAlignVertical: TextAlignVertical.bottom,
      maxLines: 1,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      decoration: InputDecoration(
        counterText: '',
        fillColor: Colors.black45,
        filled: true,
        hintText: 'Buscar',
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
          size: 20,
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.clear),
        ),
        focusedBorder: UnderlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey[200]!)),
        enabledBorder: UnderlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
      ),
    );
  }
}
