set nocompatible

source ~/.vim/sources/vundlerc.vim

syntax enable
" set completefunc=syntaxcomplete#Complete
set omnifunc=syntaxcomplete#Complete

set autoindent " repeat indentation on new line
set smartindent " auto indent after keywords

set backspace=indent,eol,start
set encoding=utf-8
" set t_Co=256
set ttyfast " send more character to the screen for redrawing
set showcmd
set laststatus=2 " show status line
set nowrap
set textwidth=110
set undofile
" set noshowmode
set mouse=a
" set background=dark
set wildmenu
set ruler " show line and column of cursor
" set lazyredraw
set foldlevelstart=99
set virtualedit=block " allows placing the cursor on empty spaces when block selecting
set clipboard^=unnamed
set termguicolors
colorscheme apprentice

augroup fileTypeDetect
    au BufRead,BufNewFile *.m,*.oct set filetype=octave
    au BufRead,BufNewFile *.pl set filetype=prolog
    au BufRead,BufNewFile *.tex set filetype=tex
    au BufRead,BufNewFile *.h set filetype=c
augroup END

set smarttab " allow shiftwidth configuration
augroup fileTypeTabbing
    au FileType c,cpp setlocal ts=8 sw=8 tw=80
    au Filetype python,xml,octave,java,text,tex,r setlocal expandtab ts=4 sw=4
    au Filetype python setlocal tw=79 nosmartindent
    au Filetype tex,markdown setlocal tw=80 directory=.
    au Filetype htmldjango,pov setlocal ts=4 sw=4
    au Filetype html,javascript,vim,json,ruby,eruby,arduino,bib,help setlocal expandtab ts=2 sw=2
augroup END

augroup fileTypeRunning
    au FileType python noremap <buffer> <Leader>r :!python3 % 
    au FileType r noremap <buffer> <Leader>r :!Rscript %<CR>
augroup END

set hlsearch
set ignorecase " ignore case during search
set infercase
set smartcase " consider case if there is upper case letters
set incsearch " search on typing
set number
set relativenumber
set formatoptions+=c " Automatic wrap comments
set formatoptions+=j " Remove comment leader wehn joining lines

set splitbelow
set splitright

let directory = expand("~/.vim/swaps")
if !isdirectory(directory)
    call mkdir(directory)
endif
set directory=~/.vim/swaps

if has('persistent_undo')
    let undodir = expand("~/.vim/undos")
    if !isdirectory(undodir)
        call mkdir(undodir)
    endif
    set undodir=~/.vim/undos
    set undofile
endif

let dictionaries = expand("~/.vim/dictionaries")
if !isdirectory(dictionaries)
    call mkdir(dictionaries)
endif
au FileType * exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))

set spellfile=~/.vim/spell/miscwords.add
set spellcapcheck=""
au FileType tex,text setlocal complete+=kspell

let g:languages = ['pt,en', 'en', 'pt']
let g:spell_language_idx = 0
au FileType tex,text setlocal spell
let &spelllang=g:languages[g:spell_language_idx]

function! SpellLanguageCycle()
  let g:spell_language_idx += 1
  if g:spell_language_idx == len(g:languages)
    let g:spell_language_idx = 0
  endif
  let &spelllang=g:languages[g:spell_language_idx]
  echo &spelllang
endfunction
noremap <Leader>ss :call SpellLanguageCycle()<CR>

" toggle language spell
function! ParagraphFormatToggle()
  if &formatoptions =~ 'a'
    setlocal formatoptions-=a
    echo 'Paragraph Format ON'
  else
    setlocal formatoptions+=a
    echo 'Paragraph Format OFF'
  endif
endfunction
nnoremap <Leader>sp :call ParagraphFormatToggle()<CR>

" don't remember why
nmap <C-@> <C-Space>
" trigger spell suggestion
au FileType tex,text nnoremap <C-Space> a<C-X>s
" accept first spell suggestion
nnoremap <Leader>sf z=1<CR><CR>

set completeopt+=menuone,longest,noselect
" disable preview window on auto completion
set completeopt-=preview

" set tags+=~/.vim/tags/cpp
" set tags+=~/.vim/tags/avr
" build tags of your own project with Ctrl-F12
" nmap <F5> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

" disable timeout on keys but not on mappings
set ttimeout
set notimeout
set timeoutlen=0

