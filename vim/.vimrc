" 文字コード
set encoding=utf-8
set fileencoding=utf-8

" viとの互換性をとらない
set nocompatible

" 改行コードの自動認識
set fileformats=unix,dos,mac

" ビープ音を鳴らさない
set vb t_vb=

" バックスペースキーで削除できるものを指定
set backspace=indent,eol,start

" 行番号を表示
set number

" ルーラーを表示
set ruler

" 入力中のコマンドをステータスに表示する
set showcmd

" ステータスラインを常に表示
set laststatus=2

" 括弧入力時に対応する括弧を表示
set showmatch

" シンタックスハイライトを有効にする
syntax on

" 検索結果文字列のハイライトを有効にする
set hlsearch

" コメント文の色を変更
highlight Comment ctermfg=DarkCyan

" コマンドライン補完を拡張モードにする
set wildmenu

" 入力されているテキストの最大幅
" （勝手に改行される）を無効にする
set textwidth=0

" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap

" ステータスラインに表示する情報の指定
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>

" ステータスラインの色
highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=white

" 1つのTABに対応する空白の数
set tabstop=4
set softtabstop=4

" インデント1つに使われる空白の数
set shiftwidth=4

" タブを挿入する時、代わりに空白を使わない
set noexpandtab

" バッファを切り替えてもundoの効力を失わない
set hidden

" 起動時のメッセージを表示しない
set shortmess+=I

