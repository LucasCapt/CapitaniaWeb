using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.Importer
{
    public partial class ServiceImporter : ServiceBase
    {
        public ServiceImporter()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            Capitania.Importer.Library.ImporterManager.Initialize();
        }

        protected override void OnStop()
        {
            Capitania.Importer.Library.ImporterManager.Dispose();
        }
    }
}
