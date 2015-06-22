set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
"set termencoding=

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
" NeoBundle 'The-NERD-tree'
" NeoBundle 'The-NERD-Commenter'
" NeoBundle 'Gist.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-fugitive'

"--- colorscheme ---
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'sjl/badwolf'
"--- colorscheme ---

call neobundle#end()

filetype plugin indent on
filetype indent on

" インストールのチェック
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------

"----- Shougo/unite.vim -----
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap [unite]    <Nop>
nmap     <Space>u [unite]
nnoremap <silent> [unite]f    :<C-u>Unite file<CR>
nnoremap <silent> [unite]b    :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]m    :<C-u>Unite file_mru<CR>
" nnoremap <silent> [unite]urc  :<C-u>Unite file_rec/async:app/controllers/ <CR>
" nnoremap <silent> [unite]urm  :<C-u>Unite file_rec/async:app/models/ <CR>
" nnoremap <silent> [unite]urv  :<C-u>Unite file_rec/async:app/views/ <CR>

"----- mattn/emmet-vim -----
let g:user_emmet_leader_key='<c-e>'



" ツールバーとメニューバーを非表示
set guioptions-=T
set guioptions-=m

syntax on
"colorscheme darkblue
"colorscheme jellybeans
colorscheme molokai
"colorscheme badwolf

" 自動的に開いたファイルのディレクトリに移動する
set autochdir

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
" set cursorline
" hi clear CursorLine
" set cursorcolumn
" hi CursorColumn term=reverse cterm=none ctermbg=195

" "#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set hlsearch "検索結果のハイライト
" EscEsc でハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"クリップボードをWindowsと連携する
set clipboard+=unnamed
" set guioptions+=a
" set clipboard+=autoselect
"新しい行のインデントを現在行と同じにする
"set autoindent 
"タブの代わりに空白文字を指定する
set expandtab
set number

" status line
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
:set laststatus=2 

" ファイル名補完の強化
set wildmode=list:longest

set nocompatible
filetype plugin indent off

" netrwは常にtree view
let g:netrw_liststyle = 3
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

if has('unix')
  set guifont=Ricty\ 14
elseif has('win64')
  set guifont=Ricty:h11
  let g:vimproc_dll_path = $HOME . '.vim/bundle/vimproc.vim/autoload/vimproc_win64.dll'
elseif has('win32')
  set guifont=Ricty:h11
  let g:vimproc_dll_path = $HOME . '.vim/bundle/vimproc.vim/autoload/vimproc_win32.dll'
endif

" ### キーバインド
" # 括弧を入力した時の自動補完
" http://d.hatena.ne.jp/spiritloose/20061113/1163401194
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" Ctrl-p で0番レジスタ(自分でヤンクしたテキスト)をペーストする
vnoremap <silent> <C-p> "0p<CR>

" カーソル位置の単語を置換する
nnoremap  [Replace] <Nop>
nmap      <Space>r  [Replace]
nnoremap <expr> [Replace]c ':%s ;\<' . expand('<cword>') . '\>;'
vnoremap <expr> [Replace]c ':s ;\<' . expand('<cword>') . '\>;'

" ### タブ関連
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map [Tag]e :tabe 
" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> <Tab> :tabnext<CR>
" tp 前のタブ
map <silent> <S-Tab> :tabprevious<CR>

" 個別のタブの表示設定をします
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
