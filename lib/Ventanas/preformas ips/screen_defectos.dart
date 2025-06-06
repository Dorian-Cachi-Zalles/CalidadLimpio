import 'package:control_de_calidad/Providers/BDpreformasIPS.dart';
import 'package:control_de_calidad/Providers/Providerids.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/widget_defectosips.dart';
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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class DatosDEFIPS {
  final int? id;
  final bool hasErrors;
  final bool hasSend;
  final int idregistro;
  final String Hora;
  final List<String> Defectos;
  final List<String> Criticidad;
  final String CSeccionDefecto;
  final int DefectosEncontrados;
  final String Fase;
  final bool Palet;
  final bool Empaque;
  final bool Embalado;
  final bool Etiquetado;
  final bool Inocuidad;
  final double CantidadProductoRetenido;
  final double CantidadProductoCorregido;
  final String? Observaciones;

  // Constructor de la clase
  const DatosDEFIPS({
    this.id,
    required this.hasErrors,
    required this.hasSend,
    required this.idregistro,
    required this.Hora,
    required this.Defectos,
    required this.Criticidad,
    required this.CSeccionDefecto,
    required this.DefectosEncontrados,
    required this.Fase,
    required this.Palet,
    required this.Empaque,
    required this.Embalado,
    required this.Etiquetado,
    required this.Inocuidad,
    required this.CantidadProductoRetenido,
    required this.CantidadProductoCorregido,
    this.Observaciones
  });

  // Factory para crear una instancia desde un Map
  factory DatosDEFIPS.fromMap(Map<String, dynamic> map) {
    return DatosDEFIPS(
      id: map['id'] as int?,
      hasErrors: map['hasErrors'] == 1,
      hasSend: map['hasSend'] == 1,
      idregistro: map['idregistro'] as int,
      Hora: map['Hora'] as String,
        Defectos: (map['Defectos'] as String?)
                  ?.split(',')
                  .where((item) => item.isNotEmpty)
                  .toList() ??
              [],
        Criticidad: (map['Criticidad'] as String?)
                ?.split(',')
                .where((item) => item.isNotEmpty)
                .toList() ??
            [],
      CSeccionDefecto: map['CSeccionDefecto'] as String,
      DefectosEncontrados: map['DefectosEncontrados'] as int,
      Fase: map['Fase'] as String,
      Palet: (map['Palet'] as int) == 1,
      Empaque: (map['Empaque'] as int) == 1,
      Embalado: (map['Embalado'] as int) == 1,
      Etiquetado: (map['Etiquetado'] as int) == 1,
      Inocuidad: (map['Inocuidad'] as int) == 1,
      CantidadProductoRetenido: map['CantidadProductoRetenido'] as double,
      CantidadProductoCorregido: map['CantidadProductoCorregido'] as double,
      Observaciones: map['Observaciones'] as String?
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
      'Defectos': Defectos.join(','),
      'Criticidad': Criticidad.join(','),
      'CSeccionDefecto': CSeccionDefecto,
      'DefectosEncontrados': DefectosEncontrados,
      'Fase': Fase,
      'Palet': Palet ? 1 : 0,
      'Empaque': Empaque ? 1 : 0,
      'Embalado': Embalado ? 1 : 0,
      'Etiquetado': Etiquetado ? 1 : 0,
      'Inocuidad': Inocuidad ? 1 : 0,
      'CantidadProductoRetenido': CantidadProductoRetenido,
      'CantidadProductoCorregido': CantidadProductoCorregido,
      'Observaciones': Observaciones
    };
  }

  // Método copyWith
  DatosDEFIPS copyWith({
    int? id,
    bool? hasErrors,
    bool? hasSend,
    int? idregistro,
    String? Hora, List<String>? Defectos, List<String>? Criticidad, String? CSeccionDefecto, int? DefectosEncontrados, String? Fase, bool? Palet, bool? Empaque, bool? Embalado, bool? Etiquetado, bool? Inocuidad, double? CantidadProductoRetenido, double? CantidadProductoCorregido, String? Observaciones
  }) {
    return DatosDEFIPS(
      id: id ?? this.id,
      hasErrors: hasErrors ?? this.hasErrors,
      hasSend: hasSend ?? this.hasSend,
      idregistro: idregistro ?? this.idregistro,
      Hora: Hora ?? this.Hora,
      Defectos: Defectos ?? this.Defectos,
      Criticidad: Criticidad ?? this.Criticidad,
      CSeccionDefecto: CSeccionDefecto ?? this.CSeccionDefecto,
      DefectosEncontrados: DefectosEncontrados ?? this.DefectosEncontrados,
      Fase: Fase ?? this.Fase,
      Palet: Palet ?? this.Palet,
      Empaque: Empaque ?? this.Empaque,
      Embalado: Embalado ?? this.Embalado,
      Etiquetado: Etiquetado ?? this.Etiquetado,
      Inocuidad: Inocuidad ?? this.Inocuidad,
      CantidadProductoRetenido: CantidadProductoRetenido ?? this.CantidadProductoRetenido,
      CantidadProductoCorregido: CantidadProductoCorregido ?? this.CantidadProductoCorregido,
      Observaciones: Observaciones ?? this.Observaciones
    );
  }
}



