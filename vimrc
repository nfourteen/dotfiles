" Modeline and Notes {{
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{,}} foldlevel=0 foldmethod=marker nospell:
"
" David Nimorwicz's Vimrc File
" }}

" Environment {{

    " Required by Vundle
    set nocompatible        " Must be first line

    " Setup Vundle Support
    " The next three lines ensure that the ~/.vim/bundle/ system works
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'gmarik/Vundle.vim' " let vundle manage vundle

    " General
        Plugin 'altercation/vim-colors-solarized'
        Plugin 'tpope/vim-surround'
        "Plugin 'itchyny/lightline.vim'
        Plugin 'christoomey/vim-tmux-navigator'
        Plugin 'rking/ag.vim'
        Plugin 'SirVer/ultisnips'

    " Writing
        Plugin 'reedes/vim-lexical'
        Plugin 'reedes/vim-pencil'
        "Plugin 'tpope/vim-markdown'
        Plugin 'nelstrom/vim-markdown-folding'

    " Programming
        Plugin 'tpope/vim-fugitive'

    " Web
        Plugin 'groenewege/vim-less'

    " File navigation
        Plugin 'scrooloose/nerdtree'
        Plugin 'kien/ctrlp.vim'
        Plugin 'FelikZ/ctrlp-py-matcher'

    " Required by Vundle
    call vundle#end()
" }}

" General {{
    filetype plugin indent on           " Automatically detect file types.
    syntax on                           " Syntax highlighting
    scriptencoding utf-8
    "set clipboard=unnamed

    set listchars=tab:▸\ ,eol:¬         " Use the same symbols as TextMate
    set cpoptions=ces$                  " When change, don't delete text from view
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=all                 " Allow for cursor to go to "invalid" places
    set history=500                     " Store a ton of history (default is 20)
    set hidden                          " Allow buffer switching without saving
    " PHP helpers
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    set backspace=indent,eol,start       " Make backspace behave in a sane manner.

    " Change backup and swap dirs so these files don't appear in our project directories
    set backupdir=~/.vim/.backup//
    set directory=~/.vim/.swap//
    set undodir=~/.vim/.undo//

    " Setting up the directories
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Auto change to current file directory, but do not change to /tmp dir
    autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif


    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" }}

