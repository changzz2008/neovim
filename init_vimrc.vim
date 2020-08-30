"
"Vim 在与屏幕/键盘交互时使用的编码(取决于实际的终端的设定)
set encoding=utf-8
set langmenu=zh_CN.UTF-8
set ambiwidth=double "防止airline插件特殊符号无法正常显示
" 设置打开文件的编码格式
set fileencodings=utf-8,gbk,gb18030,gk2312,cp936
set fileencoding=utf-8
" 解决菜单乱码
"source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim


"Quickly Run
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        "exec "!time python %"
        exec "!python.exe %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
s        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

" 插件管理
" 关闭文件类型自动检测功能,这个功能被filetype plugin indent on代替
filetype off                 " 插件管理required

call plug#begin('d:\neovim\share\nvim\plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
"Plugin 'netrw.vim'
"Plugin 'scrooloose/nerdtree'
Plug 'Taglist.vim'
Plug 'winmanager'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plugin 'minibufexplorerpp'
Plug 'snipMate'
"Plugin 'davidhalter/jedi-vim'
Plug 'vim-scripts/DrawIt'
Plug 'sjl/gundo.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'skywind3000/asyncrun.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'klen/python-mode'

"Taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"WinManager
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>

"aieline
let g:airline_theme="molokai" 
""这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1   
"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" 设置字体
set guifont=Consolas\ for\ Powerline\ FixedD:h11
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" old vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'

"MiniBufExplorer
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"MiniBufExplorer++
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1

"Markdown
"let g:mkdp_path_to_chrome = ""
let g:mkdp_path_to_chrome = 'C:\Program Files (x86)\Google\Chrome\Application\Chrome'
let g:mkdp_auto_close=0
nmap<F7> :MarkdownPreview<CR>
nmap<F8> :MarkdownPreviewStop<CR>

"netrw
let g:netrw_liststyle = 4

"Gundo
let g:gundo_prefer_python3 = 1
nnoremap <leader>h :GundoToggle<CR>

"jedi
""let g:SuperTabDefaultCompletionType = "context"
""let g:jedi#popup_on_dot = 0
"let g:jedi#show_call_signatures_delay = 1
"let g:jedi#use_splits_not_buffers = "bottom"
"autocmd FileType python setlocal completeopt-=preview

"python-mode
let g:pymode_r = 1
"let g:python_mode = 'python3'
let g:pymode_run_bind = '<leader>r'
call plug#end()

set makeprg=mingw32-make
set pythonthreedll=python38.dll

syntax on
set nocompatible        " 不启用vi的键盘模式,而是vim自己的, required
filetype plugin indent on " 载入文件类型插件,代替filetype off
set ts=4
set noundofile
set nobackup
"set noswapfile

"************搜索设置***************
" 搜索的时候不区分大小写,是set ignorecase缩写.如果你想启用,输入:set noic(noignorecase缩写)
set ic
" 搜索的时候随字符高亮
set hlsearch

" 设置快捷键
let g:mapleader = ","          "全局前缀
"设置切换Buffer快捷键"
nnoremap <C-tab> :bn<CR>
nnoremap <C-s-tab> :bp<CR>
"nnoremap <C-dd> :bp|bd#<CR> "在多窗口buffer中,删除当前buffer
" ctrl-j/k/l/h  分屏窗口移动 Normal mode
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
"ctrl+a	全选+复制 Normal+Insert+visual mode
map <C-A> ggVG
map! <C-A> <Esc>ggVG
"ctrl+f 复制到系统粘贴板
map  <C-F> "+y
map! <C-F> "+y
" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-j> :resize +5<cr>
nnoremap <M-k> :resize -5<cr>
nnoremap <M-h> :vertical resize -5<cr>
nnoremap <M-l> :vertical resize +5<cr>
" ide delete
inoremap <C-BS> <Esc>bdei 
" ************行和列设置***************
set cursorline              " 显示行横线
set nu                      " 显示行号

" ######### 设置vim主题外观 #########
"set background=light       " 设置vim背景为浅色
set background=dark         " 设置vim背景为深色
set cursorline              " 突出显示当前行
"set cursorcolumn           " 突出显示当前列
"colorscheme solarized
"colorscheme desert
"colorscheme  molokai  
colorscheme gruvbox      
" ************** 终端配色 **************
set t_Co=256     "终端开启256色支持"
" ************** vim的配色 *************
hi vertsplit ctermbg=bg guibg=bg
hi GitGutterAdd ctermbg=bg guibg=bg
hi GitGutterChange ctermbg=bg guibg=bg
hi GitGutterDelete ctermbg=bg guibg=bg
hi GitGutterChangeDelete ctermbg=bg guibg=bg
hi SyntasticErrorSign ctermbg=bg guibg=bg
hi SyntasticWarningSign ctermbg=bg guibg=bg
hi FoldColumn ctermbg=bg guibg=bg
"不显示工具/菜单栏
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b
set lines=35 columns=140
" 设置 alt 键不映射到菜单栏,对于设置改变窗口大小的快捷键有关系，alt-h打开help
set winaltkeys=no

"cs a s:\src\cscope.out
