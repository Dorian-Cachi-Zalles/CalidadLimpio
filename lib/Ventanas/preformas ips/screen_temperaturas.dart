import 'package:control_de_calidad/Configuraciones/catalogodropdowns.dart';
import 'package:control_de_calidad/Providers/ProviderI6.dart';
import 'package:control_de_calidad/Providers/Providerids.dart';
import 'package:control_de_calidad/widgets/Alertas.dart';
import 'package:control_de_calidad/widgets/boton_agregar.dart';
import 'package:control_de_calidad/widgets/boton_guardar.dart';
import 'package:control_de_calidad/widgets/boxformularios.dart';
import 'package:control_de_calidad/widgets/dropdownformulario.dart';
import 'package:control_de_calidad/widgets/textsimpleform.dart';
import 'package:control_de_calidad/widgets/titulos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class DatosTEMPIPS {
  final int? id;
  final bool hasErrors;
  final bool hasSend;
  final int idregistro;
  final String Hora;
  final String Fase;
  final List<int> Cavidades;
  final List<double> Tcuerpo;
  final List<double> Tcuello;

  // Constructor de la clase
  const DatosTEMPIPS({
    this.id,
    required this.hasErrors,
    required this.hasSend,
    required this.idregistro,
    required this.Hora,
    required this.Fase,
    required this.Cavidades,
    required this.Tcuerpo,
    required this.Tcuello
  });

  // Factory para crear una instancia desde un Map
  factory DatosTEMPIPS.fromMap(Map<String, dynamic> map) {
    return DatosTEMPIPS(
      id: map['id'] as int?,
      hasErrors: map['hasErrors'] == 1,
      hasSend: map['hasSend'] == 1,
      idregistro: map['idregistro'] as int,
      Hora: map['Hora'] as String,
      Fase: map['Fase'] as String,
      Cavidades: (map['Cavidades'] as String).split(',').where((item) => item.isNotEmpty).map(int.parse).toList(),
      Tcuerpo: (map['Tcuerpo'] as String).split(',').where((item) => item.isNotEmpty).map(double.parse).toList(),
      Tcuello: (map['Tcuello'] as String).split(',').where((item) => item.isNotEmpty).map(double.parse).toList()
    );
  }

  // Método para convertir la instancia a Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'hasErrors': hasErrors ? 1 : 0,
      'hasSend': hasSend ? 1 : 0,
      'idregistro': idregistro,
      'Hora': Hora,
      'Fase': Fase,
      'Cavidades': Cavidades.join(','),
      'Tcuerpo': Tcuerpo.join(','),
      'Tcuello': Tcuello.join(',')
    };
  }

  // Método copyWith
  DatosTEMPIPS copyWith({
    int? id,
    bool? hasErrors,
    bool? hasSend,
    int? idregistro,
    String? Hora, String? Fase, List<int>? Cavidades, List<double>? Tcuerpo, List<double>? Tcuello
  }) {
    return DatosTEMPIPS(
      id: id ?? this.id,
      hasErrors: hasErrors ?? this.hasErrors,
      hasSend: hasSend ?? this.hasSend,
      idregistro: idregistro ?? this.idregistro,
      Hora: Hora ?? this.Hora,
      Fase: Fase ?? this.Fase,
      Cavidades: Cavidades ?? this.Cavidades,
      Tcuerpo: Tcuerpo ?? this.Tcuerpo,
      Tcuello: Tcuello ?? this.Tcuello
    );
  }
}


