"-----------------------------------------------
" neovim 配置文件
" changzhaozhong
"-----------------------------------------------

"################################## general settings ###########################
" 关闭文件类型自动检测功能,被filetype plugin indent on代替
filetype off 
source ~\AppData\Local\nvim\_machine_specific.vim

" === vim general setting
set encoding=utf-8 " 设置编码格式为utf-8
set fileencodings=utf-8,ucs-bom,GB2312,big5 " 自动判断编码时,依次尝试下编码

set number "display line number, set nu, set nonu
set relativenumber
set cursorline "highlight current line
set noexpandtab "用制表符表示一个缩
set tabstop=2 "按一个tab之后，显示出来的空格数，默认8
set shiftwidth=2 "表示每一级缩进的长度，一般设置成跟 softtabstop 一样
set softtabstop=2 "表示在编辑模式的时候按退格键的时候退回缩进的长度
set autoindent
set list "显示非可见字符
set colorcolumn=81
set showmatch " 当光标移动到一个括号时,高亮显示对应的另一个括号
set backspace=indent,eol,start " 对退格键提供更好帮助 
set history=1000 "设置历史操作记录为1000条
set nocompatible " 不启用vi的键盘模式,而是vim自己的
syntax on
filetype plugin indent on " 载入文件类型插件,代替filetype off
set autoindent " 自动套用上一行的缩进方式
set smartindent " 开智能缩进
set scrolloff=4 " 光标移动到buffer的顶部和底部保持4行继续
set ic " 搜索时不区分大小写,是set ignorecase缩写.如果你想启用,输入:set noic(noignorecase缩写)
set hlsearch " 搜索的时候随字符高亮

"打开文件后，光标定位到上次退出的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"################################## basic mappings #############################
let mapleader=','

" Open the vimrc file anytime
noremap <LEADER>rc :e ~\AppData\Local\nvim\init.vim<CR>
noremap <LEADER>sorc :so $MYVIMRC<CR>

" ctrl+s 保存 	Insert mode
" linux默认情况下ctrl+s是锁定terminal,需要ctrl+q解锁.在.bashrc 设置 stty-ixon可以禁用
imap <C-s> <Esc>:w!<CR>i
"ctrl+a	全选+复制 Normal+Insert+visual mode
map <C-A> ggVG
map! <C-A> <Esc>ggVG

" make Y to copy till the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap cy "+y
nnoremap cp "+p

" Indentation
nnoremap < <<
nnoremap > >>

" Search
noremap <LEADER><CR> :nohlsearch<CR>

" Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Space to Tab
nnoremap <LEADER>tt :%s/    /\t/g
vnoremap <LEADER>tt :s/    /\t/g

" Folding
noremap <silent> <LEADER>o za

" switch buffer
noremap <c-tab> :bp<CR>


" ===
" === Cursor Movement
" ===
" U/E keys for 5 times u/e (faster navigation)
"noremap <silent> U 5k
"noremap <silent> E 5j

" Faster in-line navigation
noremap W 5w
noremap B 5b

" set h (same as n, cursor left) to 'end of word'
"noremap h e

" Ctrl + U or E will move up/down the view port without moving the cursor
noremap <C-U> 5<C-y>
noremap <C-E> 5<C-e>

" === Insert Mode Cursor Movement
inoremap <C-a> <ESC>A

" === Searching
"noremap - N
noremap = n

" === Window management
" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l

" Disable the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap su :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sn :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sj :set splitbelow<CR>:split<CR>
"noremap sn :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set nosplitright<CR>:vsplit<CR>:set splitright<CR>

" Resize splits with arrow keys
noremap <up> :res +2<CR>
noremap <down> :res -2<CR>
noremap <left> :vertical resize-2<CR>
noremap <right> :vertical resize+2<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>

" === Tab management
" Create a new tab with tu
noremap tu :tabe<CR>
" Move around tabs with tn and ti
noremap tn :-tabnext<CR>
noremap ti :+tabnext<CR>
" Move the tabs with tmn and tmi
noremap tmn :-tabmove<CR>
noremap tmi :+tabmove<CR>

"################################## function ###################################
" Compile function
noremap run :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
	  exec "!time ./%<"	
		":term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device
		CocCommand flutter.dev.openDevLog
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc

