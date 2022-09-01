import 'package:auth/util/firebase_auth_app_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  //Variaveis de animacao
  late AnimationController _iconAnimationController;
  late AnimationController _formAnimationController;
  late Animation<double> _iconAnimation;
  late Animation<double> _formAnimation;

  //variaveis formulario
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  String get username => _email.text;
  String get password => _pass.text;


  void doLogin(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);

      User? user = userCredential.user;

      if (user != null) {
        _email.text = "";
        _pass.text = "";
        // ignore: use_build_context_synchronously
        FirebaseAuthAppNavigator.goToHome(context);
      }

    } catch (e) {
      
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text("Falha ao realizar login"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  void register(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);

      User? user = userCredential.user;

      if (user != null) {
        _email.text = "";
        _pass.text = "";
        // ignore: use_build_context_synchronously
        FirebaseAuthAppNavigator.goToHome(context);
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Falha ao criar registro",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future _playAnimation() async {
    try {
      await _iconAnimationController.forward().orCancel;
      await _formAnimationController.forward().orCancel;
    } on TickerCanceled {
      //animacao cancelada
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    _formAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 1000));

    _formAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_formAnimationController);

    _iconAnimation = CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeOut);

    _iconAnimation.addListener(() => this.setState(() {}));

    _playAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _formAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
          builder: (context) => GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    const Image(
                      image: AssetImage("assets/images/guy.jpg"),
                      fit: BoxFit.cover,
                      color: Colors.black54,
                      colorBlendMode: BlendMode.darken,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlutterLogo(
                          size: _iconAnimation.value * 100,
                        ),
                        FadeTransition(
                          opacity: _formAnimation,
                          child: Form(
                            child: Theme(
                              data: ThemeData(
                                brightness: Brightness.dark,
                                primarySwatch: Colors.blue,
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                  labelStyle: TextStyle(
                                      color: Colors.blueAccent, fontSize: 20),
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _email,
                                      decoration: const InputDecoration(
                                          labelText: "Enter e-mail"),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    TextFormField(
                                      controller: _pass,
                                      decoration: const InputDecoration(
                                          labelText: "Enter password"),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        doLogin(context);
                                      },
                                      height: 40,
                                      minWidth: 100,
                                      color: Colors.blue[900],
                                      textColor: Colors.white,
                                      splashColor: Colors.blue,
                                      child: const Text('Login'),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        register(context);
                                      },
                                      height: 40,
                                      minWidth: 100,
                                      color: Colors.black45,
                                      textColor: Colors.white70,
                                      splashColor: Colors.blue,
                                      child: const Text('Register'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
    );
  }
}
