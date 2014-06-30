" Copyright (C) 2011 KaoriYa/MURAOKA Taro
"
"
"#####表示設定#####
set title "編集中のファイル名を表示
syntax on "コードの色分け
set tabstop=2 "インデントをスペース4つ分に設定
set shiftwidth=2
set smartindent "オートインデント
set cursorline
hi CursorLine   term=reverse cterm=none ctermbg=195
set cursorcolumn
hi CursorColumn term=reverse cterm=none ctermbg=195

set guifont=Ricty\ 13
" "#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
""クリップボードをWindowsと連携する
set clipboard+=autoselect
set guioptions+=a
set clipboard=unnamed
"新しい行のインデントを現在行と同じにする
set autoindent 
"タブの代わりに空白文字を指定する
set expandtab
set number

" status line
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
:set laststatus=2 

" ファイル名補完の強化
set wildmode=list:longest


set nocompatible               " be iMproved
filetype off

if has('vim_starting')
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
" NeoBundle 'Shougo/neobundle.vim'
" NeoBundle 'Shougo/vimproc'
" NeoBundle 'VimClojure'
" NeoBundle 'Shougo/vimshell'
" NeoBundle 'Shougo/unite.vim'
" NeoBundle 'Shougo/neocomplcache'
" NeoBundle 'Shougo/neosnippet'
" NeoBundle 'jpalardy/vim-slime'
" NeoBundle 'scrooloose/syntastic'
" NeoBundle 'https://bitbucket.org/kovisoft/slimv'
NeoBundle 'vim-ruby/vim-ruby'

filetype plugin indent on     " required!
filetype indent on
syntax on

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


