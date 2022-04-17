using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SistemaTickets.Models;
using SistemaTickets.Daos;

namespace SistemaTickets.Controllers
{
    public class EstadoController : Controller {

        private EstadoDao estadoDao;
        public EstadoController() {
            this.estadoDao = new EstadoDao;
        }

        // GET: Estados
        [HttpGet]
        public ActionResult Index()
        {
            List<Estado> estados = estadoDao.ObtenerEstados();
            return View(estados);
        }

        
    }
}