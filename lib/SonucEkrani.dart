import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SonucEkrani extends StatefulWidget {

  int? dogruSayisi;

  SonucEkrani({required this.dogruSayisi});

  @override
  State<SonucEkrani> createState() => _SonucEkraniState();
}

class _SonucEkraniState extends State<SonucEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Sonuç Ekranı"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.dogruSayisi} DOĞRU ${5- widget.dogruSayisi!} YANLIŞ",style: TextStyle(fontSize: 30),),
            Text("% ${((widget.dogruSayisi!*100)/5).toInt()} Başarı",style: TextStyle(fontSize: 30,color: Colors.pink),),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text("TEKRAR DENE"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
