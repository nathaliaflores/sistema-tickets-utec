using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using SistemaTickets.Connection;
using SistemaTickets.Models;

namespace SistemaTickets.Daos {
    public class EstadoDao : Conexion {

        // OBTENER TODOS LOS ESTADOS
        public List<Estado> ObtenerEstados()
        {

            List<Estado> estados = new List<Estado>();
            Estado estado = null;

            try
            {

                abrirConexion();
                command = new SqlCommand("sp_obtener_estados", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = connection;
                reader = command.ExecuteReader();

                while (reader.Read())
                {
                    int i = 0;

                    estado = new Estado();
                    estado.IdEstado = (int)reader.GetValue(reader.GetOrdinal("id_estado"));
                    estado.Nombre = (string)reader.GetValue(reader.GetOrdinal("nombre"));
                    estado.Activo = "S".Equals((string)reader.GetValue(reader.GetOrdinal("activo")));
                    estado.IdUsuarioMod = (int)reader.GetValue(reader.GetOrdinal("id_usuario_mod"));
                    estado.FechaMod = (DateTime)reader.GetValue(reader.GetOrdinal("fecha_mod"));
                    estados.Add(estado);
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally
            {
                cerrarConexion();
            }

            return estados;

        }

        // OBTENER ESTADO POR ID
        public Estado ObtenerEstadoPorId(int id)
        {

            Estado estado = null;

            try
            {

                abrirConexion();
                command = new SqlCommand("sp_obtener_estado_por_id", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_estado", SqlDbType.Int).Value = id;
                command.Connection = connection;
                reader = command.ExecuteReader();
                
                while (reader.Read())
                {
                    int i = 0;

                    estado = new Estado();
                    estado.IdEstado = (int)reader.GetValue(reader.GetOrdinal("id_estado"));
                    estado.Nombre = (string)reader.GetValue(reader.GetOrdinal("nombre"));
                    estado.Activo = "S".Equals((string)reader.GetValue(reader.GetOrdinal("activo")));
                    estado.IdUsuarioMod = (int)reader.GetValue(reader.GetOrdinal("id_usuario_mod"));
                    estado.FechaMod = (DateTime)reader.GetValue(reader.GetOrdinal("fecha_mod"));
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally
            {
                cerrarConexion();
            }

            return estado;

        }

        // REGISTRAR ESTADO
        public void RegistrarEstado(Estado estado)
        {

            try
            {

                abrirConexion();
                command = new SqlCommand("sp_registrar_estado", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@nombre", SqlDbType.VarChar).Value = estado.Nombre;
                command.Parameters.Add("@id_usuario_mod", SqlDbType.Int).Value = estado.IdUsuarioMod;
                command.Connection = connection;
                command.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally
            {
                cerrarConexion();
            }

        }

        // MODIFICAR ESTADO
        public void ModificarEstado(Estado estado)
        {

            try
            {

                abrirConexion();
                command = new SqlCommand("sp_modificar_estado", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_rol", SqlDbType.Int).Value = estado.IdEstado;
                command.Parameters.Add("@nombre", SqlDbType.VarChar).Value = estado.Nombre;
                command.Parameters.Add("@activo", SqlDbType.Char).Value = estado.Activo == true ? "S" : "N";
                command.Parameters.Add("@id_usuario_mod", SqlDbType.Int).Value = estado.IdUsuarioMod;

                command.Connection = connection;
                command.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally
            {
                cerrarConexion();
            }

        }

        // ACTIVAR O INACTIVAR ESTADO
        public void ActInaEstado(int id)
        {

            try
            {

                abrirConexion();
                command = new SqlCommand("sp_act_ina_estado", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_estado", SqlDbType.Int).Value = id;

                command.Connection = connection;
                command.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            finally
            {
                cerrarConexion();
            }

        }

    }
}