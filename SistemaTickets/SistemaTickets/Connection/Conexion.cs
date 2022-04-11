using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SistemaTickets.Connection {
    public class Conexion {

        public SqlConnection connection;
        public SqlCommand command;
        public SqlDataReader reader;

        public void abrirConexion() {
            if (connection == null || connection.State == ConnectionState.Closed) {
                string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion_sistema_tickets"].ConnectionString;
                connection = new SqlConnection(cadenaConexion);
                connection.Open();
            }
        }

        public void cerrarConexion() {
            if (connection != null || connection.State == ConnectionState.Open) {
                connection.Close();
            }
        } 
    }
}