using System;
using System.Collections.Generic;
using System.Linq;
using CmsController.Core;
using Moq;
using NUnit.Framework;

namespace UmbracoDeployConsole.Tests
{

    [TestFixture]
    public class ControllerTests
    {
        [Test]
        public void ListCommands_MultipleCommands_OneLinePrintedPerCommand()
        {
            var mockConsole = new MockMessenger();
            var commands = new List<ICommand>()
            {
                MockCommand.Create("commanda", "This is the description of the command 1"),
                MockCommand.Create("commandb", "This is the description of the command 2"),
                MockCommand.Create("commandc", "This is the description of the command 3")
            };
            var controller = new Controller(mockConsole, commands);

            controller.ListCommands();

            Assert.That(mockConsole.OutputLines.Count(), Is.EqualTo(3));
        }

        [Test]
        public void ListCommands_NoCommands_ErrorMessagePrinted()
        {
            var mockConsole = new MockMessenger();
            var commands = new List<ICommand>();
            var controller = new Controller(mockConsole, commands);

            controller.ListCommands();

            Assert.That(mockConsole.OutputLines.Single(), Is.EqualTo("No commands found."));
        }

        [Test]
        public void ListCommands_CommandsFound_EachLineContainsCommandAlias()
        {
            var mockConsole = new MockMessenger();
            const string uniqueAlias = "UniqueAlias";
            var commands = new List<ICommand>()
            {
                MockCommand.Create(uniqueAlias, "Unique Description")
            };
            var controller = new Controller(mockConsole, commands);

            controller.ListCommands();

            Assert.That(mockConsole.OutputLines.Single(), Is.StringContaining(uniqueAlias));
        }

        [Test]
        public void ListCommands_CommandsFound_EachLineContainsCommandDescription()
        {
            var mockConsole = new MockMessenger();
            const string uniqueDescription = "Unique Description";
            var commands = new List<ICommand>()
            {
                MockCommand.Create("UniqueAlias", uniqueDescription)
            };
            var controller = new Controller(mockConsole, commands);

            controller.ListCommands();

            Assert.That(mockConsole.OutputLines.Single(), Is.StringContaining(uniqueDescription));
        }

        [Test]
        public void ExecuteCommand_OnlyCommandAliasProvided_ExecutesAppropriateCommand()
        {
            const string commandAlias = "commandAlias";
            var console = new MockMessenger();
            var mockCommand = MockCommand.Create(commandAlias, null);
            var commands = new List<ICommand>()
            {
                mockCommand
            };
            var controller = new Controller(console, commands);

            controller.ExecuteCommand(commandAlias);

            Mock.Get(mockCommand).Verify(c => c.Execute(null), Times.Once);
        }

        [Test]
        public void ExecuteCommand_CommandInMiddleOfMultiList_ExecutesAppropriateCommand()
        {
            const string commandAlias = "commandAlias";
            var console = new MockMessenger();
            var mockCommand = MockCommand.Create(commandAlias, null);
            var commands = new List<ICommand>()
            {
                MockCommand.Create("dummy0", null),
                MockCommand.Create("dummy1", null),
                mockCommand,
                MockCommand.Create("dummy2", null),
                MockCommand.Create("dummy3", null)
            };
            var controller = new Controller(console, commands);

            controller.ExecuteCommand(commandAlias);

            Mock.Get(mockCommand).Verify(c => c.Execute(null), Times.Once);
        }

        [Test]
        public void ExecuteCommand_CannotFindCommand_PrintsErrorMessage()
        {
            const string commandAlias = "commandAlias";
            var console = new MockMessenger();
            var commands = new List<ICommand>();
            var controller = new Controller(console, commands);

            controller.ExecuteCommand(commandAlias);

            var expectedMessage = String.Format("Unable to find command `{0}`", commandAlias);
            Assert.That(console.OutputLines.Single(), Is.EqualTo(expectedMessage));
        }

        [Test]
        public void ExecuteCommand_ArgumentsProvided_CommandRecievesArguments()
        {
            const string commandAlias = "commandAlias";
            var args = new[] { "/one", "-two", "three=23", "4" };
            var console = new MockMessenger();
            var mockCommand = MockCommand.Create(commandAlias, null);
            var commands = new List<ICommand>()
            {
                mockCommand
            };
            var controller = new Controller(console, commands);

            controller.ExecuteCommand(commandAlias, args);            

            Mock.Get(mockCommand).Verify(c => c.Execute(args), Times.Once);
        }
    }
}