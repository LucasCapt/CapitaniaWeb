namespace Capitania.Importer
{
    partial class ServiceImporterInstaller
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.ServiceImporterProcessInstaller = new System.ServiceProcess.ServiceProcessInstaller();
            this.ServiceImporterInstallerManager = new System.ServiceProcess.ServiceInstaller();
            // 
            // ServiceImporterProcessInstaller
            // 
            this.ServiceImporterProcessInstaller.Password = null;
            this.ServiceImporterProcessInstaller.Username = null;
            // 
            // ServiceImporterInstallerManager
            // 
            this.ServiceImporterInstallerManager.Description = "Serviço Importador Xml Anbima";
            this.ServiceImporterInstallerManager.DisplayName = "Capitânia Importer Xml Anbima";
            this.ServiceImporterInstallerManager.ServiceName = "Capitania.Importer";
            // 
            // ServiceImporterInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.ServiceImporterProcessInstaller,
            this.ServiceImporterInstallerManager});

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller ServiceImporterProcessInstaller;
        private System.ServiceProcess.ServiceInstaller ServiceImporterInstallerManager;
    }
}