"################################## 插件管理 ###################################
call plug#begin('d:\neovim\share\nvim\plugged')

" About themes
Plug 'morhetz/gruvbox'
"Plug 'bling/vim-airline'
Plug 'liuchengxu/eleline.vim'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'

" About efficientcy
Plug 'jiangmiao/auto-pairs'
Plug 'tell-k/vim-autopep8'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
"Plug 'honza/vim-snippets'
Plug 'theniceboy/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " 代码补全

" About assistance
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'Yggdroot/LeaderF' " 异步文件糊糊搜索及类似文本搜索与跳转

" About Applications
Plug 'itchyny/calendar.vim'
Plug 'skywind3000/asyncrun.vim'
Plug '907th/vim-auto-save'

" git
Plug 'airblade/vim-gitgutter'

call plug#end()

"################################## 插件设置 ###################################
" === NERDTree
let NERDTreeChDirMode=2   " 设置当前目录为nerdtree的起始目录
let NERDChristmasTree=1   " 使得窗口有更好看的效果
let NERDTreeMouseMode=1   " 双击鼠标左键打开文件
let NERDTreeWinSize=25    " 设置窗口宽度为25
let NERDTreeQuitOnOpen=1  " 打开一个文件时nerdtree分栏自动关闭
" 打开文件默认开启文件树
autocmd VimEnter * NERDTree
nnoremap <leader>NEC :NERDTree C:\<CR>
nnoremap <leader>NED :NERDTree D:\<CR>
nnoremap <leader>NEE :NERDTree E:\<CR>
nnoremap <leader>NEF :NERDTree F:\<CR>
nnoremap <leader>NEG :NERDTree G:\<CR>
nnoremap <leader>NEH :NERDTree H:\<CR>
nnoremap <leader>NEI :NERDTree I:\<CR>
nnoremap <leader>NEJ :NERDTree J:\<CR>
nnoremap <leader>NEK :NERDTree K:\<CR>
nnoremap <leader>NEL :NERDTree L:\<CR>
nnoremap <leader>NES :NERDTree S:\<CR>

" === auto format
"vim-autopep8设置,关闭diff提示
let g:autopep8_disable_show_diff=1

" === FZF
noremap <C-f> :Files<CR>
"noremap <C-f> :Rg<CR>
noremap <C-h> :History<CR>
"noremap <C-t> :BTags<CR>
noremap <C-l> :Lines<CR>
noremap <C-b> :Buffers<CR>
noremap <leader>; :History:<CR>

let g:fzf_preview_window = 'right:60%'
"let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

noremap <c-d> :BD<CR>

function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  " 设置浮动窗口打开的位置，大小等。
  " 这里的大小配置可能不是那么的 flexible 有继续改进的空间
  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col + 30,
        \ 'width': width * 2 / 3,
        \ 'height': height / 2
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  " 设置浮动窗口高亮
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction

let $FZF_DEFAULT_OPTS = '--layout=reverse'
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

" === LeaderF
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
nnoremap <silent> <Leader>lf :Leaderf file<CR> 
nnoremap <silent> <Leader>lm :Leaderf mru<CR> 
nnoremap <silent> <Leader>lb :Leaderf buffer<CR> 
nnoremap <silent> <Leader>lF :Leaderf function<CR>
nnoremap <silent> <Leader>lrg :Leaderf rg<CR>
nnoremap <silent> <Leader>lt :Leaderf tag<CR>
nnoremap <silent> <Leader>lc :Leaderf colorscheme<CR>
nnoremap <silent> <Leader>ll :Leaderf line<CR>

