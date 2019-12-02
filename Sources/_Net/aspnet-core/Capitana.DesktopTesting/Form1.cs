using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Capitana.DesktopTesting
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnResgates_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarResgates();
        }

        private void btnRiskSeries_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarSeriesDeRisco();
        }

        private void btnMaxCotistas_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarMaiorCotistas();
        }

        private void btnTrades_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarTrades();
        }

        private void btnPricing_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarPrincing();
        }

        private void btnADTV_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarADTV();
        }
    }
}
