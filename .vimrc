"ファイル形式別プラグインのロードを有効化
filetype plugin on
filetype indent on

if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

" #### elixir
call dein#add('elixir-lang/vim-elixir')

" #### vim-easymotion
call dein#add('Lokaltog/vim-easymotion')
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" 「;」 + 何かにマッピング
let g:EasyMotion_leader_key=";"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

" #### clever-f
call dein#add('rhysd/clever-f.vim')

" #### vim-seek TODO 使わないかも
call dein#add('goldfeld/vim-seek')

" #### yankRing
call dein#add('YankRing.vim')
nmap ,y :YRShow<CR>

" #### undotree
call dein#add('mbbill/undotree')
nmap ,u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 'topleft'
let g:undotree_SplitWidth = 35
let g:undotree_diffAutoOpen = 1
let g:undotree_diffpanelHeight = 25
let g:undotree_RelativeTimestamp = 1
let g:undotree_TreeNodeShape = '*'
let g:undotree_HighlightChangedText = 1
let g:undotree_HighlightSyntax = "UnderLined"

" ######## easybuffer
call dein#add('troydm/easybuffer.vim')
nmap ,e :EasyBuffer<CR>

" ######## qfixfrep
call dein#add('fuenor/qfixgrep')
""nmap ,g :Grep -r
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" ######## neocomplete
call dein#add('Shougo/neocomplete')
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '¥*ku¥*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '¥h¥w*'
" Plugin key-mappings.
inoremap <expr><C-g>  neocomplete#undo_completion()
inoremap <expr><C-l>  neocomplete#complete_common_string()

" ######## caw
call dein#add('tyru/caw.vim')
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)

nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)

" ######## neosnippet
call dein#add('Shougo/neosnippet')
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" ######## nerdtree'
call dein#add('scrooloose/nerdtree')
nmap ,t :NERDTree<CR>
let g:NERDTreeChDirMode=2

" ####### unite
call dein#add('Shougo/unite.vim')
nmap ,f :Unite buffer file<CR>

" ####### unite outline
call dein#add('shougo/unite-outline')
let g:unite_split_rule = 'botright'

" \ oでunite-outlineを縦分割でかつ閉じないように表示する
nmap ,o :Unite -vertical -winwidth=30 -no-quit outline<CR>

" ####### easybracket-vim
call dein#add('MetalPhaeton/easybracket-vim')
let g:unite_split_rule = 'botright'

" ####### 検索ハイライトをクリア
nnoremap <silent> <C-L> :noh<C-L><CR>

" ####### ctags自動生成
call dein#add('alpaca-tc/alpaca_tags', {
              \    'depends': ['Shougo/vimproc'],
              \    'autoload' : {
              \       'commands' : [
              \          { 'name' : 'AlpacaTagsBundle', 'complete': 'customlist,alpaca_tags#complete_source' },
              \          { 'name' : 'AlpacaTagsUpdate', 'complete': 'customlist,alpaca_tags#complete_source' },
              \          'AlpacaTagsSet', 'AlpacaTagsCleanCache', 'AlpacaTagsEnable', 'AlpacaTagsDisable', 'AlpacaTagsKillProcess', 'AlpacaTagsProcessStatus',
              \       ],
              \    }
              \ })
let g:alpaca_tags#config = {
                       \    '_' : '-R --sort=yes',
                       \    'ruby': '--languages=+Ruby',
                       \ }
augroup AlpacaTags
  autocmd!
  if exists(':AlpacaTags')
    autocmd BufWritePost Gemfile AlpacaTagsBundle
    autocmd BufEnter * AlpacaTagsSet
    autocmd BufWritePost * AlpacaTagsUpdate
  endif
augroup END

" ####### switch.vim
call dein#add('AndrewRadev/switch.vim')
nnoremap - :Switch<CR>

" ###### openbrowser.vim
call dein#add('tyru/open-browser.vim')

" ###### react
call dein#add('pangloss/vim-javascript')
call dein#add('mxw/vim-jsx')
let g:jsx_ext_required = 0
let g:syntastic_javascript_checkers=['jsxhint']

call dein#add('scrooloose/syntastic')
call dein#add('pmsorhaindo/syntastic-local-eslint.vim')
" ref. https://github.com/scrooloose/syntastic#settings"
" エラー行に sign を表示
let g:syntastic_enable_signs = 1
" location list を常に更新
let g:syntastic_always_populate_loc_list = 0
" location list を常に表示
let g:syntastic_auto_loc_list = 0
" ファイルを開いた時にチェックを実行する
let g:syntastic_check_on_open = 1
" :wq で終了する時もチェックする
let g:syntastic_check_on_wq = 0

call dein#end()

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)


"######## キーマップ設定 ########
" esc => ctr + w
imap <C-w> <esc>

" 表示行単位で行移動する
nnoremap j gj
nnoremap k gk

" 検索をデフォで正規表現にする
nnoremap / /\v

" フレームサイズを怠惰に変更する
map <kPlus> <C-W>+
map <kMinus> <C-W>-


"######## 編集設定 ########

" オートインデントする
set autoindent
" バックアップファイルを作成しない
set nobackup

"######## 検索設定 ########

"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"検索時に最後まで行ったら最初に戻る
set wrapscan
"検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch

" ######## 表示設定 ########

" シンタックスハイライトを有効にする
if has("syntax")
    syntax on
endif
" 行番号を表示
set number
" タブの左側にカーソル表示
set listchars=tab:>-,eol:<,trail:-,nbsp:%
set list
" デフォルトのタブ幅を設定する
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
" 入力中のコマンドをステータスに表示する
set showcmd
" 括弧入力時の対応する括弧を表示
set showmatch
" 検索結果文字列のハイライトを有効にする
set hlsearch
" ステータスラインを常に表示
set laststatus=2
" ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" ステータスライン色
highlight StatusLine term=bold cterm=bold ctermfg=black ctermbg=white

" ######## タブ設定 ########
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

set showtabline=2 " 常にタブラインを表示
:hi TabLine ctermfg=Black ctermbg=Yellow
:hi TabLineSel ctermfg=Red ctermbg=Yellow

nmap tn :tabnew

" ######## タグジャンプ TODO gtags試す ########
set tags+=~/.tags

au BufRead,BufNewFile,BufReadPre *.snip   set filetype=snip

set clipboard+=unnamed

" ####### indent"
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.{js,jsx} setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.{css,scss} setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END


