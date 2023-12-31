﻿namespace Capitania.Importer.Planilhas
{
    partial class ServiceImporterSheet
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
            this.ServiceImporterShhetProcessInstaller = new System.ServiceProcess.ServiceProcessInstaller();
            this.ServiceImporterSheetInstaller = new System.ServiceProcess.ServiceInstaller();
            // 
            // ServiceImporterShhetProcessInstaller
            // 
            this.ServiceImporterShhetProcessInstaller.Password = null;
            this.ServiceImporterShhetProcessInstaller.Username = null;
            // 
            // ServiceImporterSheetInstaller
            // 
            this.ServiceImporterSheetInstaller.Description = "Importador de planilhas para compliance.";
            this.ServiceImporterSheetInstaller.DisplayName = "Capitânia - Importador de Planilhas";
            this.ServiceImporterSheetInstaller.ServiceName = "Capitania.Importer.PLanilha";
            this.ServiceImporterSheetInstaller.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            // 
            // ServiceImporterSheet
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.ServiceImporterShhetProcessInstaller,
            this.ServiceImporterSheetInstaller});

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller ServiceImporterShhetProcessInstaller;
        private System.ServiceProcess.ServiceInstaller ServiceImporterSheetInstaller;
    }
}