" === coc
" fix the most annoying bug that coc has
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
"let g:coc_node_path = "C:\\Program Files\\nodejs\\node.exe"
"let g:coc_node_path = $ProgramFiles\nodejs\node.exe
let g:coc_global_extensions = [
  \ 'coc-actions',
  \ 'coc-css',
  \ 'coc-diagnostic',
  \ 'coc-explorer',
  \ 'coc-flutter',
  \ 'coc-gitignore',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-sourcekit',
  \ 'coc-stylelint',
  \ 'coc-syntax',
  \ 'coc-tasks',
  \ 'coc-todolist',
  \ 'coc-translator',
  \ 'coc-tslint-plugin',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-vimlsp',
  \ 'coc-yaml',
  \ 'coc-emmet',
  \ 'coc-yank']
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]	=~ '\s'
endfunction
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-o> coc#refresh()
function! Show_documentation()
	call CocActionAsync('highlight')
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <LEADER>h :call Show_documentation()<CR>
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Open up coc-commands
nnoremap <c-c> :CocCommand<CR>
" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" coctodolist
nnoremap <leader>tn :CocCommand todolist.create<CR>
nnoremap <leader>tl :CocList todolist<CR>
nnoremap <leader>tu :CocCommand todolist.download<CR>:CocCommand todolist.upload<CR>
" coc-tasks
noremap <silent> <leader>ts :CocList tasks<CR>
" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-e> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-e>'
let g:coc_snippet_prev = '<c-n>'
imap <C-e> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'David'

nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)

" === Undotree
noremap <leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> u <plug>UndotreeNextState
	nmap <buffer> e <plug>UndotreePreviousState
	nmap <buffer> U 5<plug>UndotreeNextState
	nmap <buffer> E 5<plug>UndotreePreviousState
endfunc

" === vim-calendar
"noremap \c :Calendar -position=here<CR>
noremap \\ :Calendar -view=clock -position=here<CR>
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
augroup calendar-mappings
	autocmd!
	" diamond cursor
	autocmd FileType calendar nmap <buffer> u <Plug>(calendar_up)
	autocmd FileType calendar nmap <buffer> n <Plug>(calendar_left)
	autocmd FileType calendar nmap <buffer> e <Plug>(calendar_down)
	autocmd FileType calendar nmap <buffer> i <Plug>(calendar_right)
	autocmd FileType calendar nmap <buffer> <c-u> <Plug>(calendar_move_up)
	autocmd FileType calendar nmap <buffer> <c-n> <Plug>(calendar_move_left)
	autocmd FileType calendar nmap <buffer> <c-e> <Plug>(calendar_move_down)
	autocmd FileType calendar nmap <buffer> <c-i> <Plug>(calendar_move_right)
	autocmd FileType calendar nmap <buffer> k <Plug>(calendar_start_insert)
	autocmd FileType calendar nmap <buffer> K <Plug>(calendar_start_insert_head)
	" unmap <C-n>, <C-p> for other plugins
	autocmd FileType calendar nunmap <buffer> <C-n>
	autocmd FileType calendar nunmap <buffer> <C-p>
augroup END

" === rainbow
let g:rainbow_active = 1

" === AsyncRun
noremap gp :AsyncRun git push<CR>

" === AsyncTasks
let g:asyncrun_open = 6

" === eleline.vim
let g:airline_powerline_fonts = 1
"let g:eleline_powerline_fonts = 0
"let g:eleline_slim = 1 "精简模式

" === vim auto save
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "TextChangedI", "CursorHoldI", "CompleteDone"]

" == GitGutter
" let g:gitgutter_signs = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
" autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- ::/GitGutterPrevHunk<CR>

"################################## vim设置 ####################################
" === F功能键
nnoremap <F3> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" F6自动格式化
autocmd FileType python noremap <buffer> <F6> :call Autopep8()<CR>
noremap <F5> :call CompileRunGcc()<CR>

" === python 文件设置
" 开启语法高亮
let python_highlight_all=1
" 设定tab的格数为4
au Filetype python set tabstop=4
" 设置编辑模式下tab的宽度
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set textwidth=79
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99

" === vim display
"set background=light                                           " 设置vim背景为浅色
set background=dark                                             " 设置vim背景为深色
set cursorline                                                  " 突出显示当前行
colorscheme gruvbox                                             " 设置gruvbox高亮主题
"highlight Normal guibg=NONE ctermbg=None "透明背景
" vim的配色
hi vertsplit ctermbg=bg guibg=bg
hi GitGutterAdd ctermbg=bg guibg=bg
hi GitGutterChange ctermbg=bg guibg=bg
hi GitGutterDelete ctermbg=bg guibg=bg
hi GitGutterChangeDelete ctermbg=bg guibg=bg
hi SyntasticErrorSign ctermbg=bg guibg=bg
hi SyntasticWarningSign ctermbg=bg guibg=bg
hi FoldColumn ctermbg=bg guibg=bg


