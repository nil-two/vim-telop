" Show telop on your buffer
" Version: 0.1.0
" Author : wara <kusabashira227@gmail.com>
" License: MIT License

let s:save_cpo = &cpo
set cpo&vim

function! telop#stroverwrite(below, above, startidx) abort
  let border  = strlen(a:above) + a:startidx
  let overlen = a:startidx - strlen(a:below)

  let builder = []
  if a:startidx > 0
    call add(builder, a:below[: a:startidx-1])
  endif
  if overlen > 0
    call add(builder, repeat(' ', overlen))
  endif
  call add(builder, a:above)
  call add(builder, a:below[border :])
  return join(builder, '')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
