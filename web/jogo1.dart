import 'dart:html';
import 'dart:math';
import 'package:gorgon/gorgon.dart';
import 'dart:convert' show JSON;
import 'dart:async' show Future;

List<String> texto_botao=["Roçar com foice e enxada","Aplicar vários inseticidas",
"Colocar fogo","Dividi-lá em partes iguais","Plantar todos os vegetais juntos no mesmo espaço",
"","Com fertilizantes naturais, como o esterco de suas próprias galinhas", "Comprar Adubos",
"Não Adubar","Plantar cada semente no seu lugar","Plantar as sementes em qualquer lugar","",
"Molhar uma vez ao dia", "Não molhar", "Molhar 4 vezes ao dia, com muita água",
"Fazer uma cerca", "Não fazer cerca, apenas observar","",
"Separar as folhas para comer no jantar","Separar a raiz para comer no jantar.","",
"Utilizar o vegetal inteiro para alimentar seus animais","Jogar fora suas folhas, e dar apenas o caule e a raiz aos seu animais.","",
"Usar as espigas para fazer fubá, e as folhas e caule para dar de alimento aos animais.","Dispensar as espigas.","",
"Arrancar o pé de cenoura inteiro e oferecê-lo aos seus bichos de estimação.","Cortar apenas as folhas.","",
"Colher suas frutas.","Dispenser suas frutas.",""];
List<String> valor_botao=["0","Você errou! Isso acaba com o mato indesejado, mas polui o solo, o ar e a água.","Você errou! Isso destrói o matagal e os pequenos animais que vivem ali.",
                          "0","Você errou! Dessa forma um vegetal interfere no crescimento do outro.","1",
                          "0","Você errou! Comprar abudos é caro e Pedro não tem dinheiro.","Você errou! Os vegetais vão demorar demais a crescer.",
                          "0","Você errou! Você não pode misturar as sementes.","1",
                          "0","Você errou! Se não molhar as sementes não irão germinar.","Você errou! Se você molhar demais as sementes vão apodrecer e não irão germinar.",
                          "0","Você errou! Assim seus animais irão estragar toda a roça","1",
                          "0","Você errou! Raiz de couve não é um alimento comum para nós humanos","1",
                          "0","Você errou! São nas folhas que se encontram os nutrientes principais da alface.","1",
                          "0","Você errou! As espigas são ricas em carboidratos, que dá energia a quem consome.","1",
                          "0","Você errou! Pois a cenoura é uma raiz onde se utiliza todo o vegetal, seja para servir os animais ou para nos servir.","1",
                          "0","Você errou!","1"];
List<String> style_botao=["initial","initial","initial",
                          "initial","initial","none",
                          "initial","initial","initial",
                          "initial","initial","none",
                          "initial","initial","initial",
                          "initial","initial","none",
                          "initial","initial","none",
                          "initial","initial","none",
                          "initial","initial","none",
                          "initial","initial","none",
                          "initial","initial","none"];
List<String> fases_jogo=["Primeiramente precisamos organizar a roça onde os vegetais serão plantados posteriormente. Qual a melhor opção?",
"Agora vamos dividir a roça em 5 partes para plantarmos couve, alface, milho, cenoura e melância. O que fazer então?",
"Muito bem! Agora precisamos adubar a terra.",
"Agora que adubamos a terra precisamos plantar as sementes.",
"As sementes estão plantadas. O que devemos fazer agora para as sementes germinarem?",
"Precisamos agora cuidar dos vegetais que germinaram e estão começando a crescer.",
"Vamos fazer a colheita da couve!",
"Vamos colher a alface agora?!",
"Agora é a vez do milho!",
"...da cenoura",
"E finalmente da melância"];
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
    //Leitura.lendoDados();
    
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