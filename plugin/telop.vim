" Show telop on your buffer
" Version: 0.1.0
" Author : wara <kusabashira227@gmail.com>
" License: MIT License

if exists('g:loaded_telop')
  finish
endif
let g:loaded_telop = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=* TelopFlow
\ call telop#flow(join([<q-args>], ' '))

let &cpo = s:save_cpo
unlet s:save_cpo
