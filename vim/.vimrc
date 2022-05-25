set tabstop=2
set number
set nocompatible
set backspace=2
set background=dark

" yes, I accept the risks
set noswapfile

" only load plugins if Plug detected
if filereadable(expand("~/.vim/autoload/plug.vim"))
  call plug#begin('~/.vimplugins')
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'pangloss/vim-javascript'
  Plug 'fatih/vim-go'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-scripts/RltvNmbr.vim'
  call plug#end()
  set updatetime=100
"  else
"  " Install vim-plug if not already installed
"  if empty(glob('~/.vim/autoload/plug.vim'))
"    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"    autocmd VimEnter * PlugInstall
"  endif
endif

" nerdtree without the dependency!
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = 10

" go settings
let g:go_fmt_fail_silently = 0 " let me out even with errors

" pandoc syntax settings
let g:pandoc#modules#disabled = [ 'folding' ]
let g:pandoc#syntax#conceal#urls = 0
let g:pandoc#syntax#conceal#blacklist = [ 'quotes', 'squotes', 'apostrophe', 'atx', 'codeblock_delim' ]
let g:pandoc#syntax#codeblocks#embeds#langs = [ 'vim', 'go', 'markdown', 'python', 'bash=sh' ]

" open file browser with gz
map <silent> gz :Lexplore<CR>

" resize windows with <. >, +, _
map < <C-W><
map > <C-W>>
map + <C-W>+
map _ <C-W>-

