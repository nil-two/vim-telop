" Show telop on your buffer
" Version: 0.1.0
" Author : kusabashira <kusabashira227@gmail.com>
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
    if (len_i-a:start) == 1 && strdisplaywidth(ch) == 2
      call add(builder, ' ')
    else
      call add(builder, ch)
    endif
  endfor
  return join(builder, '')
endfunction

function! telop#stroverwrite(below, above, startidx) abort
  let belowlen = strdisplaywidth(a:below)
  let abovelen = strdisplaywidth(a:above)
  let overlen  = max([0, a:startidx - belowlen])
  let underlen = max([0, 0 - a:startidx])

  let lbeg = min([a:startidx, 0])
  let lend = a:startidx
  let rbeg = a:startidx + abovelen
  let rend = max([belowlen, rbeg])

  let builder = []
  call add(builder, telop#strpartdisplaywidth(a:below, 0, lend - lbeg))
  call add(builder, repeat(' ', overlen))
  call add(builder, telop#strpartdisplaywidth(a:above, underlen, rbeg - lend))
  call add(builder, telop#strpartdisplaywidth(a:below, rbeg, rend - rbeg))
  return join(builder, '')
endfunction

let s:telop = {
\   'lnum': -1,
\   'orig_line': '',
\   'message': '',
\ }

function! s:new_telop(message) abort
  let t = deepcopy(s:telop)
  let t.lnum = line('w0')
  let t.orig_line = getline(t.lnum)
  let t.message = a:message
  return t
endfunction

function! s:telop.make_line(start) abort
  let line = telop#stroverwrite(self.orig_line, self.message, a:start)
  let suppressed_line = telop#strpartdisplaywidth(line, 0, winwidth(0))
  return suppressed_line
endfunction

function! s:telop.flow() abort
  let leftend  = -strdisplaywidth(self.message)
  let rightend = winwidth(0)

  for col in reverse(range(leftend, rightend))
    if getchar(1)
      break
    endif
    call setline(self.lnum, self.make_line(col))
    redraw
    sleep 30ms
  endfor
  call setline(self.lnum, self.orig_line)
  silent undo
endfunction

function! telop#flow(message) abort
  let t = s:new_telop(a:message)
  call t.flow()
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
