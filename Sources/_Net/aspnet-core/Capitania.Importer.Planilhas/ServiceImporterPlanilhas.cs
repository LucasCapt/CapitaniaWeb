using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.Importer.Planilhas
{
    public partial class ServiceImporterPlanilhas : ServiceBase
    {
        private System.Timers.Timer vTimer;
        public ServiceImporterPlanilhas()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            Capitania.Importer.Library.ImporterManager.InitializeSheetImporter();
            vTimer = new System.Timers.Timer(Capitania.Importer.Library.ImporterManager.GetTimerIntervalForSheetProcessing());
            vTimer.AutoReset = true;
            vTimer.Elapsed += VTimer_Elapsed;
            this.vTimer.Start();
        }

        private void VTimer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            this.vTimer.Stop();

            Capitania.Importer.Library.ImporterManager.ImportarResgates();
            Capitania.Importer.Library.ImporterManager.ImportarSeriesDeRisco();
            Capitania.Importer.Library.ImporterManager.ImportarMaiorCotistas();
            Capitania.Importer.Library.ImporterManager.ImportarTrades();
            Capitania.Importer.Library.ImporterManager.ImportarPrincing();
            Capitania.Importer.Library.ImporterManager.ImportarADTV();

            this.vTimer.Start();
        }

        protected override void OnStop()
        {
            this.vTimer.Stop();
        }
    }
}
