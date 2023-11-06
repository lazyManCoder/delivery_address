
import 'package:delivery_address/src/components/city_selector.dart';
import 'package:delivery_address/src/components/inputTextFormField.dart';
import 'package:flutter/material.dart';

typedef OnChanged = void Function(String city, String address);

typedef ClickShowModalBottom = void Function(bool value);

class SelectBoxWithTextField extends StatefulWidget {
  final FocusNode? focusNode;

  final String? value;

  final OnChanged onChanged;

  final ClickShowModalBottom? clickShowModalBottom;

  const SelectBoxWithTextField({
    Key? key,
    required this.onChanged,
    this.focusNode,
    this.value,
    this.clickShowModalBottom
  }) : super(key: key);

  @override
  State<SelectBoxWithTextField> createState() => _SelectBoxWithTextFieldState();
}

class _SelectBoxWithTextFieldState extends State<SelectBoxWithTextField> {
  final TextEditingController _controller = TextEditingController();

  String districts = "";

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      setState(() {
        districts = widget.value!;
      });
    }
  }

  @override
  void didUpdateWidget(SelectBoxWithTextField oldWidget) {
    if (oldWidget.value != widget.value) {
      setState(() {
        districts = widget.value!;
      });
    }
  }

  @override
  void dispose() {
    widget.focusNode?.dispose();  // Dispose the focusNode if it's not null
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFFF1F4F9),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // 点击弹窗进行判断状态
                    if (widget.clickShowModalBottom != null) {
                      print("widget.focus: ${widget.focusNode?.hasFocus}");
                      if (widget.focusNode?.hasFocus == true) {
                        widget.clickShowModalBottom!(true);
                      }
                    }

                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),  // Adjust the radius as needed
                              topRight: Radius.circular(16.0), // Adjust the radius as needed
                            ),
                            child: CitySelector(
                              onChanged: (value) {
                                setState(() {
                                  districts = value;
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          );
                        }
                    ).then((value) {
                      if (widget.clickShowModalBottom != null) {
                        widget.clickShowModalBottom!(false);
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 100),
                        child: Text(districts.isNotEmpty ? districts : "请选择"),
                      ),
                      const Icon(Icons.arrow_drop_down_sharp)
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: InputTextFormField(
                    focusNode: widget.focusNode,
                    minLines: 10,
                    hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF969CA9)),
                    type: Type.textArea,
                    prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey,),
                    width: MediaQuery.of(context).size.width - 10,
                    height: 40,
                    textController: _controller,
                    borderRadius: 5,
                    focusBorderColor: Colors.transparent,
                    hitText: '请输入你的收货地址',
                    onChanged: (value) {
                      if (districts.isNotEmpty) {
                        widget.onChanged(districts, value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
        Visibility(
          visible: widget.focusNode!.hasFocus == true,
          child: Column(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 35,
                height: 40,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text("取消", style: TextStyle(color: Color(0xFF999999)),),
                  ),
                ),
              )
            ],
          ) ,
        )
      ],
    );
  }
}
