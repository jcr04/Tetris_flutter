import 'package:flutter/material.dart';
import 'package:tetris_23/setting.dart';
import 'package:tetris_23/tetris_23.dart';

bool darkTheme = false;
bool soundEnable = false;

class FrontPage extends StatefulWidget {
  FrontPage({Key key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    actions: <Widget>[
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Sair'),
                      ),
                    ],
                    title: Text(
                      "Como controlar os blocos?",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Jogando pelo celular você pode interagir com os controles inferior na interface do jogo.\nCaso esteja jogando pelo PC você pode utilizar as teclas: WASD.",
                        ),
                        SizedBox(height: 10),
                        Text(
                          "WASD controle:",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                            "A = mover para esquerda, D = mover para direita, W = rotacionar bloco, S = dropar o bloco"),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Setting(
                    darkTheme: darkTheme,
                    enableSound: soundEnable,
                  );
                }));
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset(
              'docs/assets/tetris_23.png',
              width: 120, // Defina a largura da imagem conforme necessário
              height: 120, // Defina a altura da imagem conforme necessário
            ), //entre parenteses: expandedWidth: MediaQuery.of(context).size.width * 0.7,
            Column(
              children: <Widget>[
                Text(
                  'Selecione a dificuldade para começar o jogo:',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tooltip(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Tetris(
                            width: 10,
                            height: 15,
                            gameSpeed: 700,
                            color: Colors.green[600],
                          );
                        }));
                      },
                      child: Text('Fácil'),
                      color: Colors.green[600],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                    ),
                    message: 'Velocidade baixa',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                  child: Tooltip(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Tetris(
                            width: 10,
                            height: 15,
                            gameSpeed: 500,
                            color: Colors.indigo[900],
                          );
                        }));
                      },
                      child: Text('Médio'),
                      color: Colors.indigo[900],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                    ),
                    message: 'Velocidade média',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                  child: Tooltip(
                    message: 'Modo difícil, desafie a si mesmo!',
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Tetris(
                              width: 10,
                              height: 15,
                              gameSpeed: 200,
                              color: Colors.pink[900],
                            );
                          }));
                        },
                        child: Text('Difícil'),
                        color: Colors.pink[900],
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0))),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
