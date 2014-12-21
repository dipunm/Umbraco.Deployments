using System.Collections.Generic;

namespace UmbracoDeployConsole.Tests
{
    public class MockMessenger : IMessenger
    {
        private readonly List<string> _outputLines;

        public MockMessenger()
        {
            _outputLines = new List<string>();
        }

        public IEnumerable<string> OutputLines
        {
            get { return _outputLines; }
        }

        public void WriteLine(string message)
        {
            _outputLines.Add(message);
        }
    }
}