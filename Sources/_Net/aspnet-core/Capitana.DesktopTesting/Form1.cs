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
            //this.btnADTV.Enabled = false;
            //this.btnMaxCotistas.Enabled = false;
            //this.btnPricing.Enabled = false;
            //this.btnTrades.Enabled = false;
        }

        private void btnResgates_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarResgates();
            MessageBox.Show("Importação de resgates concluída");
        }

        private void btnRiskSeries_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarSeriesDeRisco();
            MessageBox.Show("Importação de riscos concluída");
        }

        private void btnMaxCotistas_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarMaiorCotistas();
            MessageBox.Show("Importação de cotistas concluída");
        }

        private void btnTrades_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarTrades();
            MessageBox.Show("Importação de trades concluída");
        }

        private void btnPricing_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarPrincing();
            MessageBox.Show("Importação de pricing concluída");
        }

        private void btnADTV_Click(object sender, EventArgs e)
        {
            Capitania.Importer.Library.ImporterManager.ImportarADTV();
            MessageBox.Show("Importação de ADTV concluída");
        }
    }
}
