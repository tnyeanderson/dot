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
    Plug 'pangloss/vim-javascript'
    Plug 'fatih/vim-go'
    Plug 'airblade/vim-gitgutter'
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
let g:pandoc#syntax#conceal#blacklist = [ 'quotes', 'squotes', 'apostrophe', 'atx', 'codeblock_delim', 'codeblock_start' ]
let g:pandoc#syntax#codeblocks#embeds#langs = [ 'vim', 'go', 'markdown', 'python', 'bash=sh' ]

" gruvbox settings
colorscheme gruvbox
let g:gruvbox_italic = 1

""""""""""""""""""""
" Shortcuts & Maps
""""""""""""""""""""

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

" toggle checkbox with gc
function! ToggleCheckbox()
  let line = getline('.')
  mark `
  if match(line, '- \[ \]', 'n') != -1
    s#\M- [ ]#- [x]#
  elseif match(line, '- \[x\]', 'n') != -1
    s#\M- [x]#- [ ]#
  else
    s#^\(\s*\)\([-\*]\s\)\?#\1- [ ] #e
  endif
  normal ``
endfunction
noremap <silent> gc :call ToggleCheckbox()<CR>

" toggle relative line numbers with gr
noremap <silent> gr :RN<CR>

" toggle file browser with gz
nnoremap <silent> gz :Lexplore<CR>

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

""""""""""""""""""""
" Functions
""""""""""""""""""""

" run shfmt command on the current file
function! RunShfmt()
  let path = expand('%:p')
  silent execute('!shfmt -w ' . path)
  silent edit!
  redraw!
  echo @% . " formatted with shfmt"
endfunction
command -nargs=0 Shfmt call RunShfmt()

" run shellcheck command on the current file
function! RunShellcheck()
  let path = expand('%:p')
  execute('!shellcheck ' . path)
endfunction
command -nargs=0 Shellcheck call RunShellcheck()

