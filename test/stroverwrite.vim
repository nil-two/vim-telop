let s:suite = themis#suite('stroverwrite')
let s:assert = themis#helper('assert')

function! s:suite.simple()
  let tests = [
  \   ['abc',   'x',    0, 'xbc'],
  \   ['abc',   'xx',   0, 'xxc'],
  \   ['abcde', 'x',    0, 'xbcde'],
  \   ['abcde', 'xxxx', 0, 'xxxxe'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:suite.overlength()
  let tests = [
  \   ['abc',   'xxx',     0, 'xxx'],
  \   ['abc',   'xxxxx',   0, 'xxxxx'],
  \   ['abcde', 'xxxxx',   0, 'xxxxx'],
  \   ['abcde', 'xxxxxxx', 0, 'xxxxxxx'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:suite.startidx()
  let tests = [
  \   ['abc',   'x',     1, 'axc'],
  \   ['abc',   'x',     2, 'abx'],
  \   ['abcde', 'xxx',   1, 'axxxe'],
  \   ['abcde', 'xxx',   2, 'abxxx'],
  \   ['abcde', 'xxx',   3, 'abcxxx'],
  \   ['abcde', 'xxx',   4, 'abcdxxx'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction
