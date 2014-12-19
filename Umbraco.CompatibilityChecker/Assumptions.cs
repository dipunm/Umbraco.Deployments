using System;

namespace Umbraco.CompatibilityChecker
{
    [Flags]
    public enum Assumptions
    {
        /// <summary>
        /// This command will not run on newer versions of Umbraco
        /// where control of custom sections and trees are no longer
        /// controlled by the database.
        /// </summary>
        [UmbracoVersions(Min = "4.8.0")]
        CustomSectionsAreNotControlledInDb = 1,

        /// <summary>
        /// cmsTab has been replaced with a new table, cmsPropertyTypeGroup
        /// </summary>
        [UmbracoVersions(Min = "6.0.0")]
        PropertyTypeGroupIsTheNewTab = 2,

        /// <summary>
        /// cmsContentType no longer contains a masterContentType column. 
        /// Heirarchical document types still exist, but are stored differently
        /// </summary>
        [UmbracoVersions(Min = "6.0.0")]
        DocumentTypeHeirarchyIsControlledByNodeTable = 4,

        /// <summary>
        /// Document type compositions exist. This is similar to mixins.
        /// </summary>
        [UmbracoVersions(Min = "6.0.0")]
        DocumentTypesCanBeComposed = 8, 
        
        /// <summary>
        /// DocumentTypes can be abstract. They define properties etc. but
        /// cannot be directly used by users in the content area of the site.
        /// </summary>
        [UmbracoVersions(Min = "4.6.0", Max = "4.8.0")]
        IsContainerExists = 16,

        /// <summary>
        /// We can now control what document types can be created at the 
        /// root of the content section in the CMS.
        /// </summary>
        [UmbracoVersions(Min = "4.6.0", Max = "4.8.0")]
        AllowAtRootExists = 32,

        /// <summary>
        /// Member property aliases have changed in order to facilitate a 
        /// new Member API.
        /// </summary>
        [UmbracoVersions(Min = "4.6.0", Max = "4.8.0")]
        MemberPropertiesVersion2 = 64,

        /// <summary>
        /// Content nodes can change their document types after creation
        /// </summary>
        [UmbracoVersions(Min = "4.6.0", Max = "4.8.0")]
        NodeDocumentTypeCanBeChanged = 128,

        /// <summary>
        /// The site uses the new Belle Backoffice.
        /// </summary>
        [UmbracoVersions(Min = "4.6.0", Max = "4.8.0")]
        Belle = 256,

        /// <summary>
        /// Tag relations schema in database changed for optimisation in Umbraco 7.
        /// </summary>
        [UmbracoVersions(Min = "4.6.0", Max = "4.8.0")]
        TagRelationsVersion2 = 512
    }

    public class UmbracoVersionsAttribute : Attribute
    {
        public string Min { get; set; }
        
        public string Max { get; set; }
        
    }
}