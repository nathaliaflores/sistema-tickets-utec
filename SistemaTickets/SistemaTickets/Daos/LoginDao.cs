using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using SistemaTickets.Connection;
using SistemaTickets.Models;

namespace SistemaTickets.Daos {
    public class LoginDao : Conexion {

        public UsuarioLogin ObtenerUsuarioLogin(string usuario, string password) {

            UsuarioLogin usuarioLogin = null;

            try {

                abrirConexion();
                command = new SqlCommand("sp_obtener_usuario_login", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;
                command.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
                command.Connection = connection;
                reader = command.ExecuteReader();

                while (reader.Read()) {
                    usuarioLogin = new UsuarioLogin();
                    usuarioLogin.IdUsuario = (int) reader.GetValue(reader.GetOrdinal("id_usuario"));
                    usuarioLogin.Usuario = (string) reader.GetValue(reader.GetOrdinal("usuario"));
                    usuarioLogin.Nombres = (string) reader.GetValue(reader.GetOrdinal("nombres"));
                    usuarioLogin.Apellidos = (string) reader.GetValue(reader.GetOrdinal("apellidos"));
                    usuarioLogin.Rol = (string) reader.GetValue(reader.GetOrdinal("rol"));
                }

            }
            catch (Exception ex) {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally {
                cerrarConexion();
            }

            return usuarioLogin;

        }

    }
}