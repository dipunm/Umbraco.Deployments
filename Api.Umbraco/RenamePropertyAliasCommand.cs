using System;
using CmsController.Core;
using umbraco.cms.businesslogic.web;

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

        public string Alias { get { return String.Empty; }}
        public string Description { get { return String.Empty; } }
        public void Execute(IMessenger console)
        {
            throw new NotImplementedException();
        }
    }
}
