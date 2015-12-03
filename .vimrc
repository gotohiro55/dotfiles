set nocompatible
set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
"set termencoding=

" 以下の設定はvimのみ有効(viでは無効)
if 1
  "---------------------------
  " Start Neobundle Settings.
  "---------------------------
  if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
  endif

  call neobundle#begin(expand('~/.vim/bundle/'))

  " Let NeoBundle manage NeoBundle
  NeoBundleFetch 'Shougo/neobundle.vim'

  " My Bundles here:
  NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw 64',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \    },
  \ }
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/vimfiler'
  NeoBundle 'itchyny/lightline.vim'

  " NeoBundle 'The-NERD-tree'
  " NeoBundle 'The-NERD-Commenter'
  " NeoBundle 'Gist.vim'
  NeoBundle 'vim-ruby/vim-ruby'
  NeoBundle 'thinca/vim-qfreplace'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'tpope/vim-fugitive'

  " 選択中にShift-S + "でカッコで囲む
  NeoBundle 'tpope/vim-surround'

  " indentの深さに色を付ける
  NeoBundle 'nathanaelkane/vim-indent-guides'
  " ペインのサイズ変更で使う
  NeoBundle 'kana/vim-submode'

  "--- colorscheme ---
  NeoBundle 'nanotech/jellybeans.vim'
  NeoBundle 'tomasr/molokai'
  NeoBundle 'sjl/badwolf'
  NeoBundle 'w0ng/vim-hybrid'
  NeoBundle 'noahfrederick/vim-hemisu'
  "--- colorscheme ---

  call neobundle#end()

  filetype plugin indent on

  " インストールのチェック
  NeoBundleCheck

  "-------------------------
  " End Neobundle Settings.
  "-------------------------

  "----- Shougo/unite.vim -----
  let g:unite_enable_start_insert=0
  let g:unite_source_history_yank_enable =1
  let g:unite_source_file_mru_limit = 200

  "----- Shougo/vimfiler -----
  let g:vimfiler_safe_mode_by_default = 0
  "let g:vimfiler_as_default_explorer = 1
  "let g:vimfiler_edit_action = 'tabopen'
  
  "----- itchyny/lightline.vim -----
  let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ 'mode_map': {'c': 'NORMAL'},
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
          \ },
          \ 'component_function': {
          \   'modified': 'LightLineModified',
          \   'readonly': 'LightLineReadonly',
          \   'filename': 'LightLineFilename',
          \   'fileformat': 'LightLineFileformat',
          \   'filetype': 'LightLineFiletype',
          \   'fileencoding': 'LightLineFileencoding',
          \   'mode': 'LightLineMode'
          \ }
          \ }

  " Gitのブランチ名を出したい場合
  "       \   'fugitive': 'LightLineFugitive',

  function! LightLineModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! LightLineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
  endfunction

  function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
          \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
          \  &ft == 'unite' ? unite#get_status_string() :
          \  &ft == 'vimshell' ? vimshell#get_status_string() :
          \ '' != expand('%') ? expand('%') : '[No Name]') .
          \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
  endfunction

  function! LightLineFugitive()
    try
      if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        return fugitive#head()
      endif
    catch
    endtry
    return ''
  endfunction

  function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction

  function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction

  function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction

  function! LightLineMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
  endfunction

  "----- mattn/emmet-vim -----
  let g:user_emmet_leader_key='<c-e>'

  "----- colorscheme -----
  "colorscheme darkblue
  colorscheme jellybeans
  "colorscheme molokai
  "colorscheme badwolf
  "colorscheme hybrid
  "colorscheme hemisu
  set background=dark
  "set background=light

  "----- nathanaelkane/vim-indent-guides -----
  "let g:indent_guides_start_level=2
  "let g:indent_guides_auto_colors=0
  "let g:indent_guides_enable_on_vim_startup=1
  "let g:indent_guides_color_change_percent=20
  "let g:indent_guides_guide_size=1
  "let g:indent_guides_space_guides=1

  "hi IndentGuidesOdd  ctermbg=235
  "hi IndentGuidesEven ctermbg=235
  let g:indent_guides_enable_on_vim_startup=1
  let g:indent_guides_start_level=2
  let g:indent_guides_auto_colors=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238
  let g:indent_guides_color_change_percent = 30
  let g:indent_guides_guide_size = 1
  au FileType coffee,ruby,javascript,python,yaml IndentGuidesEnable
  nmap <silent><Leader>ig <Plug>IndentGuidesToggle

  " 自動的に開いたファイルのディレクトリに移動する
  "set autochdir
endif

syntax enable

" ツールバーとメニューバーを非表示
set guioptions-=T
set guioptions-=m


" ### Windowsのvimで挿入モードのIMEをデフォルトオフにする ###########
set iminsert=0
set imsearch=-1

" listcharsで指定した特殊文字を表示する
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%,eol:¬