class ScreenListDatosDEFIPS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final providerregistro = Provider.of<IdsProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Titulos(
            titulo: 'REGISTRO',
            tipo: 0,
            
          ),
          Expanded(
            child: Consumer<DatosProviderPrefIPS>(
              builder: (context, provider, _) {
                final datosdefips = provider.datosdefipsList;

                if (datosdefips.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay registros aún.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: datosdefips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final dtdatosdefips = datosdefips[index];

                    return GradientExpandableCard(
                      hasSend: dtdatosdefips.hasSend,
                      idlista: dtdatosdefips.id,
                      numeroindex: (index + 1).toString(),
                      onSwipedAction: () async {
                        await provider.removeDatosDEFIPS(context, dtdatosdefips.id!);
                      },
                      
                      subtitulos: {'Hora': dtdatosdefips.Hora, },
                      expandedContent: generateExpandableContent([
                        ['Defectos: ', 2, dtdatosdefips.Defectos],
                        ['Criticidad: ', 2, dtdatosdefips.Criticidad],                      
                        ['CSeccionDefecto: ', 1, dtdatosdefips.CSeccionDefecto],
                        ['DefectosEncontrados: ', 1, dtdatosdefips.DefectosEncontrados.toString()],
                        ['Fase: ', 1, dtdatosdefips.Fase],
                        ['Palet: ', 5, dtdatosdefips.Palet],
                        ['Empaque: ', 5, dtdatosdefips.Empaque],
                        ['Embalado: ', 5, dtdatosdefips.Embalado],
                        ['Etiquetado: ', 5, dtdatosdefips.Etiquetado],
                        ['Inocuidad: ', 5, dtdatosdefips.Inocuidad],
                        ['CantidadProductoRetenido: ', 1, dtdatosdefips.CantidadProductoRetenido.toString()],
                        ['CantidadProductoCorregido: ', 1, dtdatosdefips.CantidadProductoCorregido.toString()],
                        ['Observaciones: ', 1, dtdatosdefips.Observaciones],
                      ]),
                      hasErrors: dtdatosdefips.hasErrors,
                      onOpenModal: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDatosDEFIPSForm(
                              id: dtdatosdefips.id!,
                              datosDefIps: dtdatosdefips,
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
  } provider.addDatosDEFIPS(DatosDEFIPS(
    hasErrors: true,
    hasSend: false,
    idregistro: idregistro,  // Ya sabemos que no es 0 ni null
              Hora: DateFormat('HH:mm').format(DateTime.now()),
              Defectos: [],
              Criticidad: [],
              CSeccionDefecto: 'Al inicio',
              DefectosEncontrados: 0,
              Fase: 'Fase 1',
              Palet: true,
              Empaque: true,
              Embalado: true,
              Etiquetado: true,
              Inocuidad: true,
              CantidadProductoRetenido: 0,
              CantidadProductoCorregido: 0,
              Observaciones: ' ',
  ));
},
      ),
    );
  }
}


class EditProviderDatosDEFIPS with ChangeNotifier {
  // Implementación del proveedor, puedes agregar lógica específica aquí
}

class EditDatosDEFIPSForm extends StatefulWidget {
  final int id;
  final DatosDEFIPS datosDefIps;

  const EditDatosDEFIPSForm({required this.id, required this.datosDefIps, Key? key})
      : super(key: key);

  @override
  _EditDatosDEFIPSFormState createState() => _EditDatosDEFIPSFormState();
}

class _EditDatosDEFIPSFormState extends State<EditDatosDEFIPSForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  // Mapa para las opciones de Dropdowns
  final Map<String, List<dynamic>> dropOptionsDatosDEFIPS = {
    'Secciones': ['Al inicio', 'Medio', 'Final'],
    'Ffase': ['Fase 1', 'Fase 2', 'Fase 3',],
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
      create: (_) => EditProviderDatosDEFIPS(),
      child: Consumer<EditProviderDatosDEFIPS>(
        builder: (context, provider, child) {
          return Scaffold(
          body: Column(
              children:[
               Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FormularioGeneralDatosDEFIPS(
              formKey: _formKey,
              widget: widget,
              dropOptions: dropOptionsDatosDEFIPS,
              id: widget.id,
            ),),),),
            BotonDeslizable(
  onPressed: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();

    await provider.updateDatosDEFIPS(widget.id, updatedDatito);
    Navigator.pop(context);
  },
  onSwipedAction: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();

    await provider.updateDatosDEFIPS(widget.id, updatedDatito);

    bool enviado = await provider.enviarDatosAPIDatosDEFIPS(widget.id);

    if (!enviado) {
    EnviadoDialog.mostrar(context, false);
     
    } else {
      final updatedDatitoEnviado = obtenerDatosActualizados(hasSend: true);
      await provider.updateDatosDEFIPS(widget.id, updatedDatitoEnviado);
     EnviadoDialog.mostrar(context, true);
      Navigator.pop(context);
    }
  },
),
         
          ]));
        }));
  }
