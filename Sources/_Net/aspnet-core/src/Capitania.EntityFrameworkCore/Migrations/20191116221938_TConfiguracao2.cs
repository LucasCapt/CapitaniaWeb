using Microsoft.EntityFrameworkCore.Migrations;

namespace Capitania.Migrations
{
    public partial class TConfiguracao2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "TConfiguracao",
                columns: table => new
                {
                    cfg_param = table.Column<string>(nullable: false),
                    Id = table.Column<string>(nullable: true),
                    cfg_descricao = table.Column<string>(nullable: true),
                    cfg_valor = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TConfiguracao", x => x.cfg_param);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TConfiguracao");
        }
    }
}
