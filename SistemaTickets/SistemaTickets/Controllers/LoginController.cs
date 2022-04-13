using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SistemaTickets.Models;
using SistemaTickets.Daos;

namespace SistemaTickets.Controllers
{
    public class LoginController : Controller {

        private LoginDao loginDao;
        public LoginController() {
            this.loginDao = new LoginDao();
        }

        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult IniciarSesion(LoginRequest loginRequest) {

            try {

                UsuarioLogin usuarioLogin = loginDao.ObtenerUsuarioLogin(loginRequest.Usuario, loginRequest.Password);
                Session["usuario"] = usuarioLogin.Usuario;
                Session["rol"] = usuarioLogin.Rol;
                return RedirectToAction("Index", "Home");
            }
            catch {
                return View();
            }
        }

        [HttpGet]
        public ActionResult CerrarSesion() {

            try {
                Session.Abandon();
                return RedirectToAction("Index");
            }
            catch {
                return View();
            }
        }
    }
}