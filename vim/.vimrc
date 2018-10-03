execute pathogen#infect()
syntax on
filetype plugin indent on
set laststatus=2
set t_Co=256
set spell spelllang=en_us
colorscheme molokai
set number
set relativenumber
set ignorecase
set smartcase
set list
set listchars=tab:│\ ,extends:›,precedes:‹,space:·,nbsp:␣,trail:•,eol:¬
let g:gitgutter_highlight_lines = 1
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
set pastetoggle=<C-p>
nmap <C-n> :set invrelativenumber<CR>
command Gllc :.!git log -1 --pretty=\%B
command -nargs=1 Gllcs :.!git log -1 --pretty=\%B --skip '<args>'
command -nargs=1 Gllsc :.!git log -1 --pretty=\%B --skip '<args>'
