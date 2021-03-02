using Abp.Authorization;
using Capitania.Authorization;
using Capitania.EntityFrameworkCore;
using Capitania.Stress.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.Stress
{
    [AbpAuthorize(PermissionNames.Pages_RatingNames)]
    public class StressAppService : CapitaniaAppServiceBase, IStressAppService
    {
        public List<StressDto> ObterStress()
        {
            StringBuilder vSQL = new StringBuilder();
            string vCenarioStress1 = ParameterManager.GetParameterValue(DBParametersConstants.RStress1);
            string vCenarioStress2 = ParameterManager.GetParameterValue(DBParametersConstants.RStress2);
            string vCenarioStress3 = ParameterManager.GetParameterValue(DBParametersConstants.RStress3);
            string vCenarioStress4 = ParameterManager.GetParameterValue(DBParametersConstants.RStress4);
            string vCenarioStress5 = ParameterManager.GetParameterValue(DBParametersConstants.RStress5);

            vSQL.AppendLine("SELECT Fundo, ");
            vSQL.AppendLine(String.Format("       [{0}] as Stress1, ", vCenarioStress1));
            vSQL.AppendLine(String.Format("       [{0}] as Stress2, ", vCenarioStress2));
            vSQL.AppendLine(String.Format("       [{0}] as Stress3, ", vCenarioStress3));
            vSQL.AppendLine(String.Format("       [{0}] as Stress4, ", vCenarioStress4));
            vSQL.AppendLine(String.Format("       [{0}] as Stress5 ", vCenarioStress5));
            vSQL.AppendLine("  FROM ");
            vSQL.AppendLine("       (");
            vSQL.AppendLine("        SELECT DataRun, FUNDO, CENARIO, Stress, S.AREA");
            vSQL.AppendLine("          FROM TFundos as F LEFT OUTER JOIN THistStress as S on F.Nome = S.FUNDO");
            vSQL.AppendLine("         WHERE cenario IN(");
            vSQL.AppendLine(String.Format("                          '{0}', ", vCenarioStress1));
            vSQL.AppendLine(String.Format("                          '{0}', ", vCenarioStress2));
            vSQL.AppendLine(String.Format("                          '{0}', ", vCenarioStress3));
            vSQL.AppendLine(String.Format("                          '{0}', ", vCenarioStress4));
            vSQL.AppendLine(String.Format("                          '{0}') ", vCenarioStress5));
            vSQL.AppendLine("           AND [datarun] in (SELECT MAX([DataRun])");
            vSQL.AppendLine("                               FROM THistStress a");
            vSQL.AppendLine("                              WHERE a.Fundo = S.FUNDO)");
            vSQL.AppendLine("           AND (F.DELETED = 0 OR F.DT_DELETED > GETDATE())");
            vSQL.AppendLine("           AND F.NOME not in ('_CONS_ATIVO','_CONS_TOTAL') ) AS TableData");
            vSQL.AppendLine(" PIVOT(Max(Stress) FOR CENARIO IN (");
            vSQL.AppendLine(String.Format("                                   [{0}], ", vCenarioStress1));
            vSQL.AppendLine(String.Format("                                   [{0}], ", vCenarioStress2));
            vSQL.AppendLine(String.Format("                                   [{0}], ", vCenarioStress3));
            vSQL.AppendLine(String.Format("                                   [{0}], ", vCenarioStress4));
            vSQL.AppendLine(String.Format("                                   [{0}])) AS PivotTable ", vCenarioStress5));

            return GeneralHelper.GetData<StressDto>(vSQL.ToString());
        }
    }
}
