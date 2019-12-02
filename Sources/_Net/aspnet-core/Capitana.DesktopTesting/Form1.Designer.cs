namespace Capitana.DesktopTesting
{
    partial class Form1
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnResgates = new System.Windows.Forms.Button();
            this.btnRiskSeries = new System.Windows.Forms.Button();
            this.btnMaxCotistas = new System.Windows.Forms.Button();
            this.btnTrades = new System.Windows.Forms.Button();
            this.btnPricing = new System.Windows.Forms.Button();
            this.btnADTV = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnResgates
            // 
            this.btnResgates.Location = new System.Drawing.Point(100, 42);
            this.btnResgates.Name = "btnResgates";
            this.btnResgates.Size = new System.Drawing.Size(75, 23);
            this.btnResgates.TabIndex = 0;
            this.btnResgates.Text = "Resgates";
            this.btnResgates.UseVisualStyleBackColor = true;
            this.btnResgates.Click += new System.EventHandler(this.btnResgates_Click);
            // 
            // btnRiskSeries
            // 
            this.btnRiskSeries.Location = new System.Drawing.Point(100, 71);
            this.btnRiskSeries.Name = "btnRiskSeries";
            this.btnRiskSeries.Size = new System.Drawing.Size(75, 23);
            this.btnRiskSeries.TabIndex = 1;
            this.btnRiskSeries.Text = "RiskSeries";
            this.btnRiskSeries.UseVisualStyleBackColor = true;
            this.btnRiskSeries.Click += new System.EventHandler(this.btnRiskSeries_Click);
            // 
            // btnMaxCotistas
            // 
            this.btnMaxCotistas.Location = new System.Drawing.Point(100, 100);
            this.btnMaxCotistas.Name = "btnMaxCotistas";
            this.btnMaxCotistas.Size = new System.Drawing.Size(75, 23);
            this.btnMaxCotistas.TabIndex = 2;
            this.btnMaxCotistas.Text = "MaxCotistas";
            this.btnMaxCotistas.UseVisualStyleBackColor = true;
            this.btnMaxCotistas.Click += new System.EventHandler(this.btnMaxCotistas_Click);
            // 
            // btnTrades
            // 
            this.btnTrades.Location = new System.Drawing.Point(100, 129);
            this.btnTrades.Name = "btnTrades";
            this.btnTrades.Size = new System.Drawing.Size(75, 23);
            this.btnTrades.TabIndex = 3;
            this.btnTrades.Text = "Trades";
            this.btnTrades.UseVisualStyleBackColor = true;
            this.btnTrades.Click += new System.EventHandler(this.btnTrades_Click);
            // 
            // btnPricing
            // 
            this.btnPricing.Location = new System.Drawing.Point(100, 158);
            this.btnPricing.Name = "btnPricing";
            this.btnPricing.Size = new System.Drawing.Size(75, 23);
            this.btnPricing.TabIndex = 4;
            this.btnPricing.Text = "Pricing";
            this.btnPricing.UseVisualStyleBackColor = true;
            this.btnPricing.Click += new System.EventHandler(this.btnPricing_Click);
            // 
            // btnADTV
            // 
            this.btnADTV.Location = new System.Drawing.Point(100, 187);
            this.btnADTV.Name = "btnADTV";
            this.btnADTV.Size = new System.Drawing.Size(75, 23);
            this.btnADTV.TabIndex = 5;
            this.btnADTV.Text = "ADTV";
            this.btnADTV.UseVisualStyleBackColor = true;
            this.btnADTV.Click += new System.EventHandler(this.btnADTV_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btnADTV);
            this.Controls.Add(this.btnPricing);
            this.Controls.Add(this.btnTrades);
            this.Controls.Add(this.btnMaxCotistas);
            this.Controls.Add(this.btnRiskSeries);
            this.Controls.Add(this.btnResgates);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnResgates;
        private System.Windows.Forms.Button btnRiskSeries;
        private System.Windows.Forms.Button btnMaxCotistas;
        private System.Windows.Forms.Button btnTrades;
        private System.Windows.Forms.Button btnPricing;
        private System.Windows.Forms.Button btnADTV;
    }
}

