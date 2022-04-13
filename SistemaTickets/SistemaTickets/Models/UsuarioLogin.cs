using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaTickets.Models {
    public class UsuarioLogin {
        public UsuarioLogin() { }
        public int IdUsuario { get; set; }
        public string Usuario { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Rol { get; set; }
    }
}