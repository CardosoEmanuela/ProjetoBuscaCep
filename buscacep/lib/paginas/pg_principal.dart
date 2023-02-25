import 'dart:convert';
import 'package:buscacep/util/componentes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
TextEditingController cepController = TextEditingController();
GlobalKey<FormState>formController = GlobalKey<FormState>();

String rua ="Rua:";
String complemento ="Complemento:";
String bairro ="Bairro:";
String cidade ="Cidade:";
String estado ="Estado:";

limparTela(){
  setState(() {
  rua ="Rua:";
  complemento ="Complemento:";
  bairro ="Bairro:";
  cidade ="Cidade:";
  estado ="Estado:";
  formController = GlobalKey<FormState>();
    
  });
}
buscarEndereco() async {
  String url ='https://viacep.com.br/ws/${cepController.text}/json/';
 
  Response resposta = await get(Uri.parse(url));
   print(resposta);
  Map endereco = json.decode(resposta.body);
  setState(() {
    rua = "Rua: ${endereco['logradouro']}";
    complemento = "Complemento ${endereco['complemento']}";
    bairro = "Bairro: ${endereco['bairro']}";
    cidade = "Cidade: ${endereco['localidade']}";
    estado = "Estado: ${endereco['uf']}";
  });
}
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: Componentes().criaAppBar('Viacep', limparTela),
    body: Form(
    key:formController, 
    child: Column(
      children: [
        const SizedBox(height:30),
        Componentes().iconeGrande(),
        Componentes().criaInputTexto(TextInputType.number,'CEP',cepController,'Informe um CEP'),
        Componentes().criaBotao(formController,buscarEndereco(),'Buscar Endereco'),
        Componentes().CredencialContainer(rua,complemento,bairro,cidade,estado),

      ],
    ),)
  );
}
  }