"全角スペースをハイライト表示
"function! ZenkakuSpace()
"    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
"endfunction

"if has('syntax')
"    augroup ZenkakuSpace
"        autocmd!
"        autocmd ColorScheme       * call ZenkakuSpace()
"        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
"    augroup END
"    call ZenkakuSpace()
"endif

set title "編集中のファイル名を表示
set tabstop=2 "インデントをスペース4つ分に設定
set shiftwidth=2
set smartindent "オートインデント
augroup vimrc
autocmd! FileType c setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd! FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END
"set cursorline
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" hi clear CursorLine
" set cursorcolumn
" hi CursorColumn term=reverse cterm=none ctermbg=195

" "#####検索設定#####
set incsearch " インクリメンタルサーチ
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set hlsearch "検索結果のハイライト
" EscEsc でハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"新しい行のインデントを現在行と同じにする
"set autoindent 
"タブの代わりに空白文字を指定する
set expandtab
set number

" status line
:set laststatus=2 
" %< - 行が長すぎるときに切り詰める位置
" %f - ファイル名（相対パス）
" %F - ファイル名（絶対パス）
" %t - ファイル名（パス無し)
"
" %m - 修正フラグ （[+]または[-]）
" %r - 読み込み専用フラグ（[RO]）
" %h - ヘルプバッファ
" %w - preview window flag
"
" %{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'} -
" fileencodingとfileformatを表示
"
" %= - 左寄せと右寄せ項目の区切り（続くアイテムを右寄せにする）
" %l - 現在のカーソルの行番号
" %L - 総行数
" %c - column番号
" %V - カラム番号
" %P - カーソルの場所 %表示
":set statusline=%F%m%r%h%w\ [%{&ff}]\ [%{&fenc}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%<%f\ %m%r%h%w
"set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
"set statusline+=%=%l/%L,%c%V%8P

" ファイル名補完の強化
set wildmode=list:longest


" netrwは常にtree view
let g:netrw_liststyle = 3
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

" バックスペースの動作
set backspace=indent,eol,start


if has('mac')
  set t_ut=
  set t_Co=256
  set guifont=RictyDiminished-Regular:h14
  set clipboard=unnamed
  "set clipboard+=autoselect
elseif has('unix')
  set guifont=Ricty\ 13
  set clipboard=unnamedplus
  ""set guioptions+=a
  ""set clipboard+=autoselect
  set t_ut=
  set t_Co=256
elseif has('win64')
  set guifont=Ricty:h11
  let g:vimproc_dll_path = $HOME . '.vim/bundle/vimproc.vim/autoload/vimproc_win64.dll'

  "クリップボードをWindowsと連携する
  set clipboard+=unnamed
elseif has('win32')
  set guifont=Ricty:h11
  let g:vimproc_dll_path = $HOME . '.vim/bundle/vimproc.vim/autoload/vimproc_win32.dll'

  "クリップボードをWindowsと連携する
  set clipboard+=unnamed
endif

" === キーバインド ===

" http://postd.cc/how-to-boost-your-vim-productivity/
" 1. LeaderをSpaceキーにする
let mapleader = "\<Space>"
"let mapleader = ","

" ビジュアルモード選択した部分を*で検索できる。
vnoremap * "zy:let @/ = @z<CR>n

" <Space>wを押してファイルを保存する
nnoremap <Leader>w :w<CR>
" <Space>qを押してファイルを閉じる
nnoremap <Leader>q :q<CR>

" <Space>hで行頭へ移動
noremap <Leader>h 0

" <Space>lで行頭へ移動
noremap <Leader>l $

" <Space>cでカーソルラインのON/OFF
noremap <Leader>c :setlocal cursorline!<CR>

" # 括弧を入力した時の自動補完
" http://d.hatena.ne.jp/spiritloose/20061113/1163401194
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"vnoremap { "zdi{<C-R>z}<ESC>
"vnoremap [ "zdi[<C-R>z]<ESC>
"vnoremap ( "zdi(<C-R>z)<ESC>
"vnoremap " "zdi"<C-R>z"<ESC>
"vnoremap ' "zdi'<C-R>z'<ESC>

" Ctrl-p で0番レジスタ(自分でヤンクしたテキスト)をペーストする
vnoremap <silent> <C-p> "0p<CR>

" カーソル位置の単語を置換する
noremap  [Replace] <Nop>
map      <Space>r  [Replace]
nnoremap <expr> [Replace]c ':%s ;' . expand('<cword>') . ';'
vnoremap <expr> [Replace]c ':%s ;' . expand('<cword>') . ';'

"----- Shougo/vimfiler -----
"noremap  <Leader>f <Nop>
nnoremap <silent> <Leader>ff :VimFilerBufferDir<CR>
"nnoremap <silent> <Leader>fv :VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
nnoremap <silent> <Leader>fv :VimFilerBufferDir -split<CR>
nnoremap <silent> <Leader>ft :VimFilerBufferDir -tab<CR>

