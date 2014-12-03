using System;
using PetaPoco;

namespace Api.Umbraco.Tests.Helpers
{
    public class UmbracoAssertHelper : IDisposable
    {
        private readonly Database PetaPoco;
        public UmbracoAssertHelper()
        {
            PetaPoco = new Database("Test.Db");
        }
        public bool PropertyExists(string documentTypeAlias, string propertyAlias)
        {
            const string script = @"
                SELECT COUNT(pt.id)
                  FROM [cmsPropertyType] pt
                  LEFT JOIN [cmsContentType] ct ON pt.contentTypeId = ct.nodeId
                  WHERE pt.Alias = @0
                  AND ct.alias = @1
";
            return PetaPoco.ExecuteScalar<int>(script, propertyAlias, documentTypeAlias) != 0;
        }

        public string GetPropertyValue(int pageId, string propertyAlias)
        {
            const string script = @"
                SELECT pd.dataNtext 
                    FROM cmsPropertyData pd
                    LEFT JOIN cmsPropertyType pt ON pt.id = pd.propertytypeid
                    WHERE contentNodeId = @0
                    AND pt.Alias = @1
";

            return PetaPoco.ExecuteScalar<string>(script, pageId, propertyAlias);
        }

        public void Dispose()
        {
            
            PetaPoco.CloseSharedConnection();
            PetaPoco.Dispose();
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }
    }
}