" Show telop on your buffer
" Version: 0.1.0
" Author : wara <kusabashira227@gmail.com>
" License: MIT License

let s:save_cpo = &cpo
set cpo&vim

function! telop#stroverwrite(below, above, startidx) abort
  let builder = []
  if a:startidx == 0
    call add(builder, a:above)
    call add(builder, a:below[strlen(a:above) + a:startidx :])
  elseif a:startidx > 0
    call add(builder, a:below[: a:startidx-1])
    call add(builder, repeat(' ', a:startidx - strlen(a:below)))
    call add(builder, a:above)
    call add(builder, a:below[strlen(a:above) + a:startidx :])
  elseif a:startidx < 0
    call add(builder, a:above[-a:startidx :])
    call add(builder, a:below[strlen(a:above) - strlen(a:below) + a:startidx :])
  endif
  return join(builder, '')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
