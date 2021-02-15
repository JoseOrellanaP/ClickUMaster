import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class clickUAboutUs extends StatefulWidget {
  @override
  _clickUAboutUsState createState() => _clickUAboutUsState();
}

class _clickUAboutUsState extends State<clickUAboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "About Us"
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    "¿Quieres conocer el futuro del E-commerce?",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0,),
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Image(
                      image: AssetImage("assets/Logo.png"),
                      width: 250.0,
                      height: 250.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),

                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 40.0,),
                  Text(
                    "¿Quienes somos?",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Text(
                    "Somos dos jóvenes emprendedores, con una "
                        "visión unificadora para el desarrollo eficiente del "
                        "comercio electrónico y en la creación de oportunidades "
                        "desde la ciudad de Cuenca, Ecuador.",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: 60.0,),
                  Text(
                    "Nuetra Misión",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Text(
                    "Mejorar e incrementar la actividad comercial de ventas "
                        "online acortando las distancias de entrega y "
                        "creando oportunidades que aporten a negocios "
                        "pequeños y emprendimientos.",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: 60.0,),
                  Text(
                    "Nuetra Visión",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Text(
                    "Avanzar en el negocio mediante la creación de "
                        "oportunidades, innovar y aportar al crecimiento "
                        "comercial de la región.",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                ],
              ),
              Column(
                children: [
                  SizedBox(height: 60.0,),
                  Text(
                    "Nuestro Equipo",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.0,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Image(
                              image: AssetImage("assets/imageJose.jpg"),
                              width: 100.0,
                              height: 100.0,
                            ),
                            padding: EdgeInsets.all(15.0),

                          ),
                          Column(
                            children: [
                              Text(
                                "José Orellana",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5.0,),
                              Text(
                                "Ing. Industrial",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "y Data Scientist",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                                textAlign: TextAlign.center,
                              ),

                            ],
                          ),

                        ],
                      ),
                      SizedBox(height: 35.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Image(
                              image: AssetImage("assets/imageRoger.jpeg"),
                              width: 100.0,
                              height: 100.0,
                            ),
                            padding: EdgeInsets.all(15.0),

                          ),
                          Column(
                            children: [
                              Text(
                                "Roger Cedillo",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5.0,),
                              Text(
                                "Ing. Industrial",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "y procesos productivos",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                                textAlign: TextAlign.center,
                              ),

                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0,),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
