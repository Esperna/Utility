filetype plugin indent on
syntax on

"vi互換動作の無効化
set nocompatible
set encoding=utf-8


"Search"
"----------------------------------------------------"
"ハイライト
set hlsearch
"検索時大文字小文字区別しない
set ignorecase
"小文字検索時大文字と小文字を区別しない
set smartcase
"----------------------------------------------------"

"Display"
"----------------------------------------------------"
set incsearch
set ruler
set number
set title
set cursorline
set showcmd
syntax enable
set shiftwidth=4
set softtabstop=4
"インデント時半角スペース挿入
set expandtab
set tabstop=4
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデント
set smarttab
set backspace=indent,eol,start
"画面の端で行を折り返さない
set nowrap
"括弧を入力した時に、対応する括弧に一瞬カーソル飛ぶ
set showmatch matchtime=1
"vimの矩形選択で文字が無くても右へ進める
set virtualedit=block
"ステータス行に現在のgitブランチを表示
set statusline+=%{fugitive#statusline()}
"----------------------------------------------------"


"Input"
"----------------------------------------------------"
"C言語風のプログラミング言語向けの自動インデント
set smartindent
"tabキーによるファイル名補完有効
set wildmenu

set autoindent
"ファイル切替操作時に保存
set autowrite

"レジスタを指定せずにコピー/ペーストを行なった場合は クリップボードを利用
set clipboard=unnamed

"行跨ぎの移動
"set whichwrap=b,s,h,l,<,>,[,]

" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

"補完ウィンドウが表示された時に最初の1件目を選択状態にしておきたい
"Enterで補完対象を確定したい
"選んでいる時はまだ挿入したくない
set completeopt=menuone,noinsert
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><Caltercation/vim-colors-solarized-p> pumvisible() ? "<Up>" : "<C-p>"
"----------------------------------------------------"


"Plugin"
"----------------------------------------------------"
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
"Dark Color Scheme
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
Plug 'ulwlu/elly.vim'

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

"For automated completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"For Html Tag
Plug 'alvan/vim-closetag'

"Clang Formatter
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-clang-format'

call plug#end()

autocmd FileType c ClangFormatAutoEnable

let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

"For Html Tag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.php,*.vue'
"ディレクトリツリーの操作
map <C-r> :NERDTreeToggle<CR>
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

let g:deoplete#enable_at_startup = 1

" Required:
filetype plugin indent on

colorscheme jellybeans
"set background=dark

autocmd QuickFixCmdPost *grep* cwindow
" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif


"全角スペースをハイライト表示
"----------------------------------------------------"
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
"----------------------------------------------------"

"ファイルを開いたときに自動でカーソルが前回あった位置に移動
"----------------------------------------------------"
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
"----------------------------------------------------"

"Goの指定された式から左側を完成させる
autocmd FileType go nnoremap <silent> ge :<C-u>silent call go#expr#complete()<CR>
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 OR :silent call CocAction('runCommand', 'editor.action.organizeImport')

