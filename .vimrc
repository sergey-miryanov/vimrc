" pathogen bundles
execute pathogen#infect()

syntax on
filetype plugin indent on

" for vaxe completion
set completeopt=menu  " показывать только меню для completion
set nu                  " показываем нумерацию строк
set encoding=utf-8      " character encoding used inside Vim.
set fileencodings=utf8,cp1251 " Возможные кодировки файлов и последовательность определения
set wildmenu    " Саджест по <tab> в командной строке
set title       " window title
set showcmd     " Show (partial) command in the last line of the screen
set showtabline=1       " Показывать табы всегда
set list                " display unprintable characters
set wrap                " Включаем перенос строк (http://vimcasts.org/episodes/soft-wrapping-text/)
set formatoptions-=o    " dont continue comments when pushing o/O
set linebreak           " Перенос не разрывая слов
set autoindent          " Копирует отступ от предыдущей строки
set smartindent         " Включаем 'умную' автоматическую расстановку отступов
set expandtab
set shiftwidth=2        " Размер сдвига при нажатии на клавиши << и >>
set tabstop=2           " Размер табуляции
set softtabstop=2
set linespace=1         " add some line space for easy reading
set cursorline          " Подсветка строки, в которой находится в данный момент курсор
set guioptions=         " Вырубаем все лишнее из ГУИ, если надо потогглить см <F6>
set t_Co=256            " Кол-во цветов
set guicursor=          " Отключаем мигание курсора
set splitbelow          " новый сплит будет ниже текущего :sp
set splitright          " новый сплит будет правее текущего :vsp
set shortmess+=I        " не показывать intro screen
set mouseshape=s:udsizing,m:no " turn to a sizing arrow over the status lines
set mousehide     " Hide the mouse when typing text
set autowrite
set history=1000 " store lots of :cmdline history
set backspace=indent,eol,start
set backupdir=~/vimi/bac,.,/tmp " Директория для backup файлов
set directory=~/vimi/swp,.,/tmp " Директория для swp файлов
set noswapfile
set laststatus=2

" Show the line and column number of the cursor position
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

" показывать парную скобку
let loaded_matchparen=1 " перестает прыгать на парную скобку, показывая где она. +100 к скорости
set showmatch " показывать парные <> в HTML

" Search
set incsearch   " При поиске перескакивать на найденный текст в процессе набора строки
set hlsearch    " Включаем подсветку выражения, которое ищется в тексте
set ignorecase  " Игнорировать регистр букв при поиске
set smartcase   " Override the 'ignorecase' if the search pattern contains upper case characters

if version >= 703
    set colorcolumn=80 " Подсвечиваем 120 столбец
end

" Символ табуляции и конца строки
if has('multi_byte')
    if version >= 700
  set listchars=tab:»\ ,trail:·,extends:→,precedes:←,nbsp:×
    else
  set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:_
    endif
endif


" colorscheme
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
if has("gui_running")
  "set gfn=Terminess\ Powerline\ 13
  set gfn=Sauce\ Code\ Powerline\ Light:h15
endif

let mapleader = "," " мапим <Leader> на запятую. По умолчанию <Leader> это обратный слэш \

" <Esc>
" Clear the search highlight by pressing ENTER when in Normal mode (Typing commands)
    nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" ,p
" Вставлять код извне без этой строчки проблематично, без нее начитается
" бешеный реформат кода
    set pastetoggle=<Leader>p

" ,n
" Toggle type of line numbers
" http://stackoverflow.com/questions/4387210/vim-how-to-map-two-tasks-under-one-shortcut-key
" vim 7.3 required
    let g:relativenumber = 0
    function! ToogleRelativeNumber()
      if g:relativenumber == 0
        let g:relativenumber = 1
        set norelativenumber
        set number
        echo "Show line numbers"
      elseif g:relativenumber == 1
        let g:relativenumber = 2
        set nonumber
        set relativenumber
        echo "Show relative line numbers"
      else
        let g:relativenumber = 0
        set nonumber
        set norelativenumber
        echo "Show no line numbers"
      endif
    endfunction
    map <Leader>n :call ToogleRelativeNumber()<cr>

