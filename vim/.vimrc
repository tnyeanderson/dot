set tabstop=2
set number
set nocompatible
set backspace=2
set background=dark

" only load plugins if Plug detected
if filereadable(expand("~/.vim/autoload/plug.vim"))
  call plug#begin('~/.vimplugins')
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'https://gitlab.com/rwxrob/vim-pandoc-syntax-simple'
  Plug 'pangloss/vim-javascript'
  Plug 'fatih/vim-go'
  Plug 'airblade/vim-gitgutter'
	Plug 'vim-scripts/RltvNmbr.vim'
  call plug#end()
  let g:go_fmt_fail_silently = 0 " let me out even with errors
	"let g:pandoc#syntax#codeblocks#embeds#langs = [ 'vim' ]
  set updatetime=100
"  else
"  " Install vim-plug if not already installed
"  if empty(glob('~/.vim/autoload/plug.vim'))
"    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"    autocmd VimEnter * PlugInstall
"  endif
endif

" NERDtree without the dependency!
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = 10

" open file browser with gz
map <silent> gz :Lexplore<CR>

" resize windows with <. >, +, _
map < <C-W><
map > <C-W>>
map + <C-W>+
map _ <C-W>-
