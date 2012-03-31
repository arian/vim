
" plugins for vim
call pathogen#infect()

" Syntax, Colorscheme and Gui Options
syntax on
set background=dark
colorscheme monokai
set number " line numbers
set colorcolumn=80
set ruler " Always show current positions along the bottom
set showmatch " show matching brackets
" Keep 10 lines (top/bottom) for scope
set scrolloff=10
" Disable wrapping by default
set nowrap
set linebreak
if has("gui_running")
	set guifont=Ubuntu\ Mono\ 12
	" disable gvim toolbar
	set guioptions-=T
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

" autocomplete
set omnifunc=csscomplete#CompleteCSS

" Tab completion when entering filenames, ctrlp plugin
set wildignore+=*.o,*.obj,.git,*.rbc,.hg,.svn,*.pyc,.vagrant,.gitignore,.DS_Store,*.jpg,*.jpeg,*.png,*.gif,*.bmp


" always switch to the current file directory
set autochdir

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
set sessionoptions=blank,buffers,curdir,folds,localoptions,resize,tabpages,winpos
autocmd VIMEnter * :source ~/.vim/.session
autocmd VIMLeave * :mksession! ~/.vim/.session
