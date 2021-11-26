class Usuario {
  final bool online;
  final String email;
  final String nombre;
  final String uid;

  Usuario(
    {
      this.online = false, 
      this.email = "", 
      this.nombre = "Nombre", 
      this.uid = ""
    }
  );
}