" ,g
    function! ToggleGUINoise()
      if &go==''
        exec('se go=mTrL')
        echo "Show GUI elements"
      else
        exec('se go=')
        echo "Show no GUI elements"
      endif
    endfunction
    map <Leader>g <Esc>:call ToggleGUINoise()<cr>

" ,f
" Fast grep
" грепает в текущей директории по слову, на котором стоит курсор
    map <Leader>f :execute "Ack " . expand("<cword>") <Bar> cw<CR>

" ,v
" Pressing ,v opens the .vimrc in a new tab
    nmap <leader>v :tabedit $MYVIMRC<CR>


" n и N
" когда бегаем по результатам поиска, то пусть они всегда будут в центре
    nmap n nzz
    nmap N Nzz
    nmap * *zz
    nmap # #zz
    nmap g* g*zz
    nmap g# g#zz

" It's 2011. Don't skip wrap lines
" Еще раз и попонятнее:
" если строка n длиная и не влезла в окно — она перенесется на
" следующую (wrap on). Шокткаты ниже нужны, чтобы попасть
" на каждую псевдострочку этой врапнутой строки.
    noremap j gj
    noremap k gk

" gf открывает фойл под курсором в вертикальном сплите
" (по дефолту gf открывает файл в том же буфере)
    nmap gf :vertical wincmd f<CR>

" Fix Trailing White Space
    map <leader>ts :%s/\s\+$//e<CR>


" ,bl show buffers
    nmap <Leader>bl :ls<cr>:b

" ,bp prev buffer
    nmap <Leader>bp :bp<cr>

" ,bn next buffer
    nmap <Leader>bn :bn<cr>

" save file with root permissions"
    cmap w!! %!sudo tee > /dev/null %

" Переходим по файлам вперед/назад
    noremap <A-LEFT> <C-O>
    noremap <A-RIGHT> <C-I>
" Переходим по результатам поиска
    noremap <D-Down> :cn<CR>
    noremap <D-Up> :cp<CR>
" Копируем/вставляем
    noremap <C-c> "+y
    noremap <C-x> "+x
    noremap <C-Ins> "+gP
    noremap <C-i> "+gP
" Дополнительные клавиши
    noremap <Ins> i
    noremap <C-t> :tabnew<CR>
    noremap <C-\> :set nowrap<CR>
    noremap <BS> :b#<CR>
    noremap <Space> za
    noremap <C-Tab> :tabp<CR>
    noremap <S-Tab> :tabn<CR>

    noremap <A-DOWN> :cn<CR>
    noremap <A-UP> :cp<CR>

    nmap <F8> :TagbarToggle<CR>
    nmap <F12> <C-]>

" Для питона отступы по 4 символа
autocmd FileType python set ts=4
autocmd FileType python set sts=4
autocmd FileType python set sw=4

autocmd FileType ocaml set ts=4
autocmd FileType ocaml set sts=4
autocmd FileType ocaml set sw=4

autocmd FileType cs set ts=4
autocmd FileType cs set sts=4
autocmd FileType cs set sw=4

if has("autocmd")
    autocmd! bufwritepost .vimrc source $MYVIMRC
endif

" Save on losing focus
autocmd FocusLost * :wa

" Auto change the directory to the current file I'm working on
autocmd BufEnter * lcd %:p:h

" Загрузка предыдущей сессии
    set viminfo='10,\"100,:20,%,n~/.viminfo
" Устанавливаем курсор в файле на место, где он был при закрытии этого файла
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

if has("gui_running")
    let g:airline_powerline_fonts = 1
    "let g:airline#extensions#tabline#enabled = 1
endif

