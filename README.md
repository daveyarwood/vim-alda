# vim-alda

A plugin for Vim providing support for editing and playing [Alda][alda] scores.

> **This plugin currently will only work on Neovim.**
>
> It ought to be easy to make it work with Vim, too. I am looking into this.

## Features

* Syntax highlighting and filetype detection.
* Score navigation via `[[`, `]]`, `[]`, `][`.
* Folds for instrument parts, voices, etc.
* Support for [vim-commentary](http://github.com/tpope/vim-commentary).
* Useful commands/mappings for playing selections of Alda code.
* Commands/mappings for parsing the current score and showing the results.
* Per-buffer history feature makes playing selections feel like using the Alda
  REPL.

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

Copyright © 2015-2017 Dave Yarwood

Distributed under the same terms as Vim itself. See `:help license`.

[alda]: https://github.com/alda-lang/alda
[dein]: https://github.com/Shougo/dein.vim
[jq]: https://stedolan.github.io/jq/
[vundle]: https://github.com/VundleVim/Vundle.vim
[vim-plug]: https://github.com/junegunn/vim-plug
