﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Capitania
{
    public static class GeneralHelper
    {
        public static string ConnectionString = @"data source=s14;initial catalog=db_capitania_prd;persist security info=True;user id=sa;password=DS!2002nt;MultipleActiveResultSets=True;App=EntityFramework";
        //public static string ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Default"].ConnectionString;
        //public static string ConnectionString = "data source=.;initial catalog=db_capitania_prd;Trusted_Connection=True;";

        private static List<T> DataReaderMapToList<T>(IDataReader dr)
        {
            List<T> list = new List<T>();
            T obj = default(T);
            while (dr.Read())
            {
                obj = Activator.CreateInstance<T>();
                foreach (PropertyInfo prop in obj.GetType().GetProperties())
                {
                    if (!object.Equals(dr[prop.Name], DBNull.Value))
                    {
                        prop.SetValue(obj, dr[prop.Name], null);
                    }
                }
                list.Add(obj);
            }
            return list;
        }

        public static List<T> GetData<T>(string sql)
        {
            List<T> vDados;
            using (SqlConnection vConection = new SqlConnection(GeneralHelper.ConnectionString))
            {
                vConection.Open();
                using (SqlCommand vComando = new SqlCommand(sql, vConection))
                {
                    using (SqlDataReader vReader = vComando.ExecuteReader())
                    {
                        vDados = GeneralHelper.DataReaderMapToList<T>(vReader);
                    }
                }
                vConection.Close();
            }

            return vDados;
        }

        public static int GetCount(string sql)
        {
            int vRetorno;
            using (SqlConnection vConection = new SqlConnection(GeneralHelper.ConnectionString))
            {
                vConection.Open();
                using (SqlCommand vComando = new SqlCommand(sql, vConection))
                {
                    using (SqlDataReader vReader = vComando.ExecuteReader())
                    {
                        vRetorno = vReader.GetInt32(0);
                    }
                }
                vConection.Close();
            }

            return vRetorno;
        }
    }
}
