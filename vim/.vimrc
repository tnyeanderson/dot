""""""""""""""""""""
" VIM options
""""""""""""""""""""

" display tabs as 2 spaces wide
set tabstop=2

" show line numbers
set number

" make backspace/delete work as expected (including over new lines)
set backspace=2

" make sure the background is dark
" will be reset when using ToggleTransparent
set background=dark

" set up autoindent, load indent and plugin based on filetype
set autoindent
filetype plugin indent on

" yes, I accept the risks
set noswapfile

" allow using the mouse
set mouse=a

""""""""""""""""""""
" Plugins
""""""""""""""""""""

" Install vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" only load plugins if Plug detected
if filereadable(expand("~/.vim/autoload/plug.vim"))
  call plug#begin('~/.vimplugins')
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'fatih/vim-go'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-dispatch'
    Plug 'vim-scripts/RltvNmbr.vim'
    Plug 'morhetz/gruvbox'
  call plug#end()
  set updatetime=100
endif

""""""""""""""""""""
" Plugin configs
""""""""""""""""""""

" nerdtree without the dependency!
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_winsize = 10

" go settings
let g:go_fmt_fail_silently = 0

" pandoc syntax settings
let g:pandoc#modules#disabled = [ 'folding' ]
let g:pandoc#syntax#conceal#urls = 0
let g:pandoc#syntax#conceal#blacklist = [ 'inlinemath', 'ellipses', 'quotes', 'squotes', 'apostrophe', 'atx', 'codeblock_delim', 'codeblock_start' ]
let g:pandoc#syntax#codeblocks#embeds#langs = [ 'vim', 'go', 'markdown', 'python', 'bash=sh' ]

" gruvbox settings
colorscheme gruvbox
let g:gruvbox_italic = 1

""""""""""""""""""""
" Shortcuts & Maps
""""""""""""""""""""

" <leader> key for custom commands
let mapleader = ","

" toggle line numbers with <leader>n
nnoremap <leader>n :set number!<CR>

" clear highlighting from last search with <leader>h
nnoremap <leader>h :nohlsearch<CR>

" save files using sudo with :W!
function! WriteSudo(bang)
  if a:bang != 1
    echo "Use :W! to save with sudo"
    return
  endif
  silent write !sudo tee >/dev/null %
  silent edit!
  redraw!
  echo @% . " written with sudo"
endfunction
command -bang W :execute "call WriteSudo(<bang>0)"

" resize windows with <, >, +, _
nnoremap < <C-W><
nnoremap > <C-W>>
nnoremap + <C-W>+
nnoremap _ <C-W>-

" toggle markdown checkbox with <leader>c
function! ToggleCheckbox()
  let line = getline('.')
  mark `
  if match(line, '- \[ \]', 'n') != -1
    " check box
    s#\M- [ ]#- [x]#
  elseif match(line, '- \[x\]', 'n') != -1
    " uncheck box
    s#\M- [x]#- [ ]#
  else
    " create box
    s#^\(\s*\)\([-\*]\s\)\?#\1- [ ] #e
  endif
  normal ``
endfunction
noremap <silent> <leader>c :call ToggleCheckbox()<CR>

" toggle relative line numbers with <leader>r
noremap <silent> <leader>r :RN<CR>

" toggle file browser  with <leader>z
nnoremap <silent> <leader>z :Lexplore<CR>

" toggle transparent background with CTRL+t
let t:is_transparent = 0
function! ToggleTransparent()
  if t:is_transparent == 0
    " Might also want to set guibg=NONE
    hi Normal ctermbg=NONE
    let t:is_transparent = 1
  else
    set background=dark
    let t:is_transparent = 0
  endif
endfunction
nnoremap <silent> <C-t> :call ToggleTransparent()<CR>

" toggle paste mode with <leader>p
function! TogglePasteMode()
  if(&paste == 0)
    set paste
    echo ":set paste"
  else
    set nopaste
    echo ":set nopaste"
  endif
endfunction
map <leader>p :call TogglePasteMode()<cr>


""""""""""""""""""""
" Autocommands
""""""""""""""""""""

function OnOpenBash()
  " :make should run shfmt and shellcheck
  setlocal makeprg=shfmt\ -w\ %\ &&\ shellcheck\ -f\ gcc\ %
  " shfmt errors
  setlocal errorformat^=%f:\ %o:%l:%c:\ %m
endfunction

function OnOpenMarkdown()
  setlocal expandtab
endfunction

function OnOpenVimrc()
  setlocal expandtab
endfunction

function OnOpen()
  if getline(1) =~ '#!/bin/\%[ba]sh'
    call OnOpenBash()
  endif
endfunction

augroup vimrc
  " Remove all vimrc autocommands
  autocmd!
  autocmd BufRead,BufNewFile * call OnOpen()
  autocmd BufRead,BufNewFile *.md call OnOpenMarkdown()
  autocmd BufRead,BufNewFile .vimrc call OnOpenVimrc()
augroup END

