filetype plugin indent on

syntax on

set nowrap
set title
set hlsearch
set ignorecase
set smartcase
set nocompatible
filetype plugin on
set encoding=utf-8

set autoindent
set autowrite
set virtualedit=block

set incsearch
set ruler
set number
set cursorline
set smartindent
set wildmenu
set showcmd
syntax enable

set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
set smarttab
set backspace=indent,eol,start

set clipboard=unnamed
set showmatch matchtime=1
"set whichwrap=b,s,h,l,<,>,[,]

" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

set completeopt=menuone,noinsert
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"


call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
Plug 'croaker/mustang-vim'
Plug 'jeffreyiacono/vim-colors-wombat'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-scripts/Lucius'
Plug 'vim-scripts/Zenburn'
Plug 'mrkn/mrkn256.vim'
Plug 'jpo/vim-railscasts-theme'
Plug 'therubymug/vim-pyte'
Plug 'tomasr/molokai'
Plug 'Shougo/unite.vim'
Plug 'ujihisa/unite-colorscheme'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-fugitive'
Plug '110y/vim-go-expr-completion', {'branch': 'master'}
Plug 'rking/ag.vim'
Plug 'Shougo/vimproc.vim', { 'dir': '~/.vim/plugged/vimproc.vim', 'do': 'make' }

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

"For automated completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

map <C-r> :NERDTreeToggle<CR>
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

let g:deoplete#enable_at_startup = 1

" Required:
filetype plugin indent on

colorscheme industry

autocmd QuickFixCmdPost *grep* cwindow
" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

set statusline+=%{fugitive#statusline()}

function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

autocmd FileType go nnoremap <silent> ge :<C-u>silent call go#expr#complete()<CR>
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" If there are uninstalled bundles found on startup,
" this will conv
