" Vim syntax file
" Language: Oak

" Usage Instructions
" Put this file in .vim/syntax/oak.vim
" and add in your .vimrc file the next line:
" autocmd BufRead,BufNewFile *.oak set filetype=oak

if exists("b:current_syntax")
   finish
endif

setlocal cindent
setlocal cinkeys-=0#
setlocal cinoptions+=+0,p0
setlocal commentstring=#%s

syntax match Number "\<[0-9][0-9_]*\>"
syntax match Comment "#.*" contains=Todo
syntax region Comment start="##" end="##" contains=Todo
syntax match Character "'\(\\[nrt0'"\\]\|[^'\\]\)'" contains=SpecialChar
syntax region String start='"' skip='\\\\\|\\"' end='"' contains=SpecialChar
syntax match SpecialChar display contained "\\[nrte0\"']"
syntax keyword Todo TODO XXX FIXME NOTE
syntax keyword Keyword if else for match break return sizeof assert as use fn let const alias struct
syntax keyword Special argc argv
syntax keyword Boolean true false
syntax keyword Type nil int bool char
syntax match Type "\<[A-Z][a-zA-Z0-9_]*\>"
syntax match Constant "\<[A-Z_]\+\>"
syntax match Function "\zs\([A-Za-z_][A-Za-z0-9_]*\)*\s*\ze\(<.*>\)\?("

let b:current_syntax = "oak"
