set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

"
" Toda lista de plugins deve ser colocada ENTRE os comandos begin() e end()
"
call vundle#begin()

" Vundle se auto-gerencia
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'                    " Exibe a arvore de diretorios 
Plugin 'mustache/vim-mustache-handlebars'       " syntax highlight para mustache / handlebars
Plugin 'ervandew/supertab'                      " Tab completion
Plugin 'nathanaelkane/vim-indent-guides'        " Exibe linhas de identacao
Plugin 'taglist.vim'                            " Source code browser baseado em tags (Pre-requisito: instalar ctags)
Plugin 'tpope/vim-fugitive'                     " Git wrapper para vim
"Plugin 'Lokaltog/vim-easymotion'                " Facil navegacao entre palavras
"Plugin 'bufexplorer.zip'                        " Atalhos para navegacao entre buffers
Plugin 'kien/ctrlp.vim'                         " Um finder melhorado para o vim.
Plugin 'bling/vim-airline'                      " Uma skin minimalista e objetiva para as barras de status do vim
Plugin 'tpope/vim-markdown'                     " Habilita a sintaxe de markdown
Plugin 'scrooloose/syntastic'                   " Corretor de sintaxe
Plugin 'tomtom/tcomment_vim'                    " Atalhos para comentários
Plugin 'jiangmiao/auto-pairs'                   " Fechador automático de parenteses, caracteres, etc.
"Plugin 'burnettk/vim-angular'                   " Corretor de sintaxe para angular

" Temas
Plugin 'altercation/vim-colors-solarized'       " Tema
Plugin 'Lokaltog/vim-distinguished'             " Tema bom para javascript
Plugin 'evgenyzinoviev/vim-vendetta'

call vundle#end()
filetype plugin indent on
"
" General Configurations
"
syntax on
"set number
set relativenumber
set backspace=2
set backspace=indent,eol,start
" indentation
set shiftwidth=4
set autoindent
set smartindent
set cindent

" Allow paste with the mouse when press F5 (in insert mode)
set pastetoggle=<F5>

" Color Scheme, identation, etc
set t_Co=256
set background=dark
"let g:solarized_termcolors=256
colorscheme vendetta
set ts=2 sw=2 et
let g:indent_guides_auto_colors=0
autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd guibg=black ctermbg=235
autocmd VimEnter,ColorScheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=237
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1 "enable on startup

" recognize specific files with known language syntax
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.wsdl set ft=xml

"
" Atalhos gerais
"
"### Atalhos com SHIFT
"# Shift + Left: Avanca para a aba esquerda
map <S-Left> gT
"# Shift + Right: Avanca para a aba direita
map <S-Right> gt


"######
"### Specific configs
"#####

"# NERDTree
map <C-n> :NERDTreeToggle<CR>

"# taglist
let Tlist_Use_Right_Window = 1
map <C-T> :TlistToggle<CR>

"# Airline
set laststatus=2
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'

let g:airline_symbols = {}
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 1

"# syntastic
map <C-s-i> :SyntasticInfo<CR>
map <C-s-c> :SyntasticCheck<CR>
map <C-s-e> :Errors<CR>
map <C-s-x> :lclose<CR>
map <C-s-o> :lopen<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_dockerfile_checkers = ["dockerfile_lint"]
" Disable the file checking on open/save for this file types. IF you want to
" check these files, you need to run :SyntasticCheck manually.
let g:syntastic_mode_map = { "mode": "active", "passive_filetypes": ["html", "hbs"] }

"
" Mapeamento das setas
"

" Disable the arrow keys 
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
