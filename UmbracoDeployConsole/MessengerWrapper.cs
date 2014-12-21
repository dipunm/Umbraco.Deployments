using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace UmbracoDeployConsole
{
    class MessengerWrapper : IMessenger
    {
        public void WriteLine(string message)
        {
            Console.WriteLine(message);
        }
    }
}