class ScreenListDatosTEMPIPS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final providerregistro = Provider.of<IdsProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Titulos(
            titulo: 'REGISTRO TEMPERATURAS\nPREFORMAS',
            tipo: 0,
          ),
          Expanded(
            child: Consumer<DatosProviderPrefIPS>(
              builder: (context, provider, _) {
                final datostempips = provider.datostempipsList;

                if (datostempips.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay registros aún.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: datostempips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final dtdatostempips = datostempips[index];

                    return GradientExpandableCard(
                      idlista: dtdatostempips.id,
                      numeroindex: (index + 1).toString(),
                      onSwipedAction: () async {
                        await provider.removeDatosTEMPIPS(context, dtdatostempips.id!);
                      },
                     
                      subtitulos: {
                         'Hora': dtdatostempips.Hora,
                      },
                      expandedContent: generateExpandableContent([
                        
                        ['Fase: ', 1, dtdatostempips.Fase],
                        ['Cavidades: ', 3, dtdatostempips.Cavidades],
                        ['Tcuerpo: ', 4, dtdatostempips.Tcuerpo],
                        ['Tcuello: ', 4, dtdatostempips.Tcuello],
                      ]),
                      hasErrors: dtdatostempips.hasErrors,
                      hasSend: dtdatostempips.hasSend,
                      onOpenModal: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDatosTEMPIPSForm(
                              id: dtdatostempips.id!,
                              datosTempips: dtdatostempips,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BotonAgregar(
        onPressed: () async {
  int? idregistro = await providerregistro.getNumeroById(1);

  if (idregistro == null || idregistro == 0) {
   
    return; // Detiene la ejecución si el idregistro es 0 o null
  } provider.addDatosTEMPIPS(DatosTEMPIPS(
    hasErrors: true,
    hasSend: false,
    idregistro: idregistro,  // Ya sabemos que no es 0 ni null
                  Hora: DateFormat('HH:mm').format(DateTime.now()),
              Fase: 'Fase 1',
              Cavidades: [0,0,0,0],
              Tcuerpo: [0,0,0,0],
              Tcuello: [0,0,0,0],
            
  ));
},
      ),  
    );
  }
}


    class EditProviderDatosTEMPIPS with ChangeNotifier {
  // Implementación del proveedor, puedes agregar lógica específica aquí
}

class EditDatosTEMPIPSForm extends StatefulWidget {
  final int id;
  final DatosTEMPIPS datosTempips;

  const EditDatosTEMPIPSForm({required this.id, required this.datosTempips, Key? key})
      : super(key: key);

  @override
  _EditDatosTEMPIPSFormState createState() => _EditDatosTEMPIPSFormState();
}

class _EditDatosTEMPIPSFormState extends State<EditDatosTEMPIPSForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  

  @override
  void initState() {
    super.initState();
    // Validación inicial después de la construcción del widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.saveAndValidate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogosProvider = Provider.of<CatalogosProvider>(context);    
  final Map<String, List<dynamic>> dropOptionsDatosTEMPIPS =
        catalogosProvider.getCatalogo('Temperatura');
    return ChangeNotifierProvider(
      create: (_) => EditProviderDatosTEMPIPS(),
      child: Consumer<EditProviderDatosTEMPIPS>(
        builder: (context, provider, child) {
          return Scaffold(
          body: Column(
              children:[
               Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FormularioGeneralDatosTEMPIPS(
              formKey: _formKey,
              widget: widget,
              dropOptions: dropOptionsDatosTEMPIPS,
            ),),),),
             BotonDeslizable(
  onPressed: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();

    await provider.updateDatosTEMPIPS(widget.id, updatedDatito);
    Navigator.pop(context);
  },
  onSwipedAction: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();

    await provider.updateDatosTEMPIPS(widget.id, updatedDatito);

    bool enviado = await provider.enviarDatosAPIDatosTEMPIPS(widget.id);

    if (!enviado) {
      EnviadoDialog.mostrar(context, false);      
    } else {
      final updatedDatitoEnviado = obtenerDatosActualizados(hasSend: true);
      await provider.updateDatosTEMPIPS(widget.id, updatedDatitoEnviado);
       EnviadoDialog.mostrar(context, true); 
      Navigator.pop(context);
    }
  },
),
              
          ]));
        }));
  }
  DatosTEMPIPS obtenerDatosActualizados({bool hasSend = false}) {
  _formKey.currentState?.save();
  final values = _formKey.currentState!.value;
  final Cavidades = List.generate(
                  widget.datosTempips.Cavidades.length,
                  (index) => int.tryParse(values['Cavidades_$index'] ?? '0') ?? 0,
                );
                final Tcuerpo = List.generate(
                  widget.datosTempips.Tcuerpo.length,
                  (index) => double.tryParse(values['Tcuerpo_$index'] ?? '0') ?? 0,
                );
                final Tcuello = List.generate(
                  widget.datosTempips.Tcuello.length,
                  (index) => double.tryParse(values['Tcuello_$index'] ?? '0') ?? 0,
                );

  return
                widget.datosTempips.copyWith(
                hasErrors:_formKey.currentState?.fields.values.any((field) => field.hasError) ?? false,
                 hasSend: hasSend,
                  Hora: values['Hora'] ?? widget.datosTempips.Hora,
                  Fase: values['Fase'] ?? widget.datosTempips.Fase,
                  Cavidades: Cavidades,
                  Tcuerpo: Tcuerpo,
                  Tcuello: Tcuello,

                );

}

}

