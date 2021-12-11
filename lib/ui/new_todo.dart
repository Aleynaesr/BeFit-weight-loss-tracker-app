import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weight_loss_tracker/db/category_provider.dart';
import 'package:weight_loss_tracker/db/todo_provider.dart';
import 'package:weight_loss_tracker/model/category.dart';
import 'package:weight_loss_tracker/model/todo.dart';
import 'package:weight_loss_tracker/util/constants.dart';

class NewTodo extends StatefulWidget {
  static final String routeName = '/new';
  final Todo todo;
  final DateFormat formatter = new DateFormat.yMMMMd("en_US");

  NewTodo({Key key, this.todo}) : super(key: key) {
    if (todo.date == null) {
      this.todo.date = formatter.format(new DateTime.now());
    }
  }

  @override
  _NewTodoState createState() => new _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<Category> _categoryList = [];
  Category _category;

  AppBar _createAppBar() {
    return new AppBar(
      leading: BackButton(
          color: Colors.black
      ),
      title: new Text(_getTitle(), style: TextStyle(color: Colors.black)),
      actions: <Widget>[_createSaveUpdateAction()],
    );
  }

  IconButton _createSaveUpdateAction() {
    return new IconButton(
      splashColor: Colors.green,
      focusColor: Colors.green,
      hoverColor: Colors.green,
      highlightColor: Colors.green,
      onPressed: () {
        _saveTodo();
      },
      icon: const Icon(Icons.save, color:Colors.black),
    );
  }

  _saveTodo() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      TodoProvider provider = new TodoProvider();
      widget.todo.categoryId = _category.id;
      if (!_isExistRecord()) {
        await provider.insert(widget.todo);
      } else {
        await provider.update(widget.todo);
      }
      Navigator.of(context).pop();
    }
  }

  bool _isExistRecord() {
    return widget.todo.id == null ? false : true;
  }

  @override
  void initState() {
    super.initState();
    new CategoryProvider().getAllCategory().then((categories) {
      setState(() {
        if (_isExistRecord())
          _category = categories
              .firstWhere((category) => category.id == widget.todo.categoryId);
        _categoryList = categories;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _getTitle() {
    return _isExistRecord() ? Constants.titleEdit : Constants.titleNew;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _createAppBar(),
      body: new Padding(
          padding: new EdgeInsets.fromLTRB(12.0, 18.0, 12.0, 18.0),
          child: new Form(
            onWillPop: _warnUserWithoutSaving,
            key: _formKey,
            child: new Column(
              children: <Widget>[
                _createDatePicker(),
                _createNote(),
                _categoryList.isNotEmpty
                    ? _createCategoryDropDownList(_categoryList)
                    : new Container()
              ],
            ),
          )),
    );
  }

  Row _createDatePicker() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.date_range,
          color: Colors.black,
        ),
        new InkWell(
          child: new Padding(
            padding: new EdgeInsets.only(
                left: 18.0, top: 8.0, bottom: 8.0, right: 18.0),
            child: new Text(
              widget.todo.date,
              style: new TextStyle(color: Colors.green, fontSize: 14.0),
            ),
          ),
          onTap: _pickDateFromDatePicker,
        )
      ],
    );
  }

  Row _createCategoryDropDownList(List<Category> categories) {
    return new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Icon(
            Icons.list,
            color: Colors.black,
          ),
          new Padding(
              padding:
                  new EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
              child: new DropdownButtonHideUnderline(
                child: new DropdownButton(
                    focusColor: Colors.black,
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    dropdownColor: Colors.green,
                    value: _category ??
                        (categories.length > 0
                            ? _category = categories[0]
                            : null),
                    items: _createCategoryDropDownMenuItems(categories),
                    isDense: true,
                    onChanged: (value) {
                      setState(() => _category = value);
                    }),
              ))
        ]);
  }

  List<DropdownMenuItem<Category>> _createCategoryDropDownMenuItems(
      List<Category> categories) {
    return categories.map((category) {
      return new DropdownMenuItem(
          value: category,
          child: new Text(category.name,
              style: new TextStyle(color: Colors.black, fontSize: 16.0)));
    }).toList();
  }

  _pickDateFromDatePicker() async {
    DateTime dateTime = widget.formatter.parse(widget.todo.date);
    DateTime dateTimePicked = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: isBeforeToday(dateTime) ? dateTime : new DateTime.now(),
      lastDate: dateTime.add(const Duration(days: 365)),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.green,
              onPrimary: Colors.black,
              surface: Colors.green,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );

    if (dateTimePicked != null) {
      setState(() {
        widget.todo.date = widget.formatter.format(dateTimePicked);
      });
    }
  }

  bool isBeforeToday(DateTime date) {
    return date.isBefore(new DateTime.now());
  }

  Future<bool> _warnUserWithoutSaving() async {
    if (_isExistRecord()) {
      return true;
    } else {
      return await showDialog<bool>(
            context: context,
            builder: (buildContext) => AlertDialog(
              title: const Text('Discard The Note'),
              content: const Text('Do you want close without saving?'),
              actions: <Widget>[
                new ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green,
                    ),
                  ),
                  child: const Text('YES'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                new ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black26,
                    ),
                  ),
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
          ) ??
          false;
    }
  }

  TextFormField _createNote() {
    return new TextFormField(
      textAlign: TextAlign.justify,
      maxLines: 3,
      cursorColor: Colors.green,
      showCursor: true,
      toolbarOptions: const ToolbarOptions(
          copy: true, selectAll: true, cut: true, paste: true),
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(4.0),
        icon: const Icon(
          Icons.note,
          color: Colors.black,
        ),
        labelStyle: TextStyle(color: Colors.black54),
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Type Something... ',
      ),
      initialValue: widget.todo.note ?? '',
      keyboardType: TextInputType.text,
      validator: _validateNote,
      onSaved: _noteOnSave,
    );
  }

  String _validateNote(String value) {
    return value.isEmpty ? 'Note is required' : null;
  }

  void _noteOnSave(String value) {
    widget.todo.note = value;
  }
}
