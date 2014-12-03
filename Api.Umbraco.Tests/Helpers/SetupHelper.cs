using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data.SqlServerCe;
using System.IO;
using System.Linq;
using System.Reflection;
using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Sdk.Sfc;
using Microsoft.SqlServer.Management.Smo;
using Umbraco.Core;
using Database = PetaPoco.Database;

namespace Api.Umbraco.Tests.Helpers
{
    public static class SetupHelper
    {
        private static string CalculateSqlPath()
        {
            string dbDest = Path.Combine(
                AppDomain.CurrentDomain.BaseDirectory,
                "Databases",
                "BuildDatabase.sql"
            );
            return Path.GetFullPath(dbDest);
        }

        public static void LoadAppConfig()
        {
            var config = Directory.GetFiles(".", "*.dll.config").First();
            AppDomain.CurrentDomain.SetData("APP_CONFIG_FILE", config);
            typeof(ConfigurationManager)
                .GetField("s_initState", BindingFlags.NonPublic |
                                         BindingFlags.Static)
                .SetValue(null, 0);

            typeof(ConfigurationManager)
                .GetField("s_configSystem", BindingFlags.NonPublic |
                                            BindingFlags.Static)
                .SetValue(null, null);

            typeof(ConfigurationManager)
                .Assembly.GetTypes()
                .Where(x => x.FullName ==
                            "System.Configuration.ClientConfigPaths")
                .First()
                .GetField("s_current", BindingFlags.NonPublic |
                                       BindingFlags.Static)
                .SetValue(null, null);
        }

        public static void PrepareDatabase()
        {

            using (var dbClient = new Database("Test.Db"))
            {
                dbClient.OpenSharedConnection();
                DropDatabase(dbClient);
                CreateDatabase(dbClient);
                dbClient.CloseSharedConnection();
            }
        }

        private static void CreateDatabase(Database dbClient)
        {
            var sqlScriptLines = File.ReadAllLines(CalculateSqlPath()).ToList();
            sqlScriptLines.RemoveAll(line => line.StartsWith("--"));
            sqlScriptLines.RemoveAll(String.IsNullOrWhiteSpace);

            var sqlScript = String.Join(Environment.NewLine, sqlScriptLines);
            var sqlBlocks = (sqlScript + Environment.NewLine)
                .Split(new [] {");" + Environment.NewLine}, StringSplitOptions.RemoveEmptyEntries)
                .Select(block => block + ");");
            foreach (var sqlBlock in sqlBlocks)
            {
                using (var command = dbClient.Connection.CreateCommand())
                {
                    command.CommandText = sqlBlock.Trim();
                    command.ExecuteNonQuery();
                }
            }
        }

        private static void DropDatabase(Database dbClient)
        {
            var tables = dbClient
                .Query<string>("select table_name from information_schema.tables where TABLE_TYPE <> 'VIEW'")
                .ToList();

            while (tables.Any())
            {
                for (var i = 0; i < tables.Count; i++)
                {
                    var dropTable = "DROP TABLE " + tables[i];

                    try
                    {
                        using (var command = dbClient.Connection.CreateCommand())
                        {
                            command.CommandText = dropTable;
                            command.ExecuteNonQuery();
                        }
                        tables.Remove(tables[i]);
                    }
                    catch (SqlCeException ex)
                    {
                        //this will occur because there is no cascade option, so we just wanna try the next one       
                    }
                }
            }
        }
    }
}
