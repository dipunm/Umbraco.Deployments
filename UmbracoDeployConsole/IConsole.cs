using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CmsController.Core;

namespace UmbracoDeployConsole
{
    public interface IConsole : IMessenger
    {
        void WriteLine(string message);
    }
}
