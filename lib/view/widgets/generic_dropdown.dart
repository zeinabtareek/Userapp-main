import 'package:flutter/material.dart';

class GenericDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedValue;
  final void Function(T?)? onChanged;
  final String? Function(T)? itemToString;
  final bool showBorder;
  final String? hintText;
  final TextStyle? selectStyle;
  final TextStyle? unSelectStyle;
  final String prefixIconPath;
  const GenericDropdown({
    super.key,
    required this.items,
    this.selectedValue,
    this.onChanged,
    this.itemToString,
    this.selectStyle,
    this.unSelectStyle,
    this.showBorder = true,
    this.hintText = '',
    required this.prefixIconPath,
  });

  @override
  _GenericDropdownState<T> createState() => _GenericDropdownState<T>();
}

class _GenericDropdownState<T> extends State<GenericDropdown<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  OutlineInputBorder inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        width: widget.showBorder ? 0.5 : 0.5,
        color: Theme.of(context).hintColor.withOpacity(0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: inputBorder(),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        contentPadding: const EdgeInsets.all(10),
        // hintText: "jjjjj",
        prefixIcon: SizedBox(
          // width: 45.w,
          width: 45,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(start: 10),
                width: 30,
                alignment: Alignment.center,
                // padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Image.asset(
                  widget.prefixIconPath,
                  height: 20,
                  width: 20,
                ),
              ),
              const SizedBox(width: 2),
              Container(
                height: 25,
                width: 2,
                color: Theme.of(context).hintColor.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
      child: DropdownButton<T>(
        hint:
          Text("${widget.hintText}"),
        //  SizedBox(
        //   width: max(Get.width - 120.w, Get.width / 2),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text("${widget.hintText}"),
        //       const Spacer(),
        //       const Icon(
        //         Icons.arrow_drop_down,
        //         color: Colors.grey,
        //       ),
        //     ],
        //   ),
        // ),
        // icon: const SizedBox(),
        isExpanded: true,
        // icon: const SizedBox(
        //   width: 100,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Icon(Icons.arrow_drop_down),
        //     ],
        //   ),
        // ),
        padding: const EdgeInsetsDirectional.only(start: 5),
        underline: const SizedBox(),
        value: _selectedValue,
        borderRadius: BorderRadius.circular(20),
        menuMaxHeight: 300,
        items: widget.items.map((T item) {
          return DropdownMenuItem<T>(
            alignment: AlignmentDirectional.centerEnd,
            value: item,
            child: 
        
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                              widget.itemToString?.call(item) ?? item.toString(),
                              style: _selectedValue == item
                                  ? widget.selectStyle
                                  : widget.unSelectStyle,
                              // textAlign: TextAlign.center,

                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
          ],
        ),
       
          );
        }).toList(),
        onChanged: (T? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        onTap: () => setState(() {
          _selectedValue = null;
        }),
      ),
    );
  }
}
