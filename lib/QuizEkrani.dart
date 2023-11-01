import 'dart:collection';

import 'package:bayrak_quiz_uygulamasi/Bayraklar.dart';
import 'package:bayrak_quiz_uygulamasi/Bayraklardao.dart';
import 'package:bayrak_quiz_uygulamasi/SonucEkrani.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizEkrani extends StatefulWidget {
  const QuizEkrani({super.key});

  @override
  State<QuizEkrani> createState() => _QuizEkraniState();
}

class _QuizEkraniState extends State<QuizEkrani> {

  var sorular = <Bayraklar>[];
  var yanlisSecenekler = <Bayraklar>[];
  late Bayraklar dogruSoru;
  var tumSecenekler = HashSet<Bayraklar>();

  int soruSayac = 0;
  int dogruSayac = 0;
  int yanlisSayac = 0;

  String bayrakResimAdi = "placeholder.png";
  String butonAYazi = "";
  String butonBYazi = "";
  String butonCYazi = "";
  String butonDYazi = "";

  @override
  void initState() {
    super.initState();
    sorulariAl();
  }

  Future<void> sorulariAl() async{
    sorular = await Bayraklardao().rasgele5Getir();
    soruYukle();
  }

  Future<void> soruYukle() async{
    dogruSoru = sorular[soruSayac];
    bayrakResimAdi = dogruSoru.bayrak_resim!;
    yanlisSecenekler = await Bayraklardao().rasgele3YanlisGetir(dogruSoru.bayrak_id!);

    tumSecenekler.clear();
    tumSecenekler.add(dogruSoru);
    tumSecenekler.add(yanlisSecenekler[0]);
    tumSecenekler.add(yanlisSecenekler[1]);
    tumSecenekler.add(yanlisSecenekler[2]);

    butonAYazi = tumSecenekler.elementAt(0).bayrak_ad!;
    butonBYazi = tumSecenekler.elementAt(1).bayrak_ad!;
    butonCYazi = tumSecenekler.elementAt(2).bayrak_ad!;
    butonDYazi = tumSecenekler.elementAt(3).bayrak_ad!;

    setState(() {
    });


  }

  void soruSayacKontrol(){
    soruSayac = soruSayac+1;

    if(soruSayac != 5){
      soruYukle();
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SonucEkrani(dogruSayisi: dogruSayac,)));

    }
  }

  void dogruKontrol(String buttonYazi){
    if(dogruSoru.bayrak_ad== buttonYazi){
      dogruSayac = dogruSayac+1;
    }
    else{
      yanlisSayac = yanlisSayac+1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Quiz Ekranı"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Doğru:$dogruSayac",style: TextStyle(fontSize: 18),),
                Text("Yanlış:$yanlisSayac",style: TextStyle(fontSize: 18),),
              ],
            ),
            soruSayac != 5 ? Text("${soruSayac+1}. SORU",style: TextStyle(fontSize: 30),):
                Text("5.SORU" , style: TextStyle(fontSize: 30),),
            Image.asset("resimler/$bayrakResimAdi"),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text(butonAYazi),
                onPressed: (){
                  dogruKontrol(butonAYazi);
                  soruSayacKontrol();
                },
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text(butonBYazi),
                onPressed: (){
                  dogruKontrol(butonBYazi);
                  soruSayacKontrol();
                },
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text(butonCYazi),
                onPressed: (){
                  dogruKontrol(butonCYazi);
                  soruSayacKontrol();
                },
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text(butonDYazi),
                onPressed: (){
                  dogruKontrol(butonDYazi);
                  soruSayacKontrol();
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
