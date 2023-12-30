" デフォルトのエディタ設定 "
" Maintainer: RadioNoiseE, 黄京 "

" PreambleCleanUp |=>
if &compatible
  set nocompatible
endif
silent! while 0
  set nocompatible
silent! endwhile
" <=|
" GenericConfig |=>
set backspace=indent,eol,start
set history=200
set ruler
set showcmd
set wildmenu
set ttimeout
set ttimeoutlen=100
set updatetime=100
set display=truncate
set scrolloff=5
set foldmethod=marker
set foldmarker=\|\=>,<\=\|
set number
set relativenumber
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab " Dangerous
set cursorline
set lazyredraw
set termguicolors
set noautoindent
set nosmartindent
set nolist
" set listchars=multispace:┊\ 
if has('reltime')
  set incsearch
endif
set nrformats-=octal
map Q gq
sunmap Q
inoremap <C-U> <C-G>u<C-U>
if has('mouse')
  if &term =~ 'xterm'
    set mouse=
  else
    set mouse=
  endif
endif
if 1
  filetype plugin indent on
  augroup vimStartup
    au!
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
  augroup END
  augroup vimHints
    au!
    autocmd CmdwinEnter *
    \ echohl Todo | 
    \ echo 'You discovered the command-line window! You can close it with ":q".' |
    \ echohl None
  augroup END
endif
if &t_Co > 2 || has("gui_running")
  syntax on
  let c_comment_strings=1
endif
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif
if has('langmap') && exists('+langremap')
  set nolangremap
endif
syntax on
" <=|
" MapConfig |=>
inoremap jk <esc>
" <=|
" TransparentBG |=>
function! s:transparent_background()
  highlight Normal guibg=NONE ctermbg=NONE
" highlight NonText guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
" highlight Folded guibg=NONE ctermbg=NONE
" highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
endfunction
autocmd ColorScheme * call s:transparent_background()
" <=|
" ColorScheme |=>
set bg=dark
colorscheme space-vim-dark
hi Comment cterm=italic
let g:airline_theme='violet'
" <=|
" StatusLine |=>
" let g:airline_powerline_fonts=1
" <=|
" CodeComplete |=>
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
inoremap <silent><expr> <Tab>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
" <=|
" MatchUp |=>
let g:loaded_matchit = 1
" <=|
" EditingMode |=>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" <=|
" MultiCursor |=>
nnoremap mi :<c-u>call MultiCursorPlaceCursor()<cr>
nnoremap ma :<c-u>call MultiCursorManual()<cr>
nnoremap mr :<c-u>call MultiCursorRemoveCursors()<cr>
xnoremap mv :<c-u>call MultiCursorVisual()<cr>
nnoremap ms :<c-u>call MultiCursorSearch('')<cr>
let g:multicursor_quit="mq"
" <=|
" RainbowParentheses |=>
augroup rainbow_auto
  autocmd!
  autocmd FileType lisp,clojure,scheme,tex,c,cpp,vim RainbowParentheses
augroup END
let g:rainbow#max_level = 16
let g:rainbow#pairs=[['(',')'],['[',']'],['{','}']]
" <=|
" AsyncMake |=>
call neomake#configure#automake('w')
let g:neomake_open_list=2
let g:neomake_c_enabled_makers=['clang']
let g:neomake_cpp_enabled_makers=['clang++']
let g:neomake_lua_enabled_makers=['luac']
let g:neomake_shell_enabled_makers=['dash']
" let g:neomake_tex_enabled_makers=['lualatex']
" <=|
" TeXSpecials |=>
let g:tex_isk="@,48-57,a-z,A-Z,192-255"
set iskeyword+=\:
set iskeyword+=\@
syn match texStatement "\\[a-zA-Z@]\+"
" <=|
