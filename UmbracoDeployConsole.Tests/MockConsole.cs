using System.Collections.Generic;

namespace UmbracoDeployConsole.Tests
{
    public class MockConsole : IConsole
    {
        private readonly List<string> _outputLines;

        public MockConsole()
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