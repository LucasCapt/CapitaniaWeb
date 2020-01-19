using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration.Install;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Importer.Planilhas
{
    [RunInstaller(true)]
    public partial class ServiceImporterSheet : System.Configuration.Install.Installer
    {
        public ServiceImporterSheet()
        {
            InitializeComponent();
        }
    }
}
