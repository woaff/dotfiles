source /etc/vimrc
set background=dark
set visualbell
set noerrorbells

set number
" set relativenumber
set t_vb=
" set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=longest:full,full
set wildoptions=pum
set noswapfile
" set shortmess-=S
set clipboard=unnamed,unnamedplus
set splitright
" set formatoptions-=cro
set mouse=a
set signcolumn=yes
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,cp936
set nofoldenable
set termwinsize=8*0
set colorcolumn=80
set complete+=k
set dictionary+=~/.vim/dict/language.txt
syntax enable
filetype plugin indent on

" let mapleader="\<space>"

" cursor shape
let &t_SI = "\e[6 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[2 q"

augroup RltvNmbr
	autocmd!
	autocmd VimEnter * RltvNmbr
	autocmd BufEnter * RltvNmbr
	autocmd VimEnter * set number
augroup END

augroup FormatOptions
	autocmd!
	autocmd FileType * setlocal formatoptions-=cro
augroup END

" Insert newline without quit normal mode
" nmap oo o<Esc>k
" nmap OO O<Esc>j

" clear highlight search
nnoremap <CR> :noh<CR><CR>

" Delete the word after the cursor
cnoremap <F31> <C-F>ea<C-W><C-C>
execute "set <F31>=\<Esc>d"

augroup Compile
	autocmd!
	autocmd FileType xml map <leader><F2> <Esc>:%!xmllint --format -<CR>
	autocmd FileType python map <leader><F3> :exec '!python3' shellescape(@%, 1)<CR>
	" autocmd FileType c map <leader><F4> :!gcc % -o %:t:r && ./%:t:r<CR>
	" map <leader><F3> <Esc>:w !python %<CR>
	" autocmd FileType java map <leader><F5> <Esc>:w !java %<CR>
augroup END

" move line
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" map <Ctrl-Enter> Insert Mode jump to next line
inoremap <NL> <C-O>o
nnoremap <NL> A<CR><Esc>

" map <C-S> to save file
inoremap <C-S> <Esc>:noa w<CR>
nnoremap <C-S> :noa w<CR>

" map delete with no register
nnoremap <leader>d "_d
xnoremap <leader>d "_d

" open terminal
nnoremap <leader>c :wincmd b \| bel terminal<CR>

" close terminal
tnoremap <Esc> <C-W>:q!<CR>

" select fenced code block
function! SelectFencedCodeBlock()
    call searchpos('^```', 'b')
    normal! jv
    call searchpos('^```', 'W')
    normal! k$
endfunction

nnoremap <leader>cb :<C-U>call SelectFencedCodeBlock()<CR>

" copy messages
nnoremap <leader>m :let @*=trim(execute('1messages')) \| echo 'copied'<CR>

" source file
nnoremap <leader>s :source %<CR>

" WSL vim gx support
let g:netrw_browsex_viewer='cmd.exe /C start'

" WSL yank support
" let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
" if executable(s:clip)
    " augroup WSLYank
        " autocmd!
        " autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    " augroup END
" endif

" coc extensions list
let g:coc_global_extensions = [
		\ 'coc-marketplace',
		\ 'coc-prettier',
		\ 'coc-diagnostic',
		\ 'coc-snippets',
		\ 'coc-translator',
		\ 'coc-explorer',
		\ 'coc-vimlsp',
		\ 'coc-sh',
		\ 'coc-json',
		\ 'coc-xml',
		\ 'coc-yaml',
		\ 'coc-html',
		\ 'coc-css',
		\ 'coc-tsserver',
		\ 'coc-eslint',
		\ 'coc-toml',
		\ 'coc-clangd',
		\ 'coc-cmake',
		\ 'coc-java',
		\ 'coc-java-debug',
		\ 'coc-java-lombok',
		\ 'coc-markdownlint',
		\ 'coc-pyright',
		\ 'coc-sql',
		\ 'coc-dictionary',
		\ 'coc-fzf-preview',
		\ ]

" coc suggestion box change color
" hi Pmenu ctermbg=Black ctermfg=White

" TextEdit might fail if hidden is not set.
set hidden

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  execute "set <A-/>=\e/"
  inoremap <silent><expr> <A-/> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
" nnoremap <silent> <leader>h :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
" augroup Highlight
" 	autocmd!
" 	autocmd CursorHold * silent call CocActionAsync('highlight')
" augroup END

" Local Variable Color Can't See
augroup LocalVariableColor
    autocmd!
    autocmd ColorScheme *
      \ hi CocUnusedHighlight ctermbg=NONE guibg=NONE guifg=#808080
augroup END

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" coc file path
" let g:coc_confing_home = '~/.vim/coc-settings.json'

" coc translator popup
" nmap <leader>s <Plug>(coc-translator-p)
" vmap <leader>s <Plug>(coc-translator-pv)

" coc snippets location
if has('win32unix')
let g:coc_data_home = 'C:\\Users\\Administrator\\.config\\coc'
endif

