using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaTickets.Models {
    public class Rol {
        public Rol() { }
        public int IdRol { get; set; }
        public String Nombre { get; set; }
        public bool Activo { get; set; }
        public int IdUsuarioMod { get; set; }
        public DateTime FechaMod { get; set; }
    }
}