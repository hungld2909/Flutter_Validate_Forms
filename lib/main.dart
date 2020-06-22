import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(),
      home: new FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  FormPage({Key key}) : super(key: key);
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // final textController = new TextEditingController();
  final FocusNode focusNode = new FocusNode(); //! biến để thay đổi focusNode
  final scaffoldkey =
      new GlobalKey<ScaffoldState>(); //! biến để điều khiển scaffoldkey
  final formkey = new GlobalKey<FormState>();

  String _email; //! khởi tạo email;
  String _passWord; //! khởi tạo password;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() { //! bắt sự kiện khi người dùng ấn nút button
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() {
    final snackbar = new SnackBar(
      content: new Text("Email: $_email, PassWord: $_passWord"),
    );
    scaffoldkey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: new AppBar(
        title: Text("Form Page"),
      ),
      // body: new Container(
      //   padding: const EdgeInsets.all(10.0),
      //  child: new Column(
      //    children: <Widget>[
      //   //      new TextField(
      //   //   decoration: new InputDecoration(
      //   //     hintText: "Enter something",
      //   //     border: InputBorder.none,
      //   //     labelText: "Enter data"
      //   //   ),
      //   // ),
      //   //   new TextField(
      //   //   decoration: new InputDecoration(
      //   //     hintText: "Enter something",
      //   //     border: InputBorder.none,
      //   //     labelText: "Enter data"
      //   //   ),
      //   // ),
      //   // ! focus
      //   // new TextField(
      //   //   autofocus: true,
      //   // ),
      //   // new TextField(
      //   //   focusNode: focusNode, //! focus: tiếng anh là: tiêu điểm, tập chung. focusNode là nút tiêu điểm, nút tập chung
      //   // ),

      //    ],
      //  ),

      // ),
      // floatingActionButton: new FloatingActionButton(
      //   child: new Icon(Icons.add),
      //   onPressed: () => FocusScope.of(context).requestFocus(focusNode)
      //   ),
      body: new Padding(
        //! khởi tạo Padding để tách khoảng cách giữa màn hình và Form
        padding: const EdgeInsets.all(
            20.0), //! khoảng cách 4 vị trí Top,Bottom,Left,Right đều sẽ là 20.
        child: new Form(
            //! khởi tạo Form
            key: formkey, //! id form
            child: new Column(
              //! sắp xếp theo thứ tự Column từ trên xuống dưới
              children: <Widget>[
                new TextFormField(
                  //! textFormField giúp người dùng điền thông tin
                  decoration: new InputDecoration(
                      //! decoration có những thuộc tính trong textFormField
                      labelText: "Email",
                      hintText: "hihi"),
                  validator: (val) => !val.contains('@')
                      ? 'Invalid Email'
                      : null, //! validator bắt sự kiện người dùng phải nhập đúng form theo yêu cầu là cần có ký tự @, nếu không nhập thì sẽ hiện thị thông báo
                  onSaved: (val) => _email = val, //! các giá trị sẽ được lưu vào _email
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Password"),
                  validator: (val) =>
                      val.length < 6 ? 'PassWord too short' : null, //! người dùng k thể nhập ký tự quá ngắn
                  onSaved: (val) => _passWord = val, //! các giá trị sẽ được lưu vào Password
                  obscureText: true, //! obscureText: giúp passWord được mã hóa
                ),
                new RaisedButton( //! nút Button login
                  child: new Text("Login"),
                  onPressed: _submit, 
                )
              ],
            )),
      ),
    );
  }
}
