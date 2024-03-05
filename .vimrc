" Add some UI changes
set number                        " Don't show line numbers
set numberwidth=4                 " The width of the number column
set relativenumber                " Show relative numbers
set colorcolumn=81
highlight ColorColumn ctermbg=7 guibg=LightGrey
set termguicolors

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'tpope/vim-sensible'
Plug 'christoomey/vim-tmux-navigator'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'dense-analysis/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-rails'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-ShowTrailingWhitespace'
Plug 'nestorsalceda/vim-strip-trailing-whitespaces'
Plug 'pangloss/vim-javascript'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

call plug#end()

" Vim Colorscheme using joshdick/onedark.vim
syntax enable
set background=dark
" colorscheme nightfly

" make vim look in ~/.vim/ftplugin
" and turn on language-dependent indenting
filetype plugin indent on

" backups & undo
set backup
set backupdir=~/.config/vim/tmp/backup/
set backupskip=/tmp/*,/private/tmp/*
set noswapfile
set history=1000                  " Sets how many lines of history Vim has to remember
set undodir=~/.config/vim/tmp/undo/
set undofile
set undolevels=1000               " How many steps of undo history Vim should remember
set writebackup
set splitright

" leader key
let mapleader = "\<Space>"
nnoremap <leader>W :wq<cr>
nnoremap <leader>e :Explore<cr>
nnoremap <leader>f :FZF<cr>
nnoremap <leader>h :nohlsearch<cr>

" MarkdownPreview Setting https://github.com/iamcco/markdown-preview.nvim
"
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Thoughtbot Rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Hack to make :W behave like :w
:command WQ wq
:command Wq wq
:command W w
:command Q q

