""""""""
""" 
""" .vimrc
""" 
""""""""

" Sometimes useless. Reason: https://stackoverflow.com/a/5845583
set nocompatible
" Filetype detection. It's needed when working with plugin managers
filetype off

""
" Plugin list
""
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin('$HOME/.vim/bundle/')

" Vundle manages vundle
Plugin 'VundleVim/Vundle.vim' 

"
" Git support
"

" set git marks for file modifications
Plugin 'airblade/vim-gitgutter'                                     
" a better git status
Plugin 'jreybert/vimagit'                                           
" more git funcionality, specially git blame
Plugin 'tpope/vim-fugitive'
" Provides a function to get the git branch name
Plugin 'itchyny/vim-gitbranch'

"
" Editor 
"

" automatic closure for (, {, [, etc
Plugin 'jiangmiao/auto-pairs'
" I can see clearly now ... the indent lines
Plugin 'nathanaelkane/vim-indent-guides'  
" a Fuzzy finder
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
" vim plugin for fzf
Plugin 'junegunn/fzf.vim'
" editorConfig (https://editorconfig.org/) support
Plugin 'editorconfig/editorconfig-vim'
" A nice markdown preview
Plugin 'skanehira/preview-markdown.vim'
" A better file finder
Plugin 'ctrlpvim/ctrlp.vim'


"
" General programming
"

" Source code browser (uses ctags)
Plugin 'taglist.vim'
" A solid language pack
Plugin 'sheerun/vim-polyglot'
" Code Completion engine
Plugin 'ajh17/VimCompletesMe'
" Generates JS-Doc
Plugin 'heavenshell/vim-jsdoc'
" Syntax checker
Plugin 'vim-syntastic/syntastic'
" Provides support to emmet (http://emmet.io)
Plugin 'mattn/emmet-vim'

" 
" Appearance
"

" retro theme
Plugin 'morhetz/gruvbox'                                            
" theme for statusbar
Plugin 'itchyny/lightline.vim'                                      
" lightline theme for gruvbox
Plugin 'shinchu/lightline-gruvbox.vim'                              

"
" Utils
"

" Allow to manipulate todo.txt files in vim
"Plugin 'vim-scripts/todo-txt.vim'                                   
" Gist integration (https://gist.github.com)
"Plugin 'lambdalisue/vim-gista'                                      
" lorem ipsum dolor sit amet....
Plugin 'vim-scripts/loremipsum'                                     
" A calendar?? Inside VIM??? WTF? o_O
Plugin 'itchyny/calendar.vim'
" Some nice startup page
Plugin 'mhinz/vim-startify'
" CSV file support
Plugin 'chrisbra/csv.vim'

call vundle#end()            " required
filetype plugin indent on    " required
" End of plugin list

" my plugins
let lines = readfile($HOME . "/.dotfiles-loc")

"" 
" Functions
""
function! ShowDigraphs()
    digraphs
    call getchar()
    return "\<C-K>"
endfunction

""
" Performance configurations
""
"more characters will be sent to the screen for redrawing
set ttyfast
"time waited for key press(es) to complete. It makes for a faster key response
set ttimeout
set ttimeoutlen=50
"disable file backup (if you don't need it)
set nobackup
set noswapfile
" Update sign column every quarter of second
set updatetime=250


""
" General configurations
""
" file encoding
set encoding=UTF-8
set fileencoding=UTF-8
set backspace=indent,eol,start " make backspace behave properly in insert mode
set showcmd " display incomplete commands

" a better menu in command mode
set wildmenu
set wildmode=longest:full,full
set hidden " hide buffers instead of closing them even if they contain unwritten changes
set nowrap " disable soft wrap for lines
set relativenumber " display relative line numbers (much better to make jumps between lines)

" new splits will be at the bottom or to the right side of the screen
set splitbelow
set splitright
set autoindent " always set autoindenting on
set pastetoggle=<F5> " allow paste with the mouse when press F5 (in insert mode)

" incremental search
set incsearch
highlight search
set hlsearch 

" searches are case insensitive unless they contain at least one capital letter
set ignorecase
set smartcase

" enable taglist
let Tlist_Use_Right_Window = 1
set t_ut=      " cleaning this var to fix vim background inside tmux (https://superuser.com/a/562423)
let vim_markdown_preview_toggle=2 " specific for vim-markdown-preview: enable preview on buffer write (:w)

" textwidth
set textwidth=200
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%101v', 101)

" wiki
let g:vimwiki_list = [{'path': '~/penseira/', 'syntax': 'markdown', 'ext': '.md'}]

" vim sessions
let g:sessions_dir = '$HOME/.vim/sessions'

" syntastic configurations
try
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_javascript_checkers = [ "eslint" ]
  let g:syntastic_python_checkers = [ "flake8" ]
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
catch /^Vim\%((\a\+)\)\=:E185/
  " deal with it
endtry

" Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Todo.txt
au filetype todo imap <buffer> + +<C-X><C-O>
au filetype todo imap <buffer> @ @<C-X><C-O>

" JsDoc plugin
let g:jsdoc_enable_es6=1
let g:jsdoc_allow_input_prompt=1
let g:jsdoc_input_description=1

""
" Look and Feel
""
set noshowmode           " removes the -- INSERT -- (we don't needed it, right?)
"needed to enable italic in vim
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
syntax on                " enable syntax
set t_Co=256             " terminal colors
set background=dark      " background color :P
try                      " put inside try block all gruvbox configs
  let g:gruvbox_italic=1 " this must be BEFORE colorscheme
  colorscheme gruvbox    " vim theme of choice
catch /^Vim\%((\a\+)\)\=:E185/
  " deal with it
endtry
set laststatus=2 " always display the status line
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.active = {}
let g:lightline.active.left = [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
let g:lightline.component_function = {}
let g:lightline.component_function.gitbranch = 'gitbranch#name'

" netrw (vim native file explorer)
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=25
let g:netrw_altv=1
" code indentation (https://stackoverflow.com/a/1878983)
set ts=4 sw=4 et
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

""
" Shortcuts and keybindings
""

" Disable the arrow keys 
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" shortcuts using the leader key
let mapleader=","                                                                                          " behold the new <Leader> key
nmap <Leader>r  :source %<CR>                                                                              " reload the current file
nmap <Leader>c  :tabe ~/.vimrc<CR>                                                                         " Open the config file
nmap <Leader>gn <Plug>GitGutterNextHunk                                                                    " git next
nmap <Leader>gp <Plug>GitGutterPrevHunk                                                                    " git previous
nmap <Leader>ga <Plug>GitGutterStageHunk                                                                   " git add (chunk)
nmap <Leader>gu <Plug>GitGutterUndoHunk                                                                    " git undo (chunk)
nmap <Leader>gs :Magit<CR>      	                                                                         " git status
nmap <Leader>gb :Gblame<CR>                                                                                " git blame
nmap <Leader>gc :Gcommit %<CR>                                                                             " git commit the current file
nmap <Leader>t  :TlistToggle<CR>                                                                           " show taglist pane
nmap <Leader>e  :Vexplore<CR>                                                                              " show file explorer
nmap <Leader>i  gg=G                                                                                       " fix file indentation
nmap <Leader>a  ggVG                                                                                       " Select all
"nmap <Leader>todo :Gista open --no-cache 9bb03999f58319d086ea58b0943f2104 todo.txt<CR>                     " open todo file
"nmap <Leader>done :Gista open --opener='split' --no-cache 9bb03999f58319d086ea58b0943f2104 done.txt<CR>    " open todo file
nmap <Leader>jsd  :JsDoc<CR>                                                                               " Add jsdoc to function (put cursor on function declaration)
nmap <Leader>cal  :Calendar -view=year -split=vertical -width=27<CR>

" Clipboard (requires +clipboard flag available (source: https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim))
" If you running on WSL, this link will be useful: https://superuser.com/questions/1291425/windows-subsystem-linux-make-vim-use-the-clipboard
noremap <Leader>Y "+y
noremap <Leader>X "+x
noremap <Leader>P "+p

" Better scrolling
noremap <C-j> 10<C-e>
noremap <C-k> 10<C-y>

" Save session
exec 'noremap <Leader>ss :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'    
" Restore session
exec 'noremap <Leader>sr :so ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'     

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-w> <plug>(fzf-complete-word)
imap <c-x><c-p> <plug>(fzf-complete-path)
imap <c-x><c-f> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Toggle search highlighting
nmap <F3> :set hlsearch!<CR>

inoremap <expr> <C-K> ShowDigraphs() 