" coc explorer
nmap <leader>e :CocCommand explorer<CR>
" when all buffer close coc-explorer close automatically
augroup ExplorerAutoClose
	autocmd!
	autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
augroup END

augroup ExplorerRelativeNumber
    autocmd!
    autocmd FileType coc-explorer setlocal relativenumber
augroup END

" commentary
nmap <C-_> <Esc><Plug>CommentaryLine
imap <C-_> <Esc><Plug>CommentaryLine
xnoremap <C-_> :g/./Commentary<CR>
augroup CComment
	autocmd FileType c setlocal commentstring=//\ %s
augroup END
augroup JsonToJsonc
    autocmd FileType json set filetype=jsonc
augroup END

" auto-pairs
" Disable backspace delete pairs
let g:AutoPairsMapBS = 0

" airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Enable the number of buffers
let g:airline#extensions#tabline#buffer_nr_show = 1

" vimspector
" if has('win32unix')
" 	let &pythonthreedll = 'C:\Users\Administrator\AppData\Local\Programs\Python\Python312\python312.dll'
" 	let $PYTHONHOME = 'C:\Users\Administrator\AppData\Local\Programs\Python\Python312-32\'
" endif

" key map mode
" let g:vimspector_enable_mappings = 'HUMAN'

" key mapping
nnoremap <F2> :call vimspector#Continue()<CR>
nnoremap <F3> :call vimspector#Stop()<CR>
nnoremap <F4> :call vimspector#Restart()<CR>
nnoremap <F5> :call vimspector#StepInto()<CR>
nnoremap <F6> :call vimspector#StepOver()<CR>
nnoremap <F7> :call vimspector#StepOut()<CR>
nnoremap <F9> :call vimspector#ToggleBreakpoint()<CR>
nnoremap <F12> :call vimspector#RunToCursor()<CR>
" nnoremap <F9> :call vimspector#ClearBreakpoints()<CR>
nnoremap <F10> :call AddToWatch()<CR>
func! AddToWatch()
  let word = expand('<cexpr>')
  call vimspector#AddWatch(word)
endfunction

" template
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/.vim/sample_vimspector/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.vim/sample_vimspector',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>

" layout
let g:vimspector_bottombar_height = 5

" gadgets list
let g:vimspector_install_gadgets = [
		\ 'vscode-bash-debug',
		\ 'debugpy',
		\ 'vscode-cpptools',
		\ 'vscode-java-debug',
		\ 'vscode-js-debug',
		\ ]

" wilder
" call wilder#setup({'modes': [':', '/', '?']})

" Ultisnips
let g:UltiSnipsSnippetDirectories = ['Ultisnips', '$HOME/.vim/Ultisnips/']

" Trigger configuration
let g:UltiSnipsJumpForwardTrigger="<A-f>"
let g:UltiSnipsJumpBackwardTrigger="<A-b>"

" Tagbar Outline
nmap <leader>o :TagbarToggle<CR>

" Show relative line numbers
let g:tagbar_show_linenumbers = 2

" Tagbar focus on result pane
let g:tagbar_autofocus = 1

" ctrlsf search
" nnoremap <C-S-f> :CtrlSF 
nnoremap <leader>x <Plug>CtrlSFPrompt

" ctrlsf focus on result pane
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

" MarkdownPreview Config

" set to 1, Vim will refresh Markdown when saving the buffer or
" when leaving insert mode. Default 0 is auto-refresh Markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 1

" use a custom Markdown style. Must be an absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
" let g:mkdp_markdown_css = '$HOME/.local/lib/github-markdown-css/github-markdown.css'

" table mode markdown
nmap <leader>tm :TableModeToggle<CR>

let g:table_mode_corner='|'

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" vim-markdown
" Disable folding
let g:vim_markdown_folding_disabled = 1

" Disable conceal in markdown
let g:vim_markdown_conceal = 0

" Disable conceal for code block
let g:vim_markdown_conceal_code_blocks = 0

" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
		                      \ 'syntax': 'markdown', 'ext': 'md'}]

" img-paste
augroup MarkdownClip
	autocmd!
	autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
augroup END
" there are some defaults for image directory and image name, you can change them
let g:mdip_imgdir = './' . expand('%:t:r') . '.assets'
let g:mdip_imgname = 'image'
let g:mdip_tmpname = g:mdip_imgname . '-' .  strftime("%Y%m%d%H%M%S") . reltimestr(reltime())[5:7]

" NERDTree
" Enable line number
let g:NERDTreeShowLineNumbers = 1

" Show hidden file
let g:NERDTreeShowHidden = 1

" Disable bookmark and help
let g:NERDTreeMinimalUI = 1

" NERDTree Git
" Enable Nerd Fonts
let g:NERDTreeGitStatusUseNerdFonts = 1

