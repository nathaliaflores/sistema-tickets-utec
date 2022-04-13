using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaTickets.Models {
    public class LoginRequest {
        public LoginRequest() { }
        public string Usuario { get; set; }
        public string Password { get; set; }
    }
}