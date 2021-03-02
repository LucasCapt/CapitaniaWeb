using log4net;
using log4net.Config;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.LogManager
{
    public class Manager
    {
        #region Log4Net

        private static ILog log;
        private static bool initialized = false;

        public static void Initialize()
        {
            try
            {
                XmlConfigurator.Configure();
                initialized = true;
            }
            catch (Exception ex)
            {

            }
        }

        private static void CheckInitialization()
        {
            if (!initialized)
                Manager.Initialize();
        }

        public static void LogError(string message, Exception exception)
        {
            try
            {
                CheckInitialization();
                log = log4net.LogManager.GetLogger("MAIN");
                log.Error(message, exception);
            }
            catch (Exception ex)
            {

            }
        }

        public static void LogError(string message, Type sourceType, Exception exception)
        {
            try
            {
                CheckInitialization();
                log = log4net.LogManager.GetLogger("MAIN");
                log.Error(string.Format("{0} - {1}", sourceType.Name, message), exception);
            }
            catch (Exception ex)
            {
            }
        }

        public static void LogError(string message, Type sourceType, string exceptionDetails)
        {
            Manager.LogError(message, sourceType, new Exception(exceptionDetails));
        }

        public static void LogTrace(string registerName, string message)
        {
            LogTrace(registerName, message, null);
        }

        public static void LogTrace(string registerName, string message, Type sourceType)
        {
            try
            {
                CheckInitialization();
                log = log4net.LogManager.GetLogger(registerName);

                if (sourceType != null)
                    log.Info(string.Format("{0} - {1}", sourceType.Name, message));
                else
                    log.Info(message);
            }
            catch (Exception ex)
            {

            }
        }

        public static void LogTrace(string message, Type sourceType)
        {
            try
            {
                CheckInitialization();
                log = log4net.LogManager.GetLogger("MAIN");
                log.Info(string.Format("{0} - {1}", sourceType.Name, message));
            }
            catch (Exception ex)
            {
            }
        }

        #endregion

        #region Log Capitânia

        #region Error

        public static void WriteLogError(string ErrMsg, string ErrItem, string userName)
        {
            using (SqlConnection vConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
            {
                vConnection.Open();
                Manager.WriteLogError(vConnection, ErrMsg, ErrItem, userName);
            }
        }

        public static void WriteLogError(SqlConnection sqlConection, string ErrMsg, string ErrItem, string userName)
        {

            using (SqlTransaction vTransaction = sqlConection.BeginTransaction(System.Data.IsolationLevel.RepeatableRead))
            {
                Manager.WriteLogError(sqlConection, vTransaction, ErrMsg, ErrItem, userName);
                vTransaction.Commit();
            }
        }

        public static void WriteLogError(SqlConnection sqlConection, SqlTransaction sqlTransaction, string ErrMsg, string ErrItem, string userName)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("insert into TLOGERRO (DATAHORA, MSGERRO, ITEM, [USER]) VALUES(");
            vSQL.AppendLine(String.Format("'{0}',", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
            vSQL.AppendLine(String.Format("'{0}',", ErrMsg));
            vSQL.AppendLine(String.Format("'{0}',", ErrItem));
            vSQL.AppendLine(String.Format("'{0}')", userName));

            using (SqlCommand vCommand = new SqlCommand(vSQL.ToString(), sqlConection, sqlTransaction))
            {
                vCommand.ExecuteNonQuery();
            }
        }

        #endregion

        #region Trace
        public static void WriteLog(string acao, string userName)
        {
            using (SqlConnection vConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
            {
                vConnection.Open();
                Manager.WriteLog(vConnection, acao, userName);
            }
        }

        public static void WriteLog(SqlConnection sqlConection, string acao, string userName)
        {

            using (SqlTransaction vTransaction = sqlConection.BeginTransaction(System.Data.IsolationLevel.RepeatableRead))
            {
                Manager.WriteLog(sqlConection, vTransaction, acao, userName);
                vTransaction.Commit();
            }
        }

        public static void WriteLog(SqlConnection sqlConection, SqlTransaction sqlTransaction, string acao, string userName)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("INSERT INTO TLOG (DATAHORA, ACAO, [USER], COMPUTER) VALUES(");
            vSQL.AppendLine(String.Format("'{0}',", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
            vSQL.AppendLine(String.Format("'{0}',", acao));
            vSQL.AppendLine(String.Format("'{0}',", userName));
            vSQL.AppendLine(String.Format("'{0}')", Environment.MachineName));

            using (SqlCommand vCommand = new SqlCommand(vSQL.ToString(), sqlConection, sqlTransaction))
            {
                vCommand.ExecuteNonQuery();
            }
        }
        #endregion

        #region Performance
        public static void WriteLogPerformance(string acao, long itensProcessados, string userName, double segundos)
        {
            using (SqlConnection vConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
            {
                vConnection.Open();
                Manager.WriteLogPerformance(vConnection, acao, itensProcessados, userName, segundos);
            }
        }

        public static void WriteLogPerformance(SqlConnection sqlConection, string acao, long itensProcessados, string userName, double segundos)
        {

            using (SqlTransaction vTransaction = sqlConection.BeginTransaction(System.Data.IsolationLevel.RepeatableRead))
            {
                Manager.WriteLogPerformance(sqlConection, vTransaction, acao, itensProcessados, userName, segundos);
                vTransaction.Commit();
            }
        }

        public static void WriteLogPerformance(SqlConnection sqlConection, SqlTransaction sqlTransaction, string acao, long itensProcessados, string userName, double segundos)
        {
            StringBuilder vSQL = new StringBuilder();
            double vItensPorSegundo = 0;
            double vSegundosPorItem = 0;
            if (segundos > 0)
                vItensPorSegundo = itensProcessados / segundos;
            if (itensProcessados > 0)
                vSegundosPorItem = segundos / itensProcessados;

            vSQL.AppendLine("INSERT INTO TLOGPERF (DATAHORA, OPER, [USER], ITENS, SECS, ITEMPERSEC, SECPERITEM) VALUES (");
            vSQL.AppendLine(String.Format("'{0}',", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
            vSQL.AppendLine(String.Format("'{0}',", acao));
            vSQL.AppendLine(String.Format("'{0}',", userName));
            vSQL.AppendLine(String.Format("{0},", itensProcessados));
            vSQL.AppendLine(String.Format("{0},", segundos));
            vSQL.AppendLine(String.Format("{0},", vItensPorSegundo));
            vSQL.AppendLine(String.Format("{0})", vSegundosPorItem));

            using (SqlCommand vCommand = new SqlCommand(vSQL.ToString(), sqlConection, sqlTransaction))
            {
                vCommand.ExecuteNonQuery();
            }
        }
        #endregion

        #endregion
    }
}
