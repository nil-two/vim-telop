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

function! s:suite.len_is_over_src_length()
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

function! s:suite.start_over_zero()
  let tests = [
  \   ['abc',   1,  1, 'b'],
  \   ['abc',   1,  3, 'bc'],
  \   ['abcde', 2,  1, 'c'],
  \   ['abcde', 2,  5, 'cde'],
  \ ]
  for [src, start, len, dest] in tests
    let expect = dest
    let actual = telop#strpartdisplaywidth(src, start, len)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:suite.start_under_zero()
  let tests = [
  \   ['abc', -1, 20, 'abc'],
  \   ['abc', -5, 20, 'abc'],
  \   ['abc', -2, 0,  ''],
  \   ['abc', -2, 2,  ''],
  \   ['abc', -2, 3,  'a'],
  \   ['abc', -2, 5,  'abc'],
  \   ['abc', -2, 8,  'abc'],
  \ ]
  for [src, start, len, dest] in tests
    let expect = dest
    let actual = telop#strpartdisplaywidth(src, start, len)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:suite.multi_byte_even_length()
  let tests = [
  \   ['あいう',     0, 2,  'あ'],
  \   ['あいう',     0, 4,  'あい'],
  \   ['あいう',     0, 8,  'あいう'],
  \   ['あいうえお', 0, 8,  'あいうえ'],
  \   ['あいうえお', 0, 16, 'あいうえお'],
  \ ]
  for [src, start, len, dest] in tests
    let expect = dest
    let actual = telop#strpartdisplaywidth(src, start, len)
    call s:assert.equals(actual, expect)
  endfor
endfunction

