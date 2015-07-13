let s:suite = themis#suite('strpartdisplaywidth')
let s:assert = themis#helper('assert')

function! s:suite.normal()
  let tests = [
  \   ['abc',   0, 0, ''],
  \   ['abc',   0, 1, 'a'],
  \   ['abc',   0, 3, 'abc'],
  \   ['abcde', 0, 0, ''],
  \   ['abcde', 0, 1, 'a'],
  \   ['abcde', 0, 5, 'abcde'],
  \ ]
  for [src, start, len, dest] in tests
    let expect = dest
    let actual = telop#strpartdisplaywidth(src, start, len)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:suite.over_len()
  let tests = [
  \   ['abc',   0,  5, 'abc'],
  \   ['abc',   0, 10, 'abc'],
  \   ['abcde', 0,  8, 'abcde'],
  \   ['abcde', 0, 15, 'abcde'],
  \ ]
  for [src, start, len, dest] in tests
    let expect = dest
    let actual = telop#strpartdisplaywidth(src, start, len)
    call s:assert.equals(actual, expect)
  endfor
endfunction
