﻿using System;

namespace CmsController.Core
{
    public interface ICommand
    {
        string Alias { get; }
        string Description { get; }
        void Execute(string[] args = null);
    }
}