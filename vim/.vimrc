scriptencoding utf-8
set encoding=utf-8

execute pathogen#infect()
syntax on
filetype plugin indent on
let java_mark_braces_in_parens_as_errors=1
let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_java_lang_ids=1
let java_highlight_functions="style"
let g:java_space_errors=1
let java_minlines = 150
set laststatus=2
set t_Co=256
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set t_ZH=[3m
set t_ZR=[23m
set spell spelllang=en_us
let g:material_style='dark'
set background=dark
colorscheme vim-material-tasty
hi Normal guibg=NONE ctermbg=NONE
set number
set relativenumber
set ignorecase
set smartcase
set list
set listchars=tab:│\ ,extends:›,precedes:‹,nbsp:␣,trail:•,eol:¬
if has("patch-7.4.710")
	set listchars+=space:·
endif
let g:gitgutter_highlight_lines = 1
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
set pastetoggle=<C-p>
nmap <C-n> :set invrelativenumber<CR>
command Gllc :.!git log -1 --pretty=\%B
command -nargs=1 Gllcs :.!git log -1 --pretty=\%B --skip '<args>'
command -nargs=1 Gllsc :.!git log -1 --pretty=\%B --skip '<args>'
if &diff
	map ]l :diffget LOCAL<CR>
	map ]b :diffget BASE<CR>
	map ]r :diffget REMOTE<CR>
	set nospell
endif
