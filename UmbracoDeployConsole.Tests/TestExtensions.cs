using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using CmsController.Core;
using Moq;

namespace UmbracoDeployConsole.Tests
{
    public static class TestExtensions
    {
        public static void Shuffle<T>(this List<T> list)
        {
            var rng = new Random();
            int n = list.Count;
            while (n > 1)
            {
                n--;
                var k = rng.Next(n + 1);
                var value = list[k];
                list[k] = list[n];
                list[n] = value;
            }
        }
    }


    public class MockCommand
    {
        public static ICommand Create(string name, string description)
        {
            var mock = new Mock<ICommand>();
            mock.SetupGet(c => c.Alias).Returns(name);
            mock.SetupGet(c => c.Description).Returns(description);
            return mock.Object;
        }
        public IDisposable Subscribe(IObserver<int> observer)
        {
            throw new NotImplementedException();
        }
    }
}
