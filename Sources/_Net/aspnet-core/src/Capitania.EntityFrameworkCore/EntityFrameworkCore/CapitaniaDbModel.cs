namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class CapitaniaDbModel : DbContext
    {
        public CapitaniaDbModel()
            : base("name=CapitaniaDbModel")
        {
        }

        public virtual DbSet<TConfiguracao.TConfiguracao> Configuracoes { get; set; }
        public virtual DbSet<TPOSICLAYOUT2> TPOSICLAYOUT2 { get; set; }
        public virtual DbSet<TAKA> TAKA { get; set; }
        public virtual DbSet<TBookRegra> TBookRegra { get; set; }
        public virtual DbSet<TCNPJNome> TCNPJNome { get; set; }
        public virtual DbSet<TCTPT> TCTPT { get; set; }
        public virtual DbSet<TFluxos> TFluxos { get; set; }
        public virtual DbSet<TFundos> TFundos { get; set; }
        public virtual DbSet<THistLimCr> THistLimCr { get; set; }
        public virtual DbSet<TPapel> TPapel { get; set; }
        public virtual DbSet<TPropriedades> TPropriedades { get; set; }
        public virtual DbSet<TProvFilter.TProvFilter> TProvFilter { get; set; }
        public virtual DbSet<TPTCDETAIL> TPTCDETAIL { get; set; }
        public virtual DbSet<TRegras> TRegras { get; set; }
        public virtual DbSet<TResgates> TResgates { get; set; }
        public virtual DbSet<TRiskClass> TRiskClass { get; set; }
        public virtual DbSet<TRuleBooks> TRuleBooks { get; set; }
        public virtual DbSet<TTrades> TTrades { get; set; }
        public virtual DbSet<TTransfers> TTransfers { get; set; }
        public virtual DbSet<TUsers> TUsers { get; set; }
        public virtual DbSet<TPosic> TPosic { get; set; }
        public virtual DbSet<TFACTORHIST> TFACTORHIST { get; set; }
        public virtual DbSet<TPricing> TPricing { get; set; }
        public virtual DbSet<TADTV> TADTV { get; set; }
        public virtual DbSet<TLOG> TLOG { get; set; }
        public virtual DbSet<TLOGERRO> TLOGERRO { get; set; }
        public virtual DbSet<TLOGPERF> TLOGPERF { get; set; }
        public virtual DbSet<THistImportReport> THistImportReport { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<TCNPJNome>()
                .Property(e => e.CNPJ)
                .IsUnicode(false);

            modelBuilder.Entity<TCNPJNome>()
                .Property(e => e.NOMECREDITO)
                .IsUnicode(false);

            modelBuilder.Entity<TFluxos>()
                .Property(e => e.IDFLUXO)
                .IsUnicode(false);

            modelBuilder.Entity<TFundos>()
                .Property(e => e.CNPJ)
                .IsUnicode(false);

            modelBuilder.Entity<TPapel>()
                .Property(e => e.Nome)
                .IsUnicode(false);

            modelBuilder.Entity<TPapel>()
                .Property(e => e.ID)
                .IsUnicode(false);

            modelBuilder.Entity<TPapel>()
                .Property(e => e.CODCETIP)
                .IsUnicode(false);

            modelBuilder.Entity<TPapel>()
                .Property(e => e.Class_Liq)
                .IsUnicode(false);

            modelBuilder.Entity<TPapel>()
                .Property(e => e.Class_Rentab)
                .IsUnicode(false);

            modelBuilder.Entity<TPapel>()
                .Property(e => e.CashFlow_ID)
                .IsUnicode(false);

            modelBuilder.Entity<TPapel>()
                .Property(e => e.ISIN)
                .IsUnicode(false);

            modelBuilder.Entity<TResgates>()
                .Property(e => e.FUNDO)
                .IsUnicode(false);
        }
    }
}
