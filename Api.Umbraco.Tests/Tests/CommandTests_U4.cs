using System;
using System.Collections.Generic;
using Api.Umbraco.Tests.Helpers;
using NUnit.ApplicationDomain;
using NUnit.Framework;
using umbraco.cms.businesslogic.web;

namespace Api.Umbraco.Tests.Tests
{
    [TestFixture]
    [RunInApplicationDomain]
    public class CommandTests_U4
    {
        protected UmbracoAssertHelper _umbracoAssertHelper;
        
        [SetUp]
        protected void SetUp()
        {

            SetupHelper.PrepareDatabase();
            if (!AppDomainRunner.IsInTestAppDomain)
                return;
            
            SetupHelper.LoadAppConfig();
            SetupHelper.PrepareDatabase();
            
            _umbracoAssertHelper = new UmbracoAssertHelper();
        }

        [TearDown]
        public void Teardown()
        {
            if (!AppDomainRunner.IsInTestAppDomain)
                return;

            _umbracoAssertHelper.Dispose();       
        }

        [Test]
        public void CanRenameDocumentTypePropertyAlias()
        {
            var command = new RenamePropertyAliasCommand();
            var propertyValue = _umbracoAssertHelper.GetPropertyValue(pageId: 1050, propertyAlias: "bodyText");

            command.RenameProperty(
                documentTypeAlias: "umbTextpage",
                oldPropertyAlias: "bodyText",
                newPropertyAlias: "bodyText2"
            );

            Assert.IsFalse(_umbracoAssertHelper.PropertyExists("umbTextpage", "bodyText"));
            Assert.IsTrue(_umbracoAssertHelper.PropertyExists("umbTextpage", "bodyText2"));
            Assert.That(_umbracoAssertHelper
                .GetPropertyValue(pageId: 1050, propertyAlias: "bodyText2"), 
                    Is.EqualTo(propertyValue));
        }
    }
}