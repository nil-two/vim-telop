let s:suite = themis#suite('stroverwrite')
let s:assert = themis#helper('assert')

function! s:suite.simple()
  let tests = [
  \   ['abc', 'x', 0, 'xbc'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction
