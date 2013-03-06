
" plugins for vim
call pathogen#infect()

" Syntax, Colorscheme and Gui Options
set number " line numbers
set colorcolumn=80
set ruler " Always show current positions along the bottom
set showmatch " show matching brackets
" Keep 10 lines (top/bottom) for scope
set scrolloff=10
" Disable wrapping by default
set nowrap
set linebreak

" spell checking
set spell

" colors
syntax on
set background=dark
if has("gui_running")
	set guifont=Ubuntu\ Mono\ 11
	" disable gvim toolbar
	set guioptions-=T
	colorscheme molokai
else
	let g:molokai_original = 1
	colorscheme molokai
endif

" Searching: highlight results, search while typing, ignore case when only lowercase
set hlsearch incsearch ignorecase smartcase

" Show invisibles
set list
set listchars=tab:›\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Automatically read files when they were modified externally
set autoread

" Indent settings
set tabstop=4
set shiftwidth=4
set noexpandtab
"set smartindent (smartindent doesn't work with smartinput well)
set autoindent
"set cinkeys=0{,0},:,0#,!,!^F

" Detect Indentation plugin
:autocmd BufReadPost * :DetectIndent

" Folding
set foldmethod=indent
set foldlevelstart=99
set foldnestmax=3
set nofoldenable

" autocomplete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Tab completion when entering filenames, ctrlp plugin
set wildignore+=*.o,*.obj,.git,*.rbc,.hg,.svn,*.pyc,.vagrant,.gitignore,.DS_Store,*.jpg,*.jpeg,*.png,*.gif,*.bmp,*/target/*,*.class


" always switch to the current file directory
" set autochdir

" share clipboard with the system
set clipboard=unnamedplus

" directory to place swap files in
set directory=~/.vim/tmp

" Swap, Undo and Backup Folder Configuration
set directory=~/.vim/swap
set backupdir=~/.vim/backup
set undodir=~/.vim/undo
set backup
set undofile

" Save and restore vim session
if has("gui_running")
	set sessionoptions=curdir,folds,localoptions,resize,tabpages,winpos
	autocmd VIMEnter * :source ~/.vim/.session
	autocmd VIMLeave * :mksession! ~/.vim/.session
endif

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

""" Powerline settings
let g:Powerline_stl_path_style = 'short'

" gundo
nnoremap <F5> :GundoToggle<CR>
