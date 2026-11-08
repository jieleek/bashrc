Copy the shared `.vim` files into `~/.vim/`, then install the preset for your
environment:

- `dot.vimrc` as `~/.vimrc` for terminal Vim.
- `dot.gvimrc` as `~/.gvimrc` for the Unix GUI overrides.
- `windows_vimrc` as your Windows Vim configuration.
- `powershell.vimrc` as your terminal Vim configuration on Windows.
- `dot.ideavimrc` as `~/.ideavimrc` for IdeaVim, alongside `~/.vimrc`.

The terminal and Unix GUI presets require the `railscasts` colorscheme.
The Unix GUI preset also configures FuzzyFinder and Taglist and starts in
`/bin`. Windows presets use the bundled `desert` colorscheme.

Shared preferences can be reloaded with `:source ~/.vim/preference.vim`;
their autocommands are replaced on each load. GVim reuses preferences
already loaded by `.vimrc`.

`filetree.vim` and `secret.vim` are optional; source them explicitly to enable
their mappings. `secret.vim` retains its own settings for disabling persistent
buffer data so it can be used independently. `boldoff.vim` defines the
`:BoldOff` command; the PowerShell preset loads it without running the command.