map <Space> <Leader>

" automatically equalize splits when Vim is resized
autocmd VimResized * wincmd =

" navigate through splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" go to next visited position
nnoremap <C-a> <C-i>

noremap H ^
noremap L g_
" close preview and quickfix windows
noremap <silent> ç :pclose <bar> cclose<CR>

noremap <Leader><Space> V

" make Enter select completion key instead of creating new line
inoremap <expr> <CR> pumvisible() ? "\<C-y><Esc>" : "\<C-g>u\<CR>"

" line completion
inoremap <C-l> <C-x><C-l>

" duplicate a selection
" vmap <Leader>p y'>p

nnoremap <C-n> :set relativenumber!<CR>

" set indentation chars
" set listchars=tab:\|-
" set list lcs=tab:\|\
" toggle indentation visualization
" nnoremap <Leader>l :set list!<CR>

" use Tab and Shift Tab for indenting
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" navigate through buffers
nnoremap <silent> gb :bnext<CR>
nnoremap <silent> gB :bprevious<CR>

source ~/.vim/sources/keepview.vim
" find and replace occurences of word under cursor (normal mode)
nnoremap <Leader>f :KeepView %s/<C-R><C-W>//g<Left><Left>
" find and replace occurences of selected word (visual mode)
vnoremap <Leader>f "sy:KeepView %s/<C-R>"//g<Left><Left>
" add the g flag to search/replace by default
" set gdefault

" select all
nmap <Leader>a ggVG
nmap <Leader>A :KeepView normal!ggVGy<CR>

" save, quit, quit all
nnoremap <Leader>w :w!<CR>
nnoremap <Leader>W :w !sudo tee %> /dev/null<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>
nnoremap <Leader>x :wq<CR>
nnoremap Q <c-w>z

" Copy and Paste to system clipboard
vmap <Leader>y "+y
nmap <Leader>yy "+yy
vmap <Leader>d "+d
nmap <Leader>dd "+dd
nmap <Leader>p "+p
nmap <Leader>P "+P

" create empty lines
" nmap <Leader>o :<c-u>put =repeat(nr2char(10), v:count1)<CR>'[<Up>
" nmap <Leader>O :<c-u>put! =repeat(nr2char(10), v:count1)<CR><Down>
nmap <Leader>o :<c-u>put =repeat(nr2char(10), v:count1)<CR>
nmap <Leader>O :<c-u>put! =repeat(nr2char(10), v:count1)<CR>

" remove current char and split line
nnoremap <Leader>J r<CR>

" syn match pythonFunction "\zs\(\k\w*\)*\s*\ze("
" syntax match pythonFunction /\v[[:alpha:]_.]+\ze(\s?\()/
" hi link pythonFunction Function

" Use ripgrep if available, fall back to the silver searcher, then fall back to
" the system grep for grepping
if executable('rg')
  set grepprg=rg\ --vimgrep\ -i
  set grepformat^=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --vimgrep\ -i
  set grepformat^=%f:%l:%c:%m
else
  set grepprg=grep\ -iR
endif

" Smarter grep command
command! -nargs=+ -complete=file_in_path -bar Grep
      \ silent! grep! <q-args> | redraw!

" Project-wide search
" 'g' for grep
nnoremap <Leader>g :Grep<Space>

execute "set <M-l>=\el"
" TODO improve this with <C-o>
" Move the next char to end of line
inoremap <M-l> <Esc>lx$pi

" source ~/.vim/sources/http_request.vim
" nnoremap <Leader>ht :call OpenHTTPRequestFile("~/.vim/sources/http_request_file")<cr>
" nnoremap <Leader>tt 2gg:HTTPClientDoRequest<cr>

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {'jedi_completion': {'include_params': v:false}}}}
        \ })
    autocmd FileType python setlocal omnifunc=lsp#complete
    autocmd FileType python nnoremap K :LspHover<CR>
endif

if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '/tmp/ccls',  "completion": {"detailedLabel": v:false}},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
    autocmd FileType c,cpp setlocal omnifunc=lsp#complete
    autocmd FileType c,cpp nnoremap K :LspHover<CR>
endif

" source ~/.vim/sources/netwr_config.vim source ~/.vim/sources/pluginrc.vim

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 
