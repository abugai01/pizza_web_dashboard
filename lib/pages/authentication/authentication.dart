import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/cubits/auth/cubit_auth.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/routing/routes.dart';
import 'package:pizza_web_dashboard/services/auth.dart';
import 'package:pizza_web_dashboard/services/database.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

//TODO: избавиться от пустой формы на долю секунды в случае ввода правильного пароля
//TODO: обрабатывать network error
class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _validate = true; //TODO: хрень какая-то старая!

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = context.read<FirestoreDatabase>();

    return Scaffold(
      body: BlocProvider<CubitAuth>(
          create: (context) => CubitAuth(database: database, auth: auth),
          child: BlocBuilder<CubitAuth, AuthState>(builder: (context, state) {
            return Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Image.asset("assets/icons/logo.png"),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text("Логин",
                            style: GoogleFonts.roboto(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: "Welcome back to the admin panel.",
                          color: lightGrey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: context.read<CubitAuth>().email,
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "abc@domain.com",
                          errorText: _validate ? null : 'Неверный формат email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: context.read<CubitAuth>().password,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Пароль",
                          hintText: "123",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            //TODO: сделать сохранение state, чтобы можно было переключать галочку
                            Checkbox(value: true, onChanged: (value) {}),
                            CustomText(
                              text: "Запомнить меня",
                            ),
                          ],
                        ),
                        CustomText(text: "Забыли пароль?", color: active)
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isEmail(context.read<CubitAuth>().email.text)
                              ? _validate = true
                              : _validate = false;
                        });
                        if (_validate) {
                          //TODO: предусмотреть на случай ошибки кастомный текст, типа неправильный пароль или вы не админ
                          if (!await context.read<CubitAuth>().signIn()) {
                            final snackBar = SnackBar(
                              content: const Text('Неправильный логин/пароль'),
                              // action: SnackBarAction(
                              //   label: 'Undo',
                              //   onPressed: () {},
                              // ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          context.read<CubitAuth>().clearControllers();

                          Navigator.pushNamed(context, rootRoute);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: active,
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CustomText(
                          text: "Вход",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "Do not have admin credentials? "),
                      TextSpan(
                          text: "Request Credentials! ",
                          style: TextStyle(color: active))
                    ]))
                  ],
                ),
              ),
            );
          })),
    );
  }
}
