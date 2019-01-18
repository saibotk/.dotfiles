set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" tmux navigator
Plugin 'christoomey/vim-tmux-navigator'

" syntax highlighting
Plugin 'vim-syntastic/syntastic'

" jedi-vim
Plugin 'davidhalter/jedi-vim'

" winresizer
Plugin 'simeji/winresizer'

" nert-tree
Plugin 'scrooloose/nerdtree'

" fzf plugin
Plugin 'junegunn/fzf.vim'

" git
Plugin 'tpope/vim-fugitive'

" vim gitgutter
Plugin 'airblade/vim-gitgutter'

" latex
Plugin 'lervag/vimtex'

" color schemes
Plugin 'flazz/vim-colorschemes'

" powerline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" promela syntax highlighting
Plugin 'vim-scripts/promela.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" syntax
syntax on
colorscheme Benokai
let g:airline_theme='luna'
let python_highlight_all=1
let mapleader=" "

" random settings
set number
set clipboard=unnamed
set mouse=nvi
set smarttab
set visualbell
set virtualedit=block
set scrolloff=1
set wildmenu
set term=screen-256color
set autoread

" tabs and line wrap
set tabstop=4
set wrapmargin=8
set softtabstop=0 noexpandtab
set shiftwidth=4
set backspace=2
set backspace=indent,eol,start
set encoding=utf-8
set autoindent

" search
set incsearch
set hlsearch
set smartcase

" Disable Backup and Swap files
set noswapfile
set nobackup
set nowritebackup

" setup split
set splitbelow
set splitright

"split navigations
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

" tabs
nnoremap <leader>t :tabnew<CR> 
nnoremap <C-n> gT
nnoremap <C-p> gt

" Enable folding
set foldmethod=indent
set foldlevel=99

" remap code folding
nnoremap <leader>g za

" html css js indents
au BufNewFile,BufRead *.js, *.html, *.css
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4

" PLUGIN SETTINGS
" nerd tree setup
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
map <leader>e :NERDTreeToggle<CR>

" airline tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" gitgutter setup
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'
nmap ]g :GitGutterNextHunk<CR>
nmap [g :GitGutterPrevHunk<CR>
augroup VimDiff
	autocmd!
	autocmd VimEnter,FilterWritePre * if &diff | GitGutterDisable | endif
augroup END

" fzf setup
nmap <C-z> :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>r :Tags<CR>
let g:fzf_buffers_jump = 1

