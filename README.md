# vim-alda

A plugin for Vim providing support for editing and playing [Alda][alda] scores.

## Caveats

* **This plugin currently only works on Neovim.**

  It would be nice if it worked on Vim, too, but I haven't been able to figure
  out how get that working without needing to rewrite a bunch of Neovim-specific
  code to conditionally use either Neovim's or Vim's background jobs APIs.

  If you use Vim and you're interested in contributing support for Vim, I would
  greatly appreciate it!

* **This plugin currently only works with Alda 1.x.**

  Alda 2 was released in June 2021, and its interface is a bit different. I plan
  to update vim-alda to work with Alda 2 in the near future.

## Features

* Syntax highlighting and filetype detection.
* Score navigation via `[[`, `]]`, `[]`, `][`.
* Folds for instrument parts, voices, etc.
* Support for [vim-commentary](http://github.com/tpope/vim-commentary).
* `:Alda` wrapper for running `alda` CLI commands
* Useful commands/mappings for playing selections of Alda code.
* Commands/mappings for parsing the current score and showing the results.

## Installation

Install using your Vim plugin manager of choice. [Vundle][vundle], [vim-plug][vim-plug], and [dein.vim][dein] are all fine choices.

Of course, if you haven't already, you should install [Alda][alda].

Alda version 1.0.0-rc83 or higher is required.

### Optional

For pretty-printed JSON when viewing a parsed score, install [jq][jq] and make
it available on your `$PATH`.

## Usage

For comprehensive documentation, see `:help alda`.

## Contributing

Pull Requests welcome!

## License

Copyright © 2015-2021 Dave Yarwood

Distributed under the same terms as Vim itself. See `:help license`.

[alda]: https://github.com/alda-lang/alda
[dein]: https://github.com/Shougo/dein.vim
[jq]: https://stedolan.github.io/jq/
[vundle]: https://github.com/VundleVim/Vundle.vim
[vim-plug]: https://github.com/junegunn/vim-plug
