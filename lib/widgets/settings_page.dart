import 'package:control_de_calidad/Configuraciones/catalogodropdowns.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends ChangeNotifier {
  bool _isDarkMode = false;
  double _fontSize = 14.0;

  bool get isDarkMode => _isDarkMode;
  double get fontSize => _fontSize;

  // Método para cambiar el tema
  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners(); // Notificar a todos los listeners sobre el cambio
  }

  // Método para cambiar el tamaño de la fuente
  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners(); // Notificar a todos los listeners sobre el cambio
  }
}

class SettingsProvider extends ChangeNotifier {
  bool _notificationsEnabled = true;
  bool _dataTrackingEnabled = true;
  bool _soundEnabled = true;
  bool _isSpanish = true;
  bool _isDarkMode = false; // ✅ Nuevo: Estado del Modo Oscuro

  bool get notificationsEnabled => _notificationsEnabled;
  bool get dataTrackingEnabled => _dataTrackingEnabled;
  bool get soundEnabled => _soundEnabled;
  bool get isSpanish => _isSpanish;
  bool get isDarkMode => _isDarkMode; // ✅ Getter del Modo Oscuro

  
  SettingsProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    _dataTrackingEnabled = prefs.getBool('dataTrackingEnabled') ?? true;
    _soundEnabled = prefs.getBool('soundEnabled') ?? true;
    _isSpanish = prefs.getBool('isSpanish') ?? true;
    _isDarkMode = prefs.getBool('isDarkMode') ?? false; // ✅ Cargar el modo oscuro
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setBool('dataTrackingEnabled', _dataTrackingEnabled);
    await prefs.setBool('soundEnabled', _soundEnabled);
    await prefs.setBool('isSpanish', _isSpanish);
    await prefs.setBool('isDarkMode', _isDarkMode); // ✅ Guardar el estado del modo oscuro
  }

  void setTheme(bool value) {
    _isDarkMode = value;
    _savePreferences();
    notifyListeners();
  }

  void setNotifications(bool value) {
    _notificationsEnabled = value;
    _savePreferences();
    notifyListeners();
  }

  void setDataTracking(bool value) {
    _dataTrackingEnabled = value;
    _savePreferences();
    notifyListeners();
  }

  void setSound(bool value) {
    _soundEnabled = value;
    _savePreferences();
    notifyListeners();
  }

  void setLanguage(bool value) {
    _isSpanish = value;
    _savePreferences();
    notifyListeners();
  }

  void setFontSize(double size) {
    size = 14.0; // Cambia el tamaño de la fuente según tus necesidades
    notifyListeners(); // Notificar a todos los listeners sobre el cambio
  }
}


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuraciones"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Modo oscuro"),           
            value: settingsProvider.isDarkMode,
            onChanged: (value) {
              settingsProvider.setTheme(value); // ✅ Cambia el tema dinámicamente
            },
          ),
          SwitchListTile(
            title: const Text("Notificaciones"),
            value: settingsProvider.notificationsEnabled,
            onChanged: (value) => settingsProvider.setNotifications(value),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [const Text('Actualizar Listas Desplegables',style: TextStyle(fontSize: 16),),const Spacer(),IconButton(onPressed:() {
                Provider.of<CatalogosProvider>(context, listen: false).actualizarDesdeApi();
              },icon: const Icon(Icons.refresh,color: Colors.black,size: 25))],),
          )
        
        /*  SwitchListTile(
            title: const Text("Seguimiento de datos"),
            value: settingsProvider.dataTrackingEnabled,
            onChanged: (value) => settingsProvider.setDataTracking(value),
          ),
          SwitchListTile(
            title: const Text("Sonido"),
            value: settingsProvider.soundEnabled,
            onChanged: (value) => settingsProvider.setSound(value),
          ),
          SwitchListTile(
            title: const Text("Idioma (Español/English)"),
            value: settingsProvider.isSpanish,
            onChanged: (value) => settingsProvider.setLanguage(value),
          ), */
        ],
      ),
    );
  }
}