class FormularioGeneralDatosTEMPIPS extends StatelessWidget {
  const FormularioGeneralDatosTEMPIPS({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required this.widget,
    required this.dropOptions,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;
  final widget;
  final Map<String, List<dynamic>> dropOptions;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          // Campo Hora
          CustomInputField(
            name: 'Hora',
            onChanged: (value) {
              final field = _formKey.currentState?.fields['Hora'];
              field?.validate();
              field?.save();
            },
            label: 'Hora',
            isNumeric: false,
            isreadonly: true,
            isRequired: true,
            valorInicial: widget.datosTempips.Hora,
          ),

          // Dropdown Fase
          DropdownSimple(
            name: 'Fase',
            label: 'Fase',
            textoError: 'Selecciona',
            valorInicial: widget.datosTempips.Fase,
            opciones: 'fase',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['Fase'];
              field?.validate();
              field?.save();
            },
          ),

          const SizedBox(height: 16),
          Align(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: "Tabla Matriz de temperatura\n",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "Primera fila: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "Cavidades\n"),
          TextSpan(
            text: "Segunda fila: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "Temperatura del cuerpo\n"),
          TextSpan(
            text: "Tercera fila: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "Temperatura del cuello"),
        ],
      ),
    ),
  ),
),

          const SizedBox(height: 16),

          // Fila CAVIDADES
          Row(
            children: List.generate(4, (index) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: CustomInputField(
                 name: 'Cavidades_$index',
                  label: 'Cav ${index + 1}',
                  isNumeric: true,
                  isRequired: true,
                  valorInicial: widget.datosTempips.Cavidades[index] == 0
                      ? ''
                      : widget.datosTempips.Cavidades[index].toString(),
                  onChanged: (value) {
                    final field = _formKey.currentState?.fields['Cav_$index'];
                    field?.validate();
                    field?.save();
                  },
                ),
              ),
            )),
          ),

          // Fila TEMP CUERPO
          Row(
            children: List.generate(4, (index) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: CustomInputField(
                  name: 'Tcuerpo_$index',
                  label: 'T.C. ${index + 1}',
                  isNumeric: true,
                  isRequired: true,
                  valorInicial: widget.datosTempips.Tcuerpo[index] == 0
                      ? ''
                      : widget.datosTempips.Tcuerpo[index].toString(),
                  onChanged: (value) {
                    final field = _formKey.currentState?.fields['Tcuerpo_$index'];
                    field?.validate();
                    field?.save();
                  },
                ),
              ),
            )),
          ),

          // Fila TEMP CUELLO
          Row(
            children: List.generate(4, (index) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: CustomInputField(
                  name: 'Tcuello_$index',
                  label: 'T.K. ${index + 1}',
                  isNumeric: true,
                  isRequired: true,
                  valorInicial: widget.datosTempips.Tcuello[index] == 0
                      ? ''
                      : widget.datosTempips.Tcuello[index].toString(),
                  onChanged: (value) {
                    final field = _formKey.currentState?.fields['Tcuello_$index'];
                    field?.validate();
                    field?.save();
                  },
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
