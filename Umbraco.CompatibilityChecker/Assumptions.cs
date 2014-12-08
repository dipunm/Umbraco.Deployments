namespace Umbraco.CompatibilityChecker
{
    public enum Assumptions
    {
        /// <summary>
        /// This command will not run on newer versions of Umbraco
        /// where control of custom sections and trees are no longer
        /// controlled by the database.
        /// </summary>
        CustomSectionsAreControlledInDb,

        /// <summary>
        /// cmsTab has been replaced with a new table, cmsPropertyTypeGroup
        /// </summary>
        PropertyTypeGroupIsTheNewTab,

        /// <summary>
        /// cmsContentType no longer contains a masterContentType column. 
        /// Heirarchical document types still exist, but are stored differently
        /// </summary>
        DocumentTypeHeirarchyIsControlledByNodeTable,

        /// <summary>
        /// Document type compositions exist. This is similar to mixins.
        /// </summary>
        DocumentTypesCanBeComposed, 
        
        /// <summary>
        /// DocumentTypes can be abstract. They define properties etc. but
        /// cannot be directly used by users in the content area of the site.
        /// </summary>
        IsContainerExists,

        /// <summary>
        /// We can now control what document types can be created at the 
        /// root of the content section in the CMS.
        /// </summary>
        AllowAtRootExists,

        /// <summary>
        /// Member property aliases have changed in order to facilitate a 
        /// new Member API.
        /// </summary>
        MemberPropertiesVersion2,

        /// <summary>
        /// Content nodes can change their document types after creation
        /// </summary>
        NodeDocumentTypeCanBeChanged,

        /// <summary>
        /// The site uses the new Belle Backoffice.
        /// </summary>
        Belle,

        /// <summary>
        /// Tag relations schema in database changed for optimisation in Umbraco 7.
        /// </summary>
        TagRelationsVersion2
    }
}