DatosDEFIPS obtenerDatosActualizados({bool hasSend = false}) {
  _formKey.currentState?.save();
  final values = _formKey.currentState!.value;

  return
                widget.datosDefIps.copyWith(
                hasErrors:_formKey.currentState?.fields.values.any((field) => field.hasError) ?? false,
                 hasSend: hasSend,
                  Hora: values['Hora'] ?? widget.datosDefIps.Hora,                
                  CSeccionDefecto: values['CSeccionDefecto'] ?? widget.datosDefIps.CSeccionDefecto,
                  DefectosEncontrados:(values['DefectosEncontrados']?.isEmpty ?? true)? 0 : int.tryParse(values['DefectosEncontrados']),
                  Fase: values['Fase'] ?? widget.datosDefIps.Fase,
                  Palet: values['Palet'] ?? widget.datosDefIps.Palet,
                  Empaque: values['Empaque'] ?? widget.datosDefIps.Empaque,
                  Embalado: values['Embalado'] ?? widget.datosDefIps.Embalado,
                  Etiquetado: values['Etiquetado'] ?? widget.datosDefIps.Etiquetado,
                  Inocuidad: values['Inocuidad'] ?? widget.datosDefIps.Inocuidad,
                  CantidadProductoRetenido:(values['CantidadProductoRetenido']?.isEmpty ?? true)? 0 : double.tryParse(values['CantidadProductoRetenido']),
                  CantidadProductoCorregido:(values['CantidadProductoCorregido']?.isEmpty ?? true)? 0 : double.tryParse(values['CantidadProductoCorregido']),
                  Observaciones: values['Observaciones'] ?? widget.datosDefIps.Observaciones,

                );

}
}

class FormularioGeneralDatosDEFIPS extends StatelessWidget {
  const FormularioGeneralDatosDEFIPS({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required this.widget,
    required this.dropOptions, required this.id,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;
  final widget;
  final Map<String, List<dynamic>> dropOptions;
  final int id;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
           DefectosScreenWidget(
            id: id,
          ),
          CustomInputField(
              name: 'Hora',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Hora'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Hora',
              isNumeric: false,
              valorInicial: widget.datosDefIps.Hora,
              isRequired: true,),                       
          DropdownSimple(
            name: 'CSeccionDefecto',
            label: 'Ubicacion del Defecto',
            textoError: 'Selecciona',
            valorInicial: widget.datosDefIps.CSeccionDefecto,
            opciones: 'Secciones',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['CSeccionDefecto'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),

        CustomInputField(
              name: 'DefectosEncontrados',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Hora'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Defectos Encontrados',
              isNumeric: true,
              valorInicial: widget.datosDefIps.DefectosEncontrados.toString(),
              isRequired: true,),

          DropdownSimple(
            name: 'Fase',
            label: 'Fase',
            textoError: 'Selecciona',
            valorInicial: widget.datosDefIps.Fase,
            opciones: 'Ffase',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['Fase'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),
           SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      for (var item in [
        {'label': 'Palet', 'name': 'Palet', 'value': widget.datosDefIps.Palet},
        {'label': 'Empaque', 'name': 'Empaque', 'value': widget.datosDefIps.Empaque},
        {'label': 'Embalado', 'name': 'Embalado', 'value': widget.datosDefIps.Embalado},
        {'label': 'Etiquetado', 'name': 'Etiquetado', 'value': widget.datosDefIps.Etiquetado},
        {'label': 'Inocuidad', 'name': 'Inocuidad', 'value': widget.datosDefIps.Inocuidad},
      ])
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            width: 170,
            height: 80,
            padding: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: 
                CheckboxSimple(
                  name: item['name']!,
                  valorInicial: item['value']!, // Asegurar tipo booleano
                  label: item['label']!, // Usar 'label' en lugar de item['']
                  onChanged: (value) {
                    final field = _formKey.currentState?.fields[item['name']];
                    if (field != null) {
                      field.validate(); // Valida solo este campo
                      field.save();
                    }
                  },
                ),            
            ),
        ),
    ],
  ),
),
          CustomInputField(
              name: 'CantidadProductoRetenido',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['CantidadProductoRetenido'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Cantidad producto retenido',
              valorInicial: widget.datosDefIps.CantidadProductoRetenido.toString(),
              isRequired: true,
              isNumeric: true,),

         CustomInputField(
              name: 'CantidadProductoCorregido',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['CantidadProductoCorregido'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Cantidad producto corregido',
              valorInicial: widget.datosDefIps.CantidadProductoCorregido.toString(),
              isRequired: true,
              isNumeric: true,),

          CustomInputField(
              name: 'Observaciones',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Observaciones'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Observaciones',
              valorInicial: widget.datosDefIps.Observaciones,
              isNumeric: false,
              isRequired: false,
              ),

    ]
      ),
    );
  }
}