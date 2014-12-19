namespace CmsController.Core
{
    public interface ICommand
    {
        string Alias { get; }
        string Description { get; }
        void Execute(IMessenger console);
    }
}