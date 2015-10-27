let php_noShortTags = 0

colorscheme torte
set nocompatible
set tabstop=4
set shiftwidth=4
set expandtab
set statusline=%F
set listchars=tab:>.,trail:.,extends:#,nbsp:.
inoremap <Nul> <C-x><C-o> 
if has("autocmd")
"    autocmd BufEnter *.phtml set syn=php
    autocmd FileType php DoMatchParen
    autocmd FileType php hi MatchParen ctermbg=blue guibg=lightblue
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd FileType php let php_sql_query=1
    autocmd FileType php let php_htmlInStrings=1
"    autocmd FileType phtml let php_htmlInStrings=1
    autocmd FileType php let php_noShortTags=1
"    autocmd FileType phtml let php_noShortTags=1
    autocmd FileType php let php_folding=1

    autocmd FileType * set tabstop=4 | set sw=4
    autocmd FileType yaml set tabstop=2 | set sw=2
    autocmd BufNewFile,BufRead *.jhtml set filetype=coffee



 " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

    autocmd Syntax html,vim inoremap < <lt>><Left>
endif

"matchit
filetype plugin on

" Taglist
let g:Tlist_Use_Horiz_Window = 0
let g:Tlist_Use_Right_Window = 1
let Tlist_Auto_Highlight_Tag = 0
let Tlist_Auto_Open = 0
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = 'name'
"

set cindent
set smartindent
set autoindent
syn on
set showcmd
set incsearch
set hlsearch
set ignorecase
set smartcase

set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l


set number
set mouse=a

nnoremap <F12> :call ToggleMouse()<CR>
function! ToggleMouse()
        
  if &mouse == 'a'
    set mouse=
    echo "Mouse usage disabled"
  else
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction


nmap <Leader>pd :set paste<CR>:exe PhpDoc()<CR>:set nopaste<CR>i
nmap <Leader>tl :TlistToggle<CR>
nmap zz zR
nmap zZ :setl foldmethod=indent<CR>
nmap <F4> :Project<CR>
nmap <F8> :TlistToggle<CR>
nmap <F10> :set list!<CR>

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap <? <lt>?php ?><Left><Left>

function! ClosePair(char)
if getline('.')[col('.') - 1] == a:char
return "\<Right>"
else
return a:char
endif
endf


inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>

function! QuoteDelim(char)
let line = getline('.')
let col = col('.')
if line[col - 2] == "\\"
"Inserting a quoted quotation mark into the string
return a:char
elseif line[col - 1] == a:char
"Escaping out of the string
return "\<Right>"
else
"Starting a string
return a:char.a:char."\<Left>"
endif
endf 


inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>


vnoremap (  <ESC>`>a)<ESC>`<i(<ESC>
vnoremap )  <ESC>`>a)<ESC>`<i(<ESC>
vnoremap {  <ESC>`>a}<ESC>`<i{<ESC>
vnoremap }  <ESC>`>a}<ESC>`<i{<ESC>
vnoremap "  <ESC>`>a"<ESC>`<i"<ESC>
vnoremap '  <ESC>`>a'<ESC>`<i'<ESC>
vnoremap `  <ESC>`>a`<ESC>`<i`<ESC>
vnoremap [  <ESC>`>a]<ESC>`<i[<ESC>
vnoremap ]  <ESC>`>a]<ESC>`<i[<ESC>


function! InAnEmptyPair()
let cur = strpart(getline('.'),getpos('.')[2]-2,2)
for pair in (split(&matchpairs,',') + ['":"',"':'"])
if cur == join(split(pair,':'),'')
return 1
endif
endfor
return 0
endfunc

func! DeleteEmptyPairs()
if InAnEmptyPair()
return "\<Left>\<Del>\<Del>"
else
return "\<BS>"
endif
endfunc

inoremap <expr> <BS> DeleteEmptyPairs()



set pastetoggle=<F2>

" fix ctrl+pgup/dn in screen
nmap <ESC>[5;5~ <C-PageUp>
nmap <ESC>[6;5~ <C-PageDown>]]

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'joonty/vdebug.git'


" php autocomplete
Bundle 'Shougo/vimproc'
Bundle 'Shougo/unite.vim'
Bundle 'JCLiang/vim-cscope-utils'


" nerdtree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

Plugin 'shawncplus/phpcomplete.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:vdebug_options = {
\ 'path_maps': {"/usr/share/nginx": "/home/crib/git/vagrant"},
\ 'server': '0.0.0.0'
\}

" Open nerdtree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Close nerdtree if it is the last window standing
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" Highlight lines over  80 chars long
"let &colorcolumn=join(range(81,120),",")
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

let g:phpcomplete_index_composer_command = '/usr/bin/composer'