" Git Status Custom Symbol
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Untracked' :'*',
                \ 'Modified'  :'~',
                \ 'Staged'    :'+',
                \ 'Renamed'   :'»',
                \ 'Unmerged'  :'≠',
                \ 'Deleted'   :'-',
                \ 'Dirty'     :'×',
                \ 'Clean'     :'√',
                \ 'Ignored'   :'☒',
                \ 'Unknown'   :'?',
                \ }

" NERDTree Tabs
" map file toggle
nnoremap <silent> <expr> <leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTreeToggle<CR>"

" when all buffer close NERDTree close automatically
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" undotree
nnoremap <leader>u :UndotreeToggle<CR>

" undotree focus on result pane
let g:undotree_SetFocusWhenToggle = 1

" suda smart edit
let g:suda_smart_edit = 1

" suda use sudo without password
" let g:suda#noninteractive = 1

" VRC
" Remap trigger key
let g:vrc_trigger = '<leader>q'
" Set the output buffer name
let g:vrc_output_buffer_name = '__REST_response.json'
" Run a format command on the respones buffer
let g:vrc_auto_format_response_patterns = { 'json':'jq' }

" fzf
nnoremap <leader>z :Files<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>r :RG<CR>

" fzf-preview

" key mapping
nnoremap <leader>zp :FzfPreviewFromResourcesRpc project_mru git<CR>
nnoremap <leader>za :FzfPreviewGitActionsRpc<CR>
nnoremap <leader>zs :FzfPreviewGitStatusRpc<CR>
nnoremap <leader>zl :FzfPreviewGitLogsRpc<CR>
nnoremap <leader>zh :FzfPreviewMrwFilesRpc<CR>
nnoremap <leader>zb :FzfPreviewAllBuffersRpc<CR>
nnoremap <leader>z/ :FzfPreviewLinesRpc<CR>
nnoremap <leader>zt :FzfPreviewBufferTagsRpc<CR>
nnoremap <leader>zd <Cmd>CocCommand fzf-preview.CocDiagnostics<CR>

" fzf window position settings
let g:fzf_preview_direct_window_option = { 'width': 0.9, 'height': 0.6 }

" fzf command default options
let g:fzf_preview_default_fzf_options = { '--preview-window': 'wrap' }

" Commands used for preview of the grep result
let g:fzf_preview_grep_preview_cmd = '$HOME/.config/coc/extensions/node_modules/coc-fzf-preview/bin/preview_fzf_grep'

" Use as fzf preview-window option
let g:fzf_preview_fzf_preview_window_option = 'right:50%'

" singele compile
nnoremap <leader><F4> :SCCompile -g<CR>
nnoremap <leader><F5> :SCCompileRun<cr>

" indent line
" json display double quotes
let g:vim_json_conceal = 0
" markdown display double star
let g:markdown_syntax_conceal = 0
let g:indentLine_fileTypeExclude = ['help', 'diff', 'man', 'nerdtree', 'undotree', 'coc-explorer']
let g:indentLine_bufTypeExclude = ['help', 'terminal']

" lens
let g:lens#disabled_filetypes = ['tagbar', 'nerdtree']

" yazi
nnoremap <leader>y :Yazi<CR>

call plug#begin()
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'
" Plug 'gelguy/wilder.nvim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'gisphm/vim-gitignore'
Plug 'nfischer/vim-vimignore'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/RltvNmbr.vim'
" Plug 'myusuf3/numbers.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'kien/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'google/vim-searchindex'
" Plug 'junegunn/limelight.vim'
" Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'puremourning/vimspector'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'dense-analysis/ale'
" Plug 'kuniwak/vint'
" Plug 'itspriddle/vim-shellcheck'
Plug 'majutsushi/tagbar'
Plug 'preservim/vim-markdown'
" Plug 'wookayin/vim-typora'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'dhruvasagar/vim-table-mode'
Plug 'img-paste-devs/img-paste.vim'
Plug 'godlygeek/tabular'
" Plug 'vimwiki/vimwiki'
Plug 'pbrisbin/vim-mkdir'
" Plug 'cdelledonne/vim-cmake'
Plug 'pboettch/vim-cmake-syntax'
Plug 'mikelue/vim-maven-plugin'
Plug 'nlknguyen/vim-maven-syntax'
Plug 'mbbill/undotree'
Plug 'lambdalisue/suda.vim'
Plug 'diepm/vim-rest-console'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'andymass/vim-matchup'
Plug 'osyo-manga/vim-over'
Plug 'mattn/emmet-vim'
" Plug 'shougo/vimshell.vim'
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'xuhdev/singlecompile'
Plug 'janko-m/vim-test'
if !has('nvim')
    Plug 'rhysd/vim-healthcheck'
endif
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'yggdroot/indentline'
Plug 'camspiers/lens.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'tommcdo/vim-exchange'
Plug 'github/copilot.vim'
Plug 'chriszarate/yazi.vim'
call plug#end()

" Use gruvbox theme
set termguicolors
colorscheme gruvbox

" Use Dark Mode
set background=dark
