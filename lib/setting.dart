import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris_23/front_page.dart' as Settings;
import 'package:tetris_23/notifier.dart';
import 'package:audioplayers/audioplayers.dart';

class Setting extends StatefulWidget {
  final bool darkTheme;
  final bool enableSound;

  Setting({Key key, this.darkTheme, this.enableSound}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool darkTheme;
  bool enableSound;
  AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    darkTheme = !widget.darkTheme;
    enableSound = !widget.enableSound;
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _themeChanger = Provider.of<ThemeChanger>(
        context); //importa a função da pasta notifier.dart
    //acredito que tenha que incluir função similar para o som do jogo
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Opções'),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.build),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Ativar o modo noturno'),
                  Expanded(
                    child: Container(),
                  ),
                  Switch(
                    onChanged: (bool value) {
                      setState(() {
                        darkTheme = !value;
                        Settings.darkTheme = value;
                      });
                      if (darkTheme) {
                        _themeChanger.setTheme(ThemeData(
                          brightness: Brightness.light,
                          primaryColor: Colors.white,
                          canvasColor: Colors.white,
                        ));
                      } else {
                        _themeChanger.setTheme(ThemeData(
                          brightness: Brightness.dark,
                          primaryColor: Colors.black,
                          canvasColor: Colors.black,
                        ));
                      }
                    },
                    value: !darkTheme,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Ativar e desativar som'),
                  Expanded(
                    child: Container(),
                  ),
                  Switch(
                    onChanged: (bool value) async {
                      setState(() {
                        enableSound = value;
                        Settings.soundEnable = value;
                      });
                      if (enableSound) {
                        final player = AudioPlayer();
                        await player.play(
                            DeviceFileSource('docs/assets/tetris_sound.mp3'));
                      } else {
                        audioPlayer.pause();
                      }
                    },
                    value: enableSound,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Créditos'),
                            content: Text(
                                'Aluno: Victor Souza da Silva. Desenvolveu o trabalho completo, tanto como código como a documentação.\n-SEMINRIO TEMATICO VII-\n-LICENÇAS-\nSom do jogo: https://licensing.jamendo.com/pt/track/1885435/8-bit-arcade-game-music.'),
                          );
                        },
                      );
                    },
                    child: Text('Ver Créditos'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