"----- Shougo/unite.vim -----
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap [unite]    <Nop>
nmap     <Leader>u [unite]
nnoremap <silent> [unite]f    :<C-u>Unite file<CR>
nnoremap <silent> [unite]b    :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]t    :<C-u>Unite tab<CR>
nnoremap <silent> [unite]m    :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]u    :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> [unite]y    :<C-u>Unite history/yank<CR>
" nnoremap <silent> [unite]urc  :<C-u>Unite file_rec/async:app/controllers/ <CR>
" nnoremap <silent> [unite]urm  :<C-u>Unite file_rec/async:app/models/ <CR>
" nnoremap <silent> [unite]urv  :<C-u>Unite file_rec/async:app/views/ <CR>

" ### タブ関連
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map [Tag]e :tabe 
map <silent> [Tag]n :tabnew<CR>
map <silent> [Tag]h :tabrewind<CR>
map <silent> [Tag]l :tablast<CR>
map <silent> [Tag]o :tabonly<CR>
map <silent> [Tag]c :tabclose<CR>
map <silent> [Tag]k :tabclose<CR>
map <silent> <Tab> :tabnext<CR>
map <silent> <S-Tab> :tabprevious<CR>

" 個別のタブの表示設定をします
" ### ウインドウ/ペイン関連
" Vimの便利な画面分割＆タブページと、それを更に便利にする方法 - Qiita
" http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
nnoremap [Scr]  <Nop>
nmap     f      [Scr]
nnoremap [Scr]  <Nop>
nnoremap [Scr]j <C-w>j
nnoremap [Scr]k <C-w>k
nnoremap [Scr]l <C-w>l
nnoremap [Scr]h <C-w>h
nnoremap [Scr]J <C-w>J
nnoremap [Scr]K <C-w>K
nnoremap [Scr]L <C-w>L
nnoremap [Scr]H <C-w>H
nnoremap [Scr]n gt
nnoremap [Scr]p gT
nnoremap [Scr]r <C-w>r
nnoremap [Scr]- <C-w>_<C-w>|
nnoremap [Scr]= <C-w>=
nnoremap [Scr]w <C-w>w
nnoremap [Scr]o <C-w>o
nnoremap [Scr]N :<C-u>bn<CR>
nnoremap [Scr]P :<C-u>bp<CR>
nnoremap [Scr]t :<C-u>tabnew<CR>
nnoremap [Scr]T :<C-u>Unite tab<CR>
nnoremap [Scr]s :<C-u>sp<CR><C-w>j
nnoremap [Scr]v :<C-u>vs<CR><C-w>l
nnoremap [Scr]q :<C-u>q<CR>
nnoremap [Scr]Q :<C-u>bd<CR>
call submode#enter_with('bufmove', 'n', '', 'f>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 'f<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 'f+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 'f-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

function! GuiTabLabel()
  " タブで表示する文字列の初期化をします
  let l:label = ''

  " タブに含まれるバッファ(ウィンドウ)についての情報をとっておきます。
  let l:bufnrlist = tabpagebuflist(v:lnum)

  " 表示文字列にバッファ名を追加します
  " パスを全部表示させると長いのでファイル名だけを使います 詳しくは help fnamemodify()
  let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
  " バッファ名がなければ No title としておきます。ここではマルチバイト文字を使わないほうが無難です
  let l:label .= l:bufname == '' ? 'No title' : l:bufname

  " タブ内にウィンドウが複数あるときにはその数を追加します(デフォルトで一応あるので)
  let l:wincount = tabpagewinnr(v:lnum, '$')
  if l:wincount > 1
    let l:label .= '[' . l:wincount . ']'
  endif

  " このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
  for bufnr in l:bufnrlist
    if getbufvar(bufnr, "&modified")
      let l:label .= '[+]'
      break
    endif
  endfor

  " 表示文字列を返します
  return l:label
endfunction

" guitablabel に上の関数を設定します
" その表示の前に %N というところでタブ番号を表示させています
set guitablabel=%N:\ %{GuiTabLabel()}


" ########### CUIのvim用
" 各タブページのカレントバッファ名+αを表示
function! s:tabpage_label(n)
  " t:title と言う変数があったらそれを使う
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif

  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)

  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " バッファが複数あったらバッファ数を表示
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif

  " タブページ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) ==# '' ? '' : ' '  " 隙間空ける

  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
  "let fname = pathshorten(bufname(curbufnr))
  let fname = fnamemodify(bufname(curbufnr), ':t')

  let label = no . mod . sp . fname

  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction

function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' | '  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  let info = ''  " 好きな情報を入れる
  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfunction

set tabline=%!MakeTabLine()
" ########### CUIのvim用 タブ設定おわり
