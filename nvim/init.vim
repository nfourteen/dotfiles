" Modeline and Notes {{
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{,}} foldlevel=0 foldmethod=marker nospell:
"
" David Nimorwicz's Neovimrc File
" }}

" Vim-plug {{

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')

    " General
        Plug 'altercation/vim-colors-solarized'
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'tpope/vim-surround'

    " File Navigation
        Plug 'dhruvasagar/vim-vinegar'
        Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
        Plug 'ctrlpvim/ctrlp.vim'
        "Plug 'FelikZ/ctrlp-py-matcher'

    " Writing
        "Plug 'reedes/vim-lexical'
        "Plug 'reedes/vim-pencil'
        "Plug 'tpope/vim-markdown'
        Plug 'nelstrom/vim-markdown-folding'
        Plug 'junegunn/goyo.vim'
        Plug 'junegunn/vim-easy-align' " markdown table alignment
        "Plug 'dhruvasagar/vim-table-mode' " easy markdown table creation

    " Coding
        "Plug 'janko-m/vim-test'
        "Plug 'scrooloose/nerdcommenter'
        "Plug 'joonty/vdebug'
        "Plug 'neomake/neomake'

    " PHP - https://github.com/Rican7/dotfiles for plugin ideas
        "Plug 'stephpy/vim-php-cs-fixer' " requires php-cs-fixer: http://cs.sensiolabs.org/
        "Plug 'adoy/vim-php-refactoring-toolbox'
        "Plug 'Shougo/deoplete.nvim'
        "Plug 'pbogut/deoplete-padawan'

call plug#end()

"}}

" Key (re)Mappings {{

    let mapleader = ","
    let maplocalleader = "_"

    " Source/edit the vimrc
    nmap <silent> <Leader>ev :vsp ~/.config/nvim/init.vim<CR>
    nmap <silent> <Leader>sv :so ~/.config/nvim/init.vim<CR>

    " Manually call remove trailing whitespace
    nnoremap <silent> <leader>rtw :call RemoveTrailingWhitespace()<CR>

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Unmap the arrow keys
    noremap <down> ddp " move current line text down
    noremap <left> <Nop>
    noremap <right> <Nop>
    noremap <up> ddkP " move current line text up
    inoremap <down> <Nop>
    inoremap <left> <Nop>
    inoremap <right> <Nop>
    inoremap <up> <Nop>
    vnoremap <down> <Nop>
    vnoremap <left> <Nop>
    vnoremap <right> <Nop>
    vnoremap <up> <Nop>

    " auto-center movements
    nmap G Gzz
    nmap n nzz
    nmap N Nzz
    nmap } }zz
    nmap { {zz

    " quick pairs
    imap <leader>' ''<ESC>i
    imap <leader>" ""<ESC>i
    imap <leader>( ()<ESC>i
    imap <leader>[ []<ESC>i

    " change C-g to display full path rather than just filename
    nnoremap <C-g> 1<C-g>

    " unmap ex mode: 'Type visual to go into Normal mode.'
    nnoremap Q <nop>

    " Manually turn off previous search term hightlighting
    nnoremap <leader>nh :nohlsearch<CR>

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

    " Easier formatting
    nnoremap <silent> <leader>f gwip

    " toggle line numbers between relative and normal
    nnoremap <silent><leader>n :set rnu! rnu? <cr>

    " vim-test plugin
    "nmap <silent> <leader>t :TestNearest<CR>
    "nmap <silent> <leader>T :TestFile<CR>
    "nmap <silent> <leader>a :TestSuite<CR>
    "nmap <silent> <leader>l :TestLast<CR>
    "nmap <silent> <leader>g :TestVisit<CR>

    " Ctrl-h was not working in tmux
    " per https://robots.thoughtbot.com/my-life-with-neovim
    nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

" }}

"{{ General

    set hidden                          " Allow buffer switching without saving
    "highlight clear SignColumn      " SignColumn should match background
    "highlight clear LineNr          " Current line number row will have same background color in relative mode
    set virtualedit=all                 " Allow for cursor to go to "invalid" places

    augroup whitespace
        autocmd!
        autocmd BufWritePre * :%s/\s\+$//e
    augroup end

" }}

" Vim UI {{

    set background=dark                 " Assume a dark background
    colorscheme solarized               " Load colorscheme

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

    set listchars=tab:▸\ ,eol:¬         " Use the same symbols as TextMate

    set relativenumber number

    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current

    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set wildignorecase              " ignore case on tab autocomplete in wild menu
    match ErrorMsg '\s\+$'          " Highlight trailing whitespace in red

" }}

" Commands {{

    augroup window
        autocmd!
        " auto rebalance splits on vim resize, ie when splitting tmux
        autocmd VimResized * :wincmd =
    augroup end

    augroup markdown
        autocmd!
        autocmd BufNewFile,BufRead *.txt,*.md,*.mkd,*.markdown,*.mdwn setl ft=markdown
        " highlight {FACT}, {CHECK}, and {TODO} placeholders
        autocmd BufWinEnter *.txt,*.md,*.mkd,*.markdown,*.mdwn let w:m1=matchadd('Error', '{\w\+}', -2)
        autocmd Filetype markdown setlocal nonumber norelativenumber linebreak spell
    augroup end

" }}

" Options {{

    " NerdTree {{
        if isdirectory(expand("~/.config/nvim/bundle/nerdtree"))
            nmap <leader>nt :NERDTreeToggle<CR>
            nmap <leader>nf :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            "let NERDTreeIgnore=['^tags$[[file]]', '^tags\.vendor$[[file]]']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeWinSize=40
            let NERDTreeDirArrows=0 " fix for linux, can not open folders with this option on
            let NERDTreeMinimalUI=1 " Disable display of '?' text and 'Bookmarks' label.

        endif

    " }}

    " ctrlp {{
        if isdirectory(expand("~/.config/nvim/bundle/ctrlp.vim"))
            let g:ctrlp_working_path_mode = 'wa'
            let g:ctrlp_max_files = 0
            let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'
            "let g:ctrlp_custom_ignore = {
            "    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            "    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$|\.DS_Store$' }


            " The Silver Searcher
            if executable('ag')
              " Use ag over grep
              set grepprg=ag\ --nogroup\ --nocolor

              " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
              " Look into -U option and creating a local .ignore file
              let g:ctrlp_user_command = 'ag %s -lU --nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore "**/*.pyc" -g ""'

              " ag is fast enough that CtrlP doesn't need to cache
              "let g:ctrlp_use_caching = 0
            endif

        endif
    "}}

    " php-cs-fixer {{
        let g:php_cs_fixer_config_file = '.php_cs'        " configuration file
        let g:php_cs_fixer_rules = "@PSR2"
    " }}

    " vim easy align {{
        " Start interactive EasyAlign in visual mode (e.g. vipga)
        xmap ga <Plug>(EasyAlign)

        " Start interactive EasyAlign for a motion/text object (e.g. gaip)
        nmap ga <Plug>(EasyAlign)
    " }}

" }}

" {{ Functions

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
