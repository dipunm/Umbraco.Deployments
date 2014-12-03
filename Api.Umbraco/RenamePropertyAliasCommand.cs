using System;
using System.Web;
using System.Web.Caching;
using CmsController.Core;
using umbraco;
using umbraco.BusinessLogic;
using umbraco.cms.businesslogic.propertytype;
using umbraco.cms.businesslogic.web;
using Umbraco.Web;

namespace Api.Umbraco
{
    public class RenamePropertyAliasCommand : ICommand
    {
        public void RenameProperty(string documentTypeAlias, string oldPropertyAlias, string newPropertyAlias)
        {
            UmbracoHacker.SetupApplicationContext();
            UmbracoHacker.SetupGlobalConfiguration();

            var documentType = DocumentType.GetByAlias(documentTypeAlias);
            var propertyDef = documentType.PropertyTypes.Find(p => p.Alias == oldPropertyAlias);
            propertyDef.Alias = newPropertyAlias;
        }
    }
}
