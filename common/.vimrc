set tw=80		" always limit the width of text to 78
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
			
" make vim non-VI compatable
set nocp

" make vim use 2 space tab stops
set ts=2
set expandtab

if version >= 600
  filetype plugin on

  set shellslash
  set grepprg=grep\ -nH\ $*

  filetype indent on
	" cvs configuration
	let CVSCommandCVSExec="/usr/local/bin/cvswrapper"
endif
" Only do this for Vim version 5.0 and later.

"no wrap and number lines
set nowrap
set nu
" Set C indenting options
set shiftwidth=2
set cinoptions=>2,g0,t0,{0,*100,p4,+10,:2

" Switch on syntax highlighting.
syntax on

" set the tab character to do automatic indenting.
set cinkeys=0{,0},:,0#,\!<Tab>,\!

" Switch on search pattern highlighting.
set hlsearch

" Hide the mouse pointer while typing
set mousehide

" Set nice colors
highlight Normal guibg=White
highlight Cursor guibg=Magenta guifg=NONE
highlight NonText guibg=White
highlight Constant gui=NONE guibg=White
highlight Type gui=NONE guibg=NONE guifg=Black

set cindent

let g:tex_flavor='latex'
let g:Tex_CompileRule_pdf='pdflatex $*' 
let g:Tex_ViewRule_pdf='open'
let g:Tex_DefaultTargetFormat='pdf'
