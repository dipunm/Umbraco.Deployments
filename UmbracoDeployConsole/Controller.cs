using System;
using System.Collections.Generic;
using System.Linq;
using CmsController.Core;

namespace UmbracoDeployConsole
{
    public class Controller
    {
        private readonly IConsole _console;
        private readonly IEnumerable<ICommand> _commands;

        public Controller(IConsole console, IEnumerable<ICommand> commands)
        {
            _console = console;
            _commands = commands;
        }

        public void ListCommands()
        {
            if (!_commands.Any())
            {
                _console.WriteLine("No commands found.");
            }
            else
            {
                foreach (var command in _commands)
                {
                    _console.WriteLine(command.Alias + command.Description);
                }
            }
        }

        public void ExecuteCommand(string commandAlias)
        {
            if (_commands.Any(c => c.Alias == commandAlias))
            {
                var command = _commands.Single(c => c.Alias == commandAlias);
                command.Execute(_console);
            }
            else
            {
                var message = String.Format("Unable to find command `{0}`", commandAlias);
                _console.WriteLine(message);
            }
        }
    }
}