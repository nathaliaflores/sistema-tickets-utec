using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SistemaTickets.Daos;
using SistemaTickets.Models;

namespace SistemaTickets.Controllers {
    public class RolesController : Controller {

        private RolDao rolDao;
        public RolesController() {
            this.rolDao = new RolDao();
        }

        // GET: Roles
        [HttpGet]
        public ActionResult Index() {
            List<Rol> roles = rolDao.ObtenerRoles();
            return View(roles);
        }

        // GET: Roles/RegistrarForm
        [HttpGet]
        public ActionResult RegistrarForm() {
            return View();
        }

        // POST: Roles/Registrar
        [HttpPost]
        public ActionResult Registrar(Rol rol) {
            
            try {
                rol.IdUsuarioMod = rol.IdUsuarioMod == 0 ? 1 : rol.IdUsuarioMod;
                rolDao.RegistrarRol(rol);
                return RedirectToAction("Index");
            }
            catch {
                return View();
            }
        }

        // GET: Roles/ModificarForm
        [HttpGet]
        public ActionResult ModificarForm(int id) {
            Rol rol = new Rol();
            rol = rolDao.ObtenerRolPorId(id);
            return View(rol);
        }

        // POST: Roles/Modificar
        [HttpPost]
        public ActionResult Modificar(Rol rol) {
            
            try {
                rol.IdUsuarioMod = rol.IdUsuarioMod == 0 ? 1 : rol.IdUsuarioMod;
                rolDao.ModificarRol(rol);

                return RedirectToAction("Index");
            }
            catch {
                return View();
            }
        }

        // GET: Roles/ActIna
        [HttpGet]
        public ActionResult ActIna(int id) {
            Rol rol = new Rol();

            try {

                rolDao.ActInaRol(id);

                return RedirectToAction("Index");
            }
            catch {
                return View();
            }
        }
    }
}
