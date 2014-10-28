import 'dart:html';
import 'dart:math';
import 'package:gorgon/gorgon.dart';
import 'dart:convert' show JSON;
import 'dart:async' show Future;

List<String> texto_botao=[];
List<String> valor_botao=[];
List<String> style_botao=[];
List<String> fases_jogo=[];
ButtonElement botao_0;
ButtonElement botao_1;
ButtonElement botao_2;
int i=0,corretos=0,fase_atual=0, vidas=3;
const maximoFases=11;

//ler dados do JSON
class Leitura{
  static Future lendoDados(){
    var path = 'jogo1.json';
    return HttpRequest.getString(path).then(_dadosFromJson);
  }
  static _dadosFromJson(String jsonString){
    Map dados = JSON.decode(jsonString);
    texto_botao=dados['texto_botao'];
    valor_botao=dados['valor_botao'];
    style_botao=dados['style_botao'];
    fases_jogo=dados['fases_jogo'];
  }
}

Sound backgoundsound = new Sound( soundUrl: "resources/music/somjogo.wav" );
Sound correctSound = new Sound( soundUrl: "resources/music/correct.wav" );
Sound errorSound = new Sound( soundUrl: "resources/music/error.wav" );
Sound gameoverSound = new Sound( soundUrl: "resources/music/gameover.wav" );
void main() {
    backgoundsound.onLoad.then((_) => backgoundsound.play( looping: true ));
    Leitura.lendoDados();
    
    botao_0 = querySelector('#botao0');
    botao_1 = querySelector('#botao1');
    botao_2 = querySelector('#botao2');
    botao_0.style.display = botao_1.style.display = botao_2.style.display = 'none';
    querySelector('#continue').onClick.listen(geraPagina);
}

void mostraBotao(int j,int n){
  if(j==0){
    botao_0..text = texto_botao[n]
             ..style.display = style_botao[n]
             ..value=valor_botao[n]
             ..onClick.listen(valor);
  }
  if(j==1){
      botao_1..text = texto_botao[n]
               ..style.display = style_botao[n]
               ..value=valor_botao[n]
               ..onClick.listen(valor);
    }
  if(j==2){
      botao_2..text = texto_botao[n]
               ..style.display = style_botao[n]
               ..value=valor_botao[n]
               ..onClick.listen(valor);
    }
}

void geraPagina(Event e){
  querySelector('#continue').style.display='none';
  int k=0,n,j=-1;
  var num = new Random();
  List<int> sorteados=[];
  if(fase_atual < maximoFases){
    querySelector('#frases').text = fases_jogo[fase_atual];
    while(k<3){
      n=num.nextInt(3);
      if(!sorteados.contains(n)){
        j++;
        mostraBotao(j,n+i);
        sorteados.add(n);
        k++;
      }
    }
  }
}

void geraPaginaFinal(Event e){
  querySelector('#continue').style.display='none';
  window.alert(corretos.toString());
}

void gameOverPage(){
  querySelector("#jogo_todo").style.display='none';
  Element gameover = new Element.div();
  gameover.text = "Você perdeu :(";
  document.body.append(gameover);
}

void valor(Event e){
  String valor = (e.target as ButtonElement).value;
  if(valor=="0"){
    corretos++;
    correctSound.onLoad.then((_) => correctSound.play());
    i=i+3;
    fase_atual++;
    if(fase_atual >= maximoFases){
      geraPaginaFinal(e);
    }
    geraPagina(e);
  }
  else{
    vidas--;
    if(vidas >= 0)
      errorSound.onLoad.then((_) => errorSound.play());
    else{
      gameoverSound.onLoad.then((_) => gameoverSound.play());
      gameOverPage();
    }
      
  }
}