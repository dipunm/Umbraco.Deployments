using System;
using System.Reflection;
using Umbraco.Core;

namespace Api.Umbraco
{
    public static class UmbracoHacker
    {
        public static void SetupApplicationContext()
        {
            var context = Activator.CreateInstance(typeof(ApplicationContext), true);
            typeof(ApplicationContext)
                .GetProperty("Current")
                .GetSetMethod(true)
                .Invoke(null, new[] { context });
        }

        public static void SetupGlobalConfiguration()
        {
            typeof(ApplicationContext)
                .Assembly
                .GetType("Umbraco.Core.Configuration.UmbracoSettings")
                .GetField("_forceSafeAliases", BindingFlags.NonPublic | BindingFlags.Static)
                .SetValue(null, (bool?)true);

        }
    }
}