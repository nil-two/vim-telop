let s:suite = themis#suite('stroverwrite')
let s:assert = themis#helper('assert')

function! s:suite.normal()
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

function! s:suite.above_is_longer_than_below()
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

function! s:suite.startidx_is_over_zero()
  let tests = [
  \   ['abc',   'x',   1, 'axc'],
  \   ['abc',   'x',   2, 'abx'],
  \   ['abcde', 'xxx', 1, 'axxxe'],
  \   ['abcde', 'xxx', 2, 'abxxx'],
  \   ['abcde', 'xxx', 3, 'abcxxx'],
  \   ['abcde', 'xxx',   4, 'abcdxxx'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:suite.startidx_is_over_length_of_below()
  let tests = [
  \   ['abc',   'x',   3, 'abcx'],
  \   ['abc',   'x',   5, 'abc  x'],
  \   ['abcde', 'xxx', 5, 'abcdexxx'],
  \   ['abcde', 'xxx', 9, 'abcde    xxx'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:suite.startidx_is_under_zero()
  let tests = [
  \   ['abc',   'x',   -1, 'abc'],
  \   ['abc',   'x',   -2, 'abc'],
  \   ['abcde', 'xxx', -1, 'xxcde'],
  \   ['abcde', 'xxx', -2, 'xbcde'],
  \   ['abcde', 'xxx', -3, 'abcde'],
  \   ['abcde', 'xxx', -4, 'abcde'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:suite.all_over()
  let tests = [
  \   ['abc',   'xxxxx', -1, 'xxxx'],
  \   ['abc',   'xxxxx', -2, 'xxx'],
  \   ['abcde', 'xxxxxxxxx', -3, 'xxxxxx'],
  \   ['abcde', 'xxxxxxxxx', -4, 'xxxxx'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction
