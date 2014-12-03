using System;
using Api.Umbraco.Tests.Helpers;
using NUnit.Framework;
using umbraco;

namespace Api.Umbraco.Tests.Tests
{
    [TestFixture]
    internal class UmbracoAssertHelperTests
    {
        [SetUp]
        public void SetUp()
        {
            SetupHelper.PrepareDatabase();
        }

        [Test]
        public void PropertyExists()
        {
            bool answer;
            using (var helper = new UmbracoAssertHelper())
            {
                answer = helper.PropertyExists("umbTextpage", "bodyText");
            }
            Assert.IsTrue(answer);
        }

        [Test]
        public void PropertyDoesntExistsIfDocumentTypeIsWrong()
        {
            bool answer;
            using (var helper = new UmbracoAssertHelper())
            {
                answer = helper.PropertyExists("umbTextpage1", "bodyText");
            }
            Assert.IsFalse(answer);
        }

        [Test]
        public void PropertyDoesntExistsIfPropertyAliasIsWrong()
        {
            bool answer;
            using (var helper = new UmbracoAssertHelper())
            {
                answer = helper.PropertyExists("umbTextpage", "bodyTextsss");
            }
            Assert.IsFalse(answer);
        }

        [Test]
        public void CanGetPropertyValue()
        {
            string answer;
            using (var helper = new UmbracoAssertHelper())
            {
                answer = helper.GetPropertyValue(1050, "bodyText");
            }

            Assert.That(String.IsNullOrWhiteSpace(answer), Is.False);
        }

        [Test]
        public void DbTrasferWorks()
        {
            string answer;
            using (var helper = new UmbracoAssertHelper())
            {
                answer = helper.GetPropertyValue(1050, "bodyText2");
                if (String.IsNullOrWhiteSpace(answer))
                {
                    Console.Write(helper.GetPropertyValue(1050, "bodyText2"));
                }
            }
            Assert.That(String.IsNullOrWhiteSpace(answer), Is.True);
        }

        [Test]
        public void CantGetPropertyValueWhenNodeDoesntExist()
        {
            string answer;
            using (var helper = new UmbracoAssertHelper())
            {
                answer = helper.GetPropertyValue(50, "bodyText");
            }
            Assert.That(String.IsNullOrEmpty(answer), Is.True);
        }

        [Test]
        public void CantGetPropertyValueWhenPropertyDoesntExist()
        {
            string answer;
            using (var helper = new UmbracoAssertHelper())
            {
                answer = helper.GetPropertyValue(1050, "bodyTextssss");
            }
            Assert.That(String.IsNullOrEmpty(answer), Is.True);
        }
    }
}