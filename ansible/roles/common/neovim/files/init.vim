set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.local/share/nvim/plugged')
" ========================================================
Plug 'MattesGroeger/vim-bookmarks'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'mxw/vim-jsx'
Plug 'godlygeek/tabular'
Plug 'heavenshell/vim-jsdoc'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" ========================================================
call plug#end()

" ========================================================
" Theme settings
" ========================================================

syntax on
filetype plugin indent on
syntax enable
set background=dark
set clipboard=unnamed

if $VIM_THEME == 'gruvbox'
    colorscheme gruvbox
    let g:airline_theme='gruvbox'
endif

if $VIM_THEME == 'solarized'
    colorscheme solarized
    let g:airline_theme='solarized'
    let g:solarized_visibility = "high"
    let g:solarized_contrast = "high"
    let g:solarized_termtrans = 1
endif

" ========================================================
" Personal keybindings
" ========================================================
:noremap p[ :bp <cr>
:inoremap p[ <Esc>:bp <cr>
:noremap p] :bn <cr>
:inoremap p] <Esc>:bn <cr>

:noremap -- :NERDTreeToggle <cr>

let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'



" ========================================================
" Shougo/deoplete settings
" ========================================================
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = "$HOME/.config/nvim/venv/bin/python"
let g:deoplete#sources#jedi#python_path = "$HOME/.config/nvim/venv/bin/python"

" ========================================================
" airblade/vim-gitgutter settings
" ========================================================

" https://github.com/airblade/vim-gitgutter/issues/164#issuecomment-75758204
highlight clear SignColumn
call gitgutter#highlight#define_highlights()


" ========================================================
" Yggdroot/indentLine settings
" ========================================================
let g:indentLine_char = '│'


" ========================================================
" bling/vim-airline settings
" ========================================================

" vim airline show status bar
set laststatus=2
" vim powerline fonts for arrows
let g:airline_powerline_fonts = 1
" Instead of displaying file encoding, display absolute file path.
let g:airline_section_y = airline#section#create(['%F'])
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'


" ========================================================
" scrooloose/syntastic settings
" ========================================================

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_python_exec = '/usr/local/bin/python3'


" ========================================================
" heavenshell/vim-jsdoc settings
" ========================================================

" Allow prompt for interactive input.
let g:jsdoc_allow_input_prompt = 1

" Prompt for a function description
let g:jsdoc_input_description = 1

" Characters used to separate @param name and description.
let g:jsdoc_param_description_separator	= ' - '


" ========================================================
" elzr/vim-json settings
" ========================================================

" Disable the concealing
let g:vim_json_syntax_conceal = 0


" ========================================================
" More vim settings
" ========================================================

" line numbers
set number

" tabs to spaces
" size of a hard tabstop
set tabstop=4
" always uses spaces instead of tab characters
set expandtab
" size of an "indent"
set shiftwidth=4
" Sets the number of columns for a TAB
set softtabstop=4

imap jj <Esc>

" make splits faster in tmux
" http://unix.stackexchange.com/a/240693
set lazyredraw
set ttyfast

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
map g <nop>
map U <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Persistent Undo, Vim remembers everything even after the file is closed.
set undofile
set undolevels=500
set undoreload=500

" Relative numbers
set relativenumber

" Shorten escape insert mode time
set timeoutlen=200

" With buffers, don't force save (http://usevim.com/2012/10/19/vim101-set-hidden/)
set hidden

" set ruler
set colorcolumn=80
set colorcolumn=+1

set splitbelow
set splitright

" Searching
set ignorecase
set incsearch
set nohlsearch

set backspace=indent,eol,start

" http://blog.mattcrampton.com/post/86216925656/move-vim-swp-files
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

" http://www.bestofvim.com/tip/leave-ex-mode-good/
" what even is ex mode anyway
nnoremap Q <nop>

" ========================================================
" snippets
" ========================================================

function! SpellCheck()
    let l:word = input("Word you're trying to spell: ")
    let l:result = system($SCRIPTS . '/spellcheck.py ' . word)
    redraw
    echo l:result
    let @@ = l:result
endfunction

command SpellCheck :call SpellCheck()

function! TODO()
    let l:timestamp = strftime('%F')
    let l:todo = ' TODO(markl|' . timestamp . '):  '
    :exe ":normal i" . todo
endfunction

command TODO :call TODO()



" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
