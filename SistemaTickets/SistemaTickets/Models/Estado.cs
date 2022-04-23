using System;


namespace SistemaTickets.Models {
    public class Estado {

        public Estado() { }
        public int IdEstado { get; set; }
        public String Nombre { get; set; }
        public bool Activo { get; set; }
        public int IdUsuarioMod { get; set; }
        public DateTime FechaMod { get; set; }

    }
}