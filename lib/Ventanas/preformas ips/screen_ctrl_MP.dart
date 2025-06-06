import 'package:control_de_calidad/Providers/BDpreformasIPS.dart';
import 'package:control_de_calidad/Providers/Providerids.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/formulariocolorante.dart';
import 'package:control_de_calidad/widgets/Alertas.dart';
import 'package:control_de_calidad/widgets/boton_agregar.dart';
import 'package:control_de_calidad/widgets/boton_guardar.dart';
import 'package:control_de_calidad/widgets/boxformularios.dart';
import 'package:control_de_calidad/widgets/checkboxformulario.dart';
import 'package:control_de_calidad/widgets/dropdownformulario.dart';
import 'package:control_de_calidad/widgets/textsimpleform.dart';
import 'package:control_de_calidad/widgets/titulos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/form_coloranteips.dart';

class DatosMPIPS {
  final int? id;
  final bool hasErrors;
  final bool hasSend;
  final int idregistro;
  final String MateriPrima;
  final String INTF;
  final String CantidadEmpaque;
  final String Identif;
  final int CantidadBolsones;
  final double Dosificacion;
  final double Humedad;
  final bool Conformidad;

  // Constructor de la clase
  const DatosMPIPS({
    this.id,
    required this.hasErrors,
    required this.hasSend,
    required this.idregistro,
    required this.MateriPrima,
    required this.INTF,
    required this.CantidadEmpaque,
    required this.Identif,
    required this.CantidadBolsones,
    required this.Dosificacion,
    required this.Humedad,
    required this.Conformidad
  });

  // Factory para crear una instancia desde un Map
  factory DatosMPIPS.fromJson(Map<String, dynamic> map) {
    return DatosMPIPS(
      id: map['id'] as int?,
      hasErrors: map['hasErrors'] == false,
      hasSend: map['hasSend'] == false,
      idregistro: map['idregistro'] as int,
      MateriPrima: map['MateriPrima'] as String,
      INTF: map['INTF'] as String,
      CantidadEmpaque: map['CantidadEmpaque'] as String,
      Identif: map['Identif'] as String,
      CantidadBolsones: map['CantidadBolsones'] as int,
      Dosificacion: map['Dosificacion'] as double,
      Humedad: map['Humedad'] as double,
      Conformidad: (map['Conformidad'] as int) == 1
    );
  }

  factory DatosMPIPS.fromMap(Map<String, dynamic> map) {
    return DatosMPIPS(
      id: map['id'] as int?,
      hasErrors: map['hasErrors'] == 1,
      hasSend: map['hasSend'] == 1,
      idregistro: map['idregistro'] as int,
      MateriPrima: map['MateriPrima'] as String,
      INTF: map['INTF'] as String,
      CantidadEmpaque: map['CantidadEmpaque'] as String,
      Identif: map['Identif'] as String,
      CantidadBolsones: map['CantidadBolsones'] as int,
      Dosificacion: map['Dosificacion'] as double,
      Humedad: map['Humedad'] as double,
      Conformidad: (map['Conformidad'] as int) == 1
    );
  }

  // Método para convertir la instancia a Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'hasErrors': hasErrors ? 1 : 0,
      'hasSend': hasSend ? 1 : 0,
      'idregistro': idregistro,
      'MateriPrima': MateriPrima,
      'INTF': INTF,
      'CantidadEmpaque': CantidadEmpaque,
      'Identif': Identif,
      'CantidadBolsones': CantidadBolsones,
      'Dosificacion': Dosificacion,
      'Humedad': Humedad,
      'Conformidad': Conformidad ? 1 : 0
    };
  }

  // Método copyWith
  DatosMPIPS copyWith({
    int? id,
    bool? hasErrors,
    bool? hasSend,
    int? idregistro,
    String? MateriPrima, String? INTF, String? CantidadEmpaque, String? Identif, int? CantidadBolsones, double? Dosificacion, double? Humedad, bool? Conformidad
  }) {
    return DatosMPIPS(
      id: id ?? this.id,
      hasErrors: hasErrors ?? this.hasErrors,
      hasSend: hasSend ?? this.hasSend,
      idregistro: idregistro ?? this.idregistro,
      MateriPrima: MateriPrima ?? this.MateriPrima,
      INTF: INTF ?? this.INTF,
      CantidadEmpaque: CantidadEmpaque ?? this.CantidadEmpaque,
      Identif: Identif ?? this.Identif,
      CantidadBolsones: CantidadBolsones ?? this.CantidadBolsones,
      Dosificacion: Dosificacion ?? this.Dosificacion,
      Humedad: Humedad ?? this.Humedad,
      Conformidad: Conformidad ?? this.Conformidad
    );
  }
}

class ScreenListDatosMPIPS extends StatefulWidget {
  @override
  State<ScreenListDatosMPIPS> createState() => _ScreenListDatosMPIPSState();
}

class _ScreenListDatosMPIPSState extends State<ScreenListDatosMPIPS> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final providerregistro = Provider.of<IdsProvider>(context, listen: false);
    
    final datoscoloranteips = provider.datoscoloranteipsList;   
    return Scaffold(
      body: Column(
        children: [
          const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  '¿Se tiene una mezcla con \ncolorante o aditivo?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleSwitch(
                  customWidths: [120.0, 70.0],
                  cornerRadius: 20.0,
                  minHeight: 50,
                  fontSize: 25,
                  iconSize: 30,
                  activeBgColors: [
                    [!datoscoloranteips[0].hasSend ? const Color.fromARGB(255, 100, 145, 224) : Colors.green],
                    [Colors.redAccent]
                  ],
                  activeFgColor: Colors.black,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.black,
                  totalSwitches: 2,
                  labels: ['SI', ''],
                  icons: [null, Icons.close],
                  onToggle: (index) {
                    if (index == 0 && !datoscoloranteips[0].hasSend ) {                                    

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDatosColoranteIPSForm(
                              id: 1,
                              DatoscoloranteIPS: datoscoloranteips[0],
                            ),
                          ),
                        );                  

                    }
                  },
                ),
              ],
            ),      

          
          Titulos(
            titulo: 'REGISTRO',
            tipo: 0,            
          ),
          Expanded(
            child: Consumer<DatosProviderPrefIPS>(
              builder: (context, provider, _) {
                final datosmpips = provider.datosmpipsList;

                if (datosmpips.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay registros aún.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: datosmpips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final dtdatosmpips = datosmpips[index];

                    return GradientExpandableCard(
                      idlista: dtdatosmpips.id,
                      numeroindex: (index + 1).toString(),
                      onSwipedAction: () async {
                        await provider.removeDatosMPIPS(context, dtdatosmpips.id!);
                      },                      
                      titulo: 'Materia Prima',
                      subtitulos: {
                        '': dtdatosmpips.MateriPrima,                        
                        'Conformidad': dtdatosmpips.Conformidad ? 'SI' : 'NO',
                      },
                      expandedContent: generateExpandableContent([
                        ['INTF: ', 1, dtdatosmpips.INTF],
                        ['CantidadEmpaque: ', 1, dtdatosmpips.CantidadEmpaque],
                        ['Identif: ', 1, dtdatosmpips.Identif],
                        ['CantidadBolsones: ', 1, dtdatosmpips.CantidadBolsones.toString()],
                        ['Dosificacion: ', 1, dtdatosmpips.Dosificacion.toString()],
                        ['Humedad: ', 1, dtdatosmpips.Humedad.toString()],                        
                      ]),
                      hasErrors: dtdatosmpips.hasErrors,
                      hasSend: dtdatosmpips.hasSend,
                      onOpenModal: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDatosMPIPSForm(
                              id: dtdatosmpips.id!,
                              datosMpIps: dtdatosmpips,
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
  } provider.addDatosMPIPS(DatosMPIPS(
    hasErrors: true,
    hasSend: false,
    idregistro: idregistro,  // Ya sabemos que no es 0 ni null
              MateriPrima: 'JADE CZ 328A',
              INTF: ' ',
              CantidadEmpaque: '1100Kg',
              Identif: ' ',
              CantidadBolsones: 1,
              Dosificacion: 0,
              Humedad: 0,
              Conformidad: true,
  ));
},
      ),);
    
  }

  void _showBottomSheet() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(top: 5, left: 16, right: 16),
        height: 370,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))
        ),
        child: FormularioColoranteIPS(),
      );
    },
  );
}

}


class EditProviderDatosMPIPS with ChangeNotifier {
  // Implementación del proveedor, puedes agregar lógica específica aquí
}

class EditDatosMPIPSForm extends StatefulWidget {
  final int id;
  final DatosMPIPS datosMpIps;

  const EditDatosMPIPSForm({required this.id, required this.datosMpIps, Key? key})
      : super(key: key);

  @override
  _EditDatosMPIPSFormState createState() => _EditDatosMPIPSFormState();
}

