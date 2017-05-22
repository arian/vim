
set nocompatible

" plugins for vim
execute pathogen#infect()

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

set backspace=2 " make backspace work like most other apps

" spell checking
set spell
autocmd FileType scala set nospell

filetype plugin indent on

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

augroup custom

" Remove trailing whitespace on save
autocmd custom BufWritePre * :%s/\s\+$//e

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
autocmd custom BufReadPost * :DetectIndent

" Folding
set foldmethod=indent
set foldlevelstart=99
set foldnestmax=3
set nofoldenable

" autocomplete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Tab completion when entering filenames, ctrlp plugin
set wildignore+=*.o,*.obj,.git,*.rbc,.hg,.svn,*.pyc,.vagrant,.gitignore,.DS_Store,*.jpg,*.jpeg,*.png,*.gif,*.bmp,*/target/*,*/node_modules/*,*.class


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
	set sessionoptions=curdir,resize,winpos
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

" moving lines up or down
" http://vim.wikia.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
" nnoremap n :m .+1<CR>==
" nnoremap m :m .-2<CR>==
" inoremap n <Esc>:m .+1<CR>==gi
" inoremap m <Esc>:m .-2<CR>==gi
" vnoremap n :m '>+1<CR>gv=gv
" vnoremap m :m '<-2<CR>gv=gv

" javascript concealing characters
set conceallevel=1
let g:javascript_conceal_function   = "ƒ"
let g:javascript_conceal_null       = "ø"
let g:javascript_conceal_this       = "@"
let g:javascript_conceal_return     = "⇚"
let g:javascript_conceal_undefined  = "¿"
let g:javascript_conceal_NaN        = "ℕ"
let g:javascript_conceal_prototype  = "¶"

hi Conceal guibg=NONE
hi Conceal guifg=#66D9EF

" rust conceal
let g:rust_conceal=1
let g:rust_conceal_mod_path=1
let g:rust_conceal_pub=1

" Relative edit file
command -nargs=1 Re :e %:p:h/<args>
command -nargs=1 Rsp :sp %:p:h/<args>
command -nargs=1 Rvsp :vsp %:p:h/<args>

" :W is the same as :w
:command W w

" Syntastic
"'jshint', 'jscs',
let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_jscs_args = "--esnext"

function ESLintFix()
	execute "!eslint --fix %"
endfunction

autocmd FileType javascript nmap <buffer> <Leader>f :call ESLintFix()<CR>

" typescript
let g:syntastic_typescript_tsc_fname = ''
let g:tsuquyomi_completion_detail = 1
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tslint', 'tsuquyomi']
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

function TSLintFix()
	silent execute "!tslint --fix %"
	call SyntasticCheck()
endfunction

autocmd FileType typescript nmap <buffer> <Leader>f :call TSLintFix()<CR>

" format js
autocmd BufWritePre *.js Neoformat

" elm
let g:elm_format_autosave = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:elm_syntastic_show_warnings = 1

" clang_complete lib
if isdirectory('/usr/lib/llvm-3.4')
	let g:clang_library_path='/usr/lib/llvm-3.4/lib'
endif

""" Powerline settings
let g:Powerline_stl_path_style = 'short'
" make sure powerline always is visible
set laststatus=2

" gundo
nnoremap <F5> :GundoToggle<CR>

" execute make
noremap <Leader>m :w<CR>:!make<CR>

" NERDTree settings
let NERDTreeIgnore = ['\.(o|obj)$']
noremap <F4> :NERDTreeToggle<CR>

" Per folder .vimrc files
set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

" Use mouse in terminal
set mouse=a

" 'bash' like tab completion for filenames
set wildmode=longest,list,full
set wildmenu

" http://stackoverflow.com/a/4294176/430730
" Create directory if it doesn't exist when creating a new file
function s:MkNonExDir(file, buf)
	if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
		let dir=fnamemodify(a:file, ':h')
		if !isdirectory(dir)
			call mkdir(dir, 'p')
		endif
	endif
endfunction
augroup BWCCreateDir
	autocmd!
	autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

set rtp+=/home/arian/.local/lib/python2.7/site-packages/powerline/bindings/vim
