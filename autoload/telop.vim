" Show telop on your buffer
" Version: 0.1.0
" Author : wara <kusabashira227@gmail.com>
" License: MIT License

let s:save_cpo = &cpo
set cpo&vim

function! telop#strpartdisplaywidth(src, start, len) abort
  let last_i = a:start + a:len
  let len_i  = 0
  let builder = []
  for ch in split(a:src, '\zs')
    let len_i += strdisplaywidth(ch)
    if len_i <= a:start
      continue
    endif
    if len_i > last_i
      if (len_i-last_i) == 1 && strdisplaywidth(ch) == 2
        call add(builder, ' ')
      endif
      break
    endif
    call add(builder, ch)
  endfor
  return join(builder, '')
endfunction

function! telop#stroverwrite(below, above, startidx) abort
  let overlen  = max([0, a:startidx - strlen(a:below)])
  let underlen = max([0, 0 - a:startidx])

  let lbeg = min([a:startidx, 0])
  let lend = a:startidx
  let rbeg = a:startidx + strlen(a:above)
  let rend = max([strlen(a:below), rbeg])

  let builder = []
  call add(builder, strpart(a:below, 0, lend - lbeg))
  call add(builder, repeat(' ', overlen))
  call add(builder, strpart(a:above, underlen, rbeg - lend))
  call add(builder, strpart(a:below, rbeg, rend - rbeg))
  return join(builder, "")
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
