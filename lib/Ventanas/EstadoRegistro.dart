import 'package:control_de_calidad/Providers/BDpreformasIPS.dart';
import 'package:control_de_calidad/Providers/Providerids.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/form_coloranteips.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_datosiniciales.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenEstadoRegistros extends StatelessWidget {
  const ScreenEstadoRegistros({super.key});

  @override
  Widget build(BuildContext context) {
    final providerregistro = Provider.of<IdsProvider>(context);
    final providerIPS = Provider.of<DatosProviderPrefIPS>(context);
    final providerdatosips= Provider.of<RegistroIPSProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Estado de Registros'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade100,

        elevation: 0,
        actions: [           
    IconButton(
      icon: const Icon(Icons.picture_as_pdf),
      tooltip: 'Generar PDF',
     onPressed: () {
      providerIPS.finishProcess();
      print("se booro");
        
        
      },
    ),
  ],
          
        
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent.shade100, Colors.blue.shade200],
              ),
            ),
            child: const Text(
              'En esta sección se supervisa y controla el estado de los registros, permitiendo su apertura y cierre según el proceso',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: providerregistro.idsRegistrosList.length,
              itemBuilder: (context, index) {
                final datos = providerregistro.idsRegistrosList[index];

                final List<Map<String, dynamic>> defectDescriptions = [
                  {
                    'title': 'IPS-400',
                    'description': 'Preformas IPS(Pequeñas)',
                    'color': Colors.teal,
                  },
                  {
                    'title': 'I5',
                    'description': 'Preformas I5(Grandes)',
                    'color': Colors.indigo,
                  },
                  {
                    'title': 'CCM',
                    'description': 'Tapas 2,5 cm',
                    'color': Colors.deepPurple,
                  },
                  {
                    'title': 'COLORACAP',
                    'description': 'Impresion de Tapas',
                    'color': Colors.brown,
                  },
                  {
                    'title': 'YUTZUMI',
                    'description': 'Botellas',
                    'color': Colors.deepOrange,
                  },
                  {
                    'title': 'IT 2 HX-258',
                    'description': 'Tapas Bidon',
                    'color': Colors.green,
                  },
                  {
                    'title': 'SOPLADO',
                    'description': 'Tapas 6 cm y Azas',
                    'color': Colors.blueGrey,
                  },
                ];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: defectDescriptions[index]['color'],
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            datos.estado ? Colors.white : Colors.black26,
                        child: Icon(
                          datos.estado
                              ? Icons.edit_note_rounded
                              : Icons.edit_off,
                          color: defectDescriptions[index]['color'],
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              defectDescriptions[index]['title'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: datos.estado
                                    ? Colors.white
                                    : Colors.black26,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              defectDescriptions[index]['description'],
                              style: TextStyle(
                                fontSize: 14,
                                color: datos.estado
                                    ? Colors.white
                                    : Colors.black26,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Builder(
                        builder: (context) => ElevatedButton(
                          onPressed: () async {
                            if (!datos.estado) {
                              // Estado es false, intentamos abrir y obtener un ID con el método adecuado
                              try {
                                int messageId;

                                // Seleccionamos el método adecuado según el índice
                                switch (index) {
                                  case 0:
                                    messageId =
                                        await providerregistro.createRegistroIPS();
                                    break;
                                  case 1:
                                    messageId = 20;
                                    break;
                                  case 2:
                                    messageId = 60;
                                    break;
                                  case 3:
                                    messageId = 40;
                                    break;
                                  case 4:
                                    messageId = 50;
                                    break;
                                  case 5:
                                    messageId = 60;
                                    break;
                                  case 6:
                                    messageId = 70;
                                    break;
                                  default:
                                    throw Exception("Índice fuera de rango");
                                }

                                if (context.mounted) {
                                  final updatedDatito = datos.copyWith(
                                    numero: messageId, // Guarda el ID obtenido
                                    estado:
                                        true, // Cambia el estado a "abierto"
                                  );

                                  providerregistro.updateDatito(
                                      datos.id!, updatedDatito);
                                }
                              } catch (e) {
                                                              if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Error al abrir: $e')),
                                  );
                                }
                              }
                            } else {
                              // Estado es true, mostramos una alerta de confirmación antes de cerrar
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirmación"),
                                    content: const Text(
                                        "¿Está seguro de que desea cerrar este registro?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Cerrar el diálogo sin hacer nada
                                        },
                                        child: const Text("Cancelar"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Llamar un método diferente de providerIPS según el índice
                                          switch (index) {
                                            case 0:
                                              providerIPS.finishProcess();                                          
                                              providerdatosips.clearData();                                              break;
                                            case 1:
                                              //providerIPS.finishProcessI5();
                                              break;
                                            case 2:
                                              //providerIPS.finishProcessCCM();
                                              break;
                                            case 3:
                                              //providerIPS.finishProcessColoracap();
                                              break;
                                            case 4:
                                              //providerIPS.finishProcessYutzumi();
                                              break;
                                            case 5:
                                              //providerIPS.finishProcessIT2HX258();
                                              break;
                                            case 6:
                                              //providerIPS.finishProcessSoplado();
                                              break;
                                            default:
                                              //providerIPS.finishProcess();
                                              break;
                                          }
                                          Navigator.of(context).pop();
                                          final updatedDatito = datos.copyWith(
                                            estado: false, // Cambia a "cerrado"
                                          );
                                          providerregistro.updateDatito(
                                              datos.id!, updatedDatito);
                                        },
                                        child: const Text("Cerrar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: defectDescriptions[index]['color'],
                          ),
                          child: Text(datos.estado ? 'Cerrar' : 'Abrir'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