" Vim UI {{

    " set per http://stackoverflow.com/questions/7278267/incorrect-colors-with-vim-in-iterm2-using-solarized
    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        set background=dark                 " Assume a dark background
        color solarized             " Load colorscheme
    endif

    set showmode                    " Display the current mode
    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%130(%=%F%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options: preview window flag, help file flag, modified flag, read only flag
        set statusline+=\ [%Y]                   " Filetype
        "set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned: line #, col #, virtual col #, percent through file
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    "set linespace=0                 " No extra spaces between rows
    set relativenumber              " show line numbers relative to cursor, autocmd auto switches upon entering insert mode
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    "set winminheight=0              " Windows can be 0 line high
    "set ignorecase                  " Case insensitive search
    "set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set foldlevelstart=10           " Open most folds by default
    set foldnestmax=10              " Don't burn in callback hell with lots of nested levels
    "set list
    set listchars=tab:▸\ ,eol:¬     " Use better symbols for tabs and EOLs
    match ErrorMsg '\s\+$'          " Highlight trailing whitespace in red

" }}

" Formatting {{

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set matchpairs+=<:>             " Match html chars, to be used with %
    "set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    "set colorcolumn=80              " set vertical line in window for visual line length

    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql,phtml autocmd BufWritePre <buffer> call RemoveTrailingWhitespace()

    " Magento template files
    autocmd BufNewFile,BufRead *.phtml set filetype=php

" }}

" Key (re)Mappings {{

    let mapleader = ','
    let maplocalleader = '_'

    " Alright... let's try this out
    " ctrl-[ - default escape, I like it better
    "imap jj <esc>
    "cmap jj <esc>

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " change C-g to display full path rather than just filename
    nnoremap <C-g> 1<C-g>

    " unmap ex mode: 'Type visual to go into Normal mode.'
    nnoremap Q <nop>

    " Manually turn off previous search term hightlighting
    nnoremap <leader>nh :nohlsearch<CR>

    " Source/edit the vimrc
    nmap <silent> <leader>ev :vsp ~/.vimrc<CR>
    nmap <silent> <leader>sv :so ~/.vimrc<CR>

    " Manually call remove trailing whitespace
    nnoremap <silent> <leader>rtw :call RemoveTrailingWhitespace()<CR>

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Yank text to the OS X clipboard
    noremap <leader>y "*y
    noremap <leader>yy "*Y

    " Preserve indentation while pasting text from the OS X clipboard
    noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Adjust viewports to the same size
    map <leader>= :wincmd =<cr>

    " Easier window navigation
    noremap <silent> <leader>ww <C-W><C-W> " cycle windows
   " noremap <silent> <leader>wl <C-W>l " goto window
   " noremap <silent> <leader>wk <C-W>k
   " noremap <silent> <leader>wh <C-W>h
   " noremap <silent> <leader>wj <C-W>j
    noremap <silent> <leader>wml <C-W>L " move window
    noremap <silent> <leader>wmk <C-W>K
    noremap <silent> <leader>wmh <C-W>H
    noremap <silent> <leader>wmj <C-W>J

    " put placeholder markers into quickfix for {CHECK}, {TODO}, and {FACT} writing patterns
    nnoremap <leader>{ :vimgrep /{\\w\\+}/ % <CR>:copen<CR>

    " remap omnicomplete
    inoremap <C-space> <C-x><C-o>

    " Switch between the last two files
    nnoremap <leader><leader> <c-^>

    " Map Ag command to \
    nnoremap \\ :Ag<Space>

    " Find merge conflict markers
    "map <leader>fc " TODO - add regex from spf13 if using git

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cd. lcd %:p:h

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    "vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    "cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    "cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    "map <leader>ew :e %%
    "map <leader>es :sp %%
    "map <leader>ev :vsp %%
    "map <leader>et :tabe %%

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    "nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    "map zl zL
    "map zh zH

    " Easier formatting
    nnoremap <silent> <leader>f gwip

    " toggle line numbers between relative and normal
    nnoremap <silent><leader>n :set rnu! rnu? <cr>

" }}

" Plugins {{

    " NerdTree {{
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
            nmap <leader>nt :NERDTreeToggle<CR>
            nmap <leader>nf :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let NERDTreeWinSize=65
            let NERDTreeDirArrows=0 " fix for linux, can not open folders with this option on
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }}

    " ctrlp {{
        if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            let g:ctrlp_working_path_mode = 'ra'
            let g:ctrlp_max_files = 0
            let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$|\.DS_Store$' }

            " Fallback for search program to use, default is system
            if executable('ag')
                let s:ctrlp_fallback = 'ag %s -i --nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore "**/*.pyc" -g ""'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif

            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
            \ }

            " PyMatcher for CtrlP
            if has('python')
                let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
            endif

        endif
    "}}

    " Writing {{
        augroup writing
          autocmd!
          autocmd FileType markdown,mkd setl spell spl=en_us noru nonu nornu fdo+=search
        augroup END
    " }}

    " Ultisnips {

        " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<c-j>"
        let g:UltiSnipsJumpBackwardTrigger="<c-k>"

        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"
    " }

" }}

" Functions {{

    " Initialize NERDTree as needed
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction

    " Strip whitespace
    function! RemoveTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction

    " Add argument (can be negative, default 1) to global variable i.
    " Return value of i before the change.
    " Usage - :let i = 1 | %s/(00)/\='('.Inc().')'/g
    function! Inc(...)
      let result = g:i
      let g:i += a:0 > 0 ? a:1 : 1
      return result
    endfunction
" }}

" Commands {{

    " Auto commands

    " automatically rebalance windows on vim resize
    autocmd VimResized * :wincmd =

    augroup markdown
        autocmd!
        autocmd BufNewFile,BufRead,BufWrite *.txt,*.md,*.mkd,*.markdown,*.mdwn setl ft=markdown ts=3 sw=3 sts=3 cc=90 nonumber
        autocmd BufWinEnter *.txt,*.md,*.mkd,*.markdown,*.mdwn let w:m1=matchadd('Error', '{\w\+}', -2) " highlight {FACT}, {CHECK}, and {TODO} placeholders
        autocmd FileType *.txt,*.md,*.mkd,*.markdown,*.mdwn autocmd BufWritePre <buffer> call RemoveTrailingWhitespace()
    augroup end

    augroup vagrant
        autocmd!
        autocmd BufNewFile,BufRead,BufWrite *.pp setl ft=ruby ts=2 sw=2 sts=2
        autocmd FileType *.pp autocmd BufWritePre <buffer> call RemoveTrailingWhitespace()
        autocmd BufNewFile,BufRead,BufWrite Vagrantfile setl ft=ruby ts=2 sw=2 sts=2
        autocmd FileType ruby autocmd BufWritePre <buffer> call RemoveTrailingWhitespace()
        autocmd BufNewFile,BufRead,BufWrite *.yaml setl ft=yaml ts=2 sw=2 sts=2
        autocmd FileType *.pp autocmd BufWritePre <buffer> call RemoveTrailingWhitespace()
    augroup end

" }}
