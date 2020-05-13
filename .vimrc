
" Location for installing plugins
call plug#begin('~/.vim/bundle')
    " Git integration (status bar and commands like Gblame)
    Plug 'tpope/vim-fugitive'
    " Fuzzy search
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    " Visually displays which XML/HTML/JSX tag is paired with current one
    Plug 'Valloric/MatchTagAlways'
    "One dark plugin
    Plug 'joshdick/onedark.vim'
    " Change/delete surrounding quotes/brackets/tags
    Plug 'tpope/vim-surround'
    " Coc is an intellisense engine for Vim/Neovim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Syntax highlight for different languages
    Plug 'sheerun/vim-polyglot'
    " Minimalist plugin manager
    Plug 'junegunn/vim-plug'
    " Toggle absolute and relative line numbers
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    "Tagbar is a Vim plugin that provides an easy way to browse the tags of the current file
    Plug 'majutsushi/tagbar'
    "A Vim plugin which shows a git diff in the 'gutter' (sign column)
    Plug 'airblade/vim-gitgutter'
    "A plugin of NERDTree showing git status flags
    Plug 'Xuyuanp/nerdtree-git-plugin'
    "Expand html5 abbrebiations
    Plug 'mattn/emmet-vim'
    "Syntax checker (linter)
    Plug 'scrooloose/syntastic'
    "View project tree
    Plug 'scrooloose/nerdtree'
    "Comment out code with ease in any language
    Plug 'scrooloose/nerdcommenter'
    "Provides a status line
    Plug 'itchyny/lightline.vim'
    "Indent suppor for php with html
    Plug 'captbaritone/better-indent-support-for-php-with-html'
call plug#end()

"Persistent undo history
set undofile
set undodir=~/.vim/undodir

"Lightline(START)
set laststatus=2
set noshowmode
"Lighline(END)

"Syntastic(START)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"Syntastic(END)

" MatchTagAlways - enable for JSX
let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \ 'jsx' : 1,
      \ 'javascript' : 1,
      \ 'php' : 1,
      \ 'blade' : 1
      \}

"PERSONAL COMMANDS
set number
" To not add fix end of file
set nofixendofline
"rescale the window with the mouse
set mouse=a
"set ttymouse=xterm2
set autoindent
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Show command
set showcmd
" Sample command W
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit


"MAPS
"Move through panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"Save the document shortcut
nnoremap <space>w :w<CR>
" Shortcuts for using fzf in vim
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>t :Tags<CR>
"Make a new line on Enter
noremap <Enter> o<Esc>
"NERDTree toggle
noremap <silent> <F6> :NERDTreeToggle<CR>
"NERDTreeFind to find current file in tree
noremap ,n :NERDTreeFind<CR>
"Tagbar toggle
noremap <F8> :TagbarToggle<CR>
"Changing ; for :
noremap : ;
noremap ; :

"COLORSCHEME
syntax enable

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

syntax on
colorscheme onedark


"COC.VIM CONFIG
"Remaping <c-i> see #1089
nnoremap <c-p> <c-i>
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature oflanguageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver,coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
