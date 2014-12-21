using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Runtime.Remoting;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using CmsController.Core;

namespace UmbracoDeployConsole
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.CancelKeyPress += (sender, eventArgs) =>
            {
                Console.WriteLine("Noooooo!");
                Console.ReadKey();
            };
            Console.WriteLine("Welcome to UmbracoDeploy.");
            Console.WriteLine("You may exit by typing `exit`");
            Console.WriteLine("You may see a list of commands by typing `list`");
            Console.WriteLine("To understand how to execute a particular command, type `help {command}`.");
            Console.WriteLine("To execute a command, type `exec` with the specified parameters.");
                
            while (true)
            {
                Console.Write(">");
                var words = Console.ReadLine() ?? String.Empty;
                var commandSegments = words
                    .Split(' ')
                    .Where(w => !String.IsNullOrWhiteSpace(w))
                    .ToArray();

                switch (Execute(commandSegments))
                {
                    case ExitStatus.Exit:
                        return;
                    case ExitStatus.Continue:
                    default:
                        continue;
                }
            }
        }

        private static ExitStatus Execute(string[] args)
        {
            var commands = new List<ICommand>()
            {
                new Command()
            };

            var method = args[0].Trim();

            if (method.Equals("exit", StringComparison.OrdinalIgnoreCase))
            {
                return ExitStatus.Exit;
            }
            else if (method.Equals("list", StringComparison.OrdinalIgnoreCase))
            {
                foreach (var command in commands)
                {
                    var message = String.Format("{0} - {1}", command.Alias, command.Description);
                    Console.WriteLine(message);
                }
            }
            else if (method.Equals("help", StringComparison.OrdinalIgnoreCase))
            {
                if (args.Count() != 2)
                {
                    Console.WriteLine("Please follow the format `help {command}`");
                }
                else
                {
                    var command = args.GetValue(1);
                    Console.WriteLine("describing command `{0}`", command);
                }
            }
            else if (method == "exec")
            {
                Console.WriteLine("I would normally be executing some stuff here.");
            }
            else
            {
                Console.WriteLine("`{0}` is not a recognised command. Please choose from: exec, help and exit.", method);
            }
            return ExitStatus.Continue;
        }
    }

    public enum ExitStatus
    {
        Continue, Exit
    }

    internal class Command : ICommand
    {
        public Command()
        {
            Alias = "hello";
            Description = "Kills all humans";
        }
        public string Alias { get; private set; }
        public string Description { get; private set; }
        public void Execute(string[] args = null)
        {
            throw new NotImplementedException();
        }
    }

    internal class StringAndConsoleTextWriter : TextWriter
    {
        private readonly TextWriter _consoleTextWriter;
        private readonly StringWriter _stringWriter;

        public StringAndConsoleTextWriter(TextWriter consoleTextWriter, StringBuilder stringBuilder)
        {
            _consoleTextWriter = consoleTextWriter;
            _stringWriter = new StringWriter(stringBuilder);
        }

        public override void Close()
        {
            _consoleTextWriter.Close();
            _stringWriter.Close();
            base.Close();
        }

        public override ObjRef CreateObjRef(Type requestedType)
        {
            _consoleTextWriter.Close();
            _stringWriter.Close();
            return base.CreateObjRef(requestedType);
        }

        protected override void Dispose(bool disposing)
        {
            _consoleTextWriter.Dispose();
            _stringWriter.Dispose();
            base.Dispose(disposing);
        }

        public override void Flush()
        {
            _consoleTextWriter.Flush();
            _stringWriter.Flush();
            base.Flush();
        }

        public override void Write(char value)
        {
            _consoleTextWriter.Write(value);
            _stringWriter.Write(value);
            base.Write(value);
        }

        public override void Write(object value)
        {
            _consoleTextWriter.Write(value);
            _stringWriter.Write(value);
            base.Write(value);
        }

        public override Encoding Encoding
        {
            get { return _consoleTextWriter.Encoding; }
        }
    }
}
