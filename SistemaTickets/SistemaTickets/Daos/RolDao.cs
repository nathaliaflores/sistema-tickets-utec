using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using SistemaTickets.Connection;
using SistemaTickets.Models;

namespace SistemaTickets.Daos {
    public class RolDao : Conexion {

        // OBTENER TODOS
        public List<Rol> ObtenerRoles() {

            List<Rol> roles = new List<Rol>();
            Rol rol = null;

            try {

                abrirConexion();
                command = new SqlCommand("sp_obtener_roles", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = connection;
                reader = command.ExecuteReader();

                while (reader.Read()) {               
                    int i = 0;

                    rol = new Rol();
                    rol.IdRol = reader.GetInt32(i++);
                    rol.Nombre = reader.GetString(i++);
                    rol.Activo = "S".Equals(reader.GetString(i++)) ? true : false;
                    rol.IdUsuarioMod = reader.GetInt32(i++);
                    rol.FechaMod = reader.GetDateTime(i++);
                    roles.Add(rol);
                }   

            }
            catch (Exception ex) {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally {
                cerrarConexion();
            }

            return roles;

        }

        // OBTENER UNO POR ID
        public Rol ObtenerRolPorId(int id) {

            Rol rol = null;

            try {

                abrirConexion();
                command = new SqlCommand("sp_obtener_rol_por_id", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_rol", SqlDbType.Int).Value = id;
                command.Connection = connection;
                reader = command.ExecuteReader();
                //cmd.ExecuteNonQuery(); para insertar

                while (reader.Read()) {
                    int i = 0;

                    rol = new Rol();
                    rol.IdRol = reader.GetInt32(i++);
                    rol.Nombre = reader.GetString(i++);
                    rol.Activo = "S".Equals(reader.GetString(i++)) ? true : false;
                    rol.IdUsuarioMod = reader.GetInt32(i++);
                    rol.FechaMod = reader.GetDateTime(i++);
                }

            }
            catch (Exception ex) {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally {
                cerrarConexion();
            }

            return rol;

        }

        // REGISTRAR
        public void RegistrarRol(Rol rol) {

            try {

                abrirConexion();
                command = new SqlCommand("sp_registrar_rol", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@nombre", SqlDbType.VarChar).Value = rol.Nombre;
                command.Parameters.Add("@id_usuario_mod", SqlDbType.Int).Value = rol.IdUsuarioMod;
                command.Connection = connection;
                command.ExecuteNonQuery();

            }
            catch (Exception ex) {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally {
                cerrarConexion();
            }

        }

        // MODIFICAR
        public void ModificarRol(Rol rol) {

            try {

                abrirConexion();
                command = new SqlCommand("sp_modificar_rol", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_rol", SqlDbType.Int).Value = rol.IdRol;
                command.Parameters.Add("@nombre", SqlDbType.VarChar).Value = rol.Nombre;
                command.Parameters.Add("@activo", SqlDbType.Char).Value = rol.Activo == true ? "S" : "N";
                command.Parameters.Add("@id_usuario_mod", SqlDbType.Int).Value = rol.IdUsuarioMod;

                command.Connection = connection;
                command.ExecuteNonQuery(); 

            }
            catch (Exception ex) {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally {
                cerrarConexion();
            }

        }

        // ACTIVAR O INACTIVAR
        public void ActInaRol(int id) {

            try {

                abrirConexion();
                command = new SqlCommand("sp_act_ina_rol", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_rol", SqlDbType.Int).Value = id;

                command.Connection = connection;
                command.ExecuteNonQuery();

            }
            catch (Exception ex) {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally {
                cerrarConexion();
            }

        }

    }
}