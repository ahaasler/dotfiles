execute pathogen#infect()
syntax on
filetype plugin indent on
set laststatus=2
set t_Co=256
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
set spell spelllang=en_us
colorscheme molokai
set number
let g:gitgutter_highlight_lines = 1
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0]) | startinsert