class _EditDatosMPIPSFormState extends State<EditDatosMPIPSForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  // Mapa para las opciones de Dropdowns
  final Map<String, List<dynamic>> dropOptionsDatosMPIPS = {
     'MateriaPrima': [
      'JADE CZ 328A',
      'EASTLON CB 612',
      'ECOPET',
      'RAMAPET',
      'OCTAL',
      'SKY PET',
      'CR-BRIGHT',
      'MOLIDO',
      'WANKAY',
    ],
    'CantidadEmapque': ['1100Kg'],
    'CantidadBolsones': [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
    ],
  };

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
    return ChangeNotifierProvider(
      create: (_) => EditProviderDatosMPIPS(),
      child: Consumer<EditProviderDatosMPIPS>(
        builder: (context, provider, child) {
          return Scaffold(
          body: Column(
              children:[
               Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FormularioGeneralDatosMPIPS(
              formKey: _formKey,
              
              widget: widget,
              dropOptions: dropOptionsDatosMPIPS,
            ),),),),

           BotonDeslizable(
  onPressed: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();

    await provider.updateDatosMPIPS(widget.id, updatedDatito);
    Navigator.pop(context);
  },
  onSwipedAction: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();

    await provider.updateDatosMPIPS(widget.id, updatedDatito);

    bool enviado = await provider.enviarDatosAPIDatosMPIPS(widget.id);

    if (!enviado) {
    EnviadoDialog.mostrar(context, false);

     
    } else {
      final updatedDatitoEnviado = obtenerDatosActualizados(hasSend: true);
      await provider.updateDatosMPIPS(widget.id, updatedDatitoEnviado);
      EnviadoDialog.mostrar(context, true);
      Navigator.pop(context);
    }
  
  },
)        
          ]));
        }
        )
        );
        
  }
  DatosMPIPS obtenerDatosActualizados({bool hasSend = false}) {
  _formKey.currentState?.save();
  final values = _formKey.currentState!.value;
  return widget.datosMpIps.copyWith(
                  hasErrors:_formKey.currentState?.fields.values.any((field) => field.hasError) ?? false,
                   hasSend: hasSend,
                  MateriPrima: values['MateriPrima'] ?? widget.datosMpIps.MateriPrima,
                  INTF: values['INTF'] ?? widget.datosMpIps.INTF,
                  CantidadEmpaque: values['CantidadEmpaque'] ?? widget.datosMpIps.CantidadEmpaque,
                  Identif: values['Identif'] ?? widget.datosMpIps.Identif,
                  CantidadBolsones: (values['CantidadBolsones'] == null || values['CantidadBolsones'].toString().isEmpty)     ? 0 
    : int.tryParse(values['CantidadBolsones'].toString()) ?? 0,       
                  Dosificacion:(values['Dosificacion']?.isEmpty ?? true)? 0 : double.tryParse(values['Dosificacion']),
                  Humedad:(values['Humedad']?.isEmpty ?? true)? 0 : double.tryParse(values['Humedad']),
                  Conformidad: values['Conformidad'] ?? widget.datosMpIps.Conformidad,

                );

}
  
}

class FormularioGeneralDatosMPIPS extends StatelessWidget {
  const FormularioGeneralDatosMPIPS({
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
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [

          DropdownSimple(
            name: 'MateriPrima',
            label: 'Materiprima',
            textoError: 'Selecciona',
            valorInicial: widget.datosMpIps.MateriPrima,
            opciones: 'MateriaPrima',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['MateriPrima'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),

          CustomInputField(
              name: 'INTF',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['INTF'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Intf',
              valorInicial: widget.datosMpIps.INTF.toString(),
              isRequired: true,),

          DropdownSimple(
            name: 'CantidadEmpaque',
            label: 'Cantidadempaque',
            textoError: 'Selecciona',
            valorInicial: widget.datosMpIps.CantidadEmpaque,
            opciones: 'CantidadEmapque',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['CantidadEmpaque'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),

          CustomInputField(
              name: 'Identif',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Identif'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Identif',
              valorInicial: widget.datosMpIps.Identif.toString(),
              isRequired: true,
              isNumeric: false,),

          DropdownSimple<dynamic>(
            name: 'CantidadBolsones',
            label: 'Cantidad de bolsones',
            textoError: 'Selecciona',
            valorInicial: widget.datosMpIps.CantidadBolsones,
            opciones: 'CantidadBolsones',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['CantidadBolsones'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),

          CustomInputField(
              name: 'Dosificacion',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Dosificacion'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Dosificacion [%]',
              valorInicial: widget.datosMpIps.Dosificacion.toString(),
              isNumeric: true,
              isRequired: true,
              max: 100,
              min: 0,),

          CustomInputField(
              name: 'Humedad [%]',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Humedad'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Humedad',
              valorInicial: widget.datosMpIps.Humedad.toString(),
              isNumeric: true,
              isRequired: true,),         
          CheckboxSimple(
            label: 'Conformidad',
            name: 'Conformidad',
            valorInicial: widget.datosMpIps.Conformidad,
          ),

    ]
      ),
    );
  }
}