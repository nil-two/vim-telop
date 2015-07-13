let s:stroverwrite = themis#suite('stroverwrite')
let s:assert = themis#helper('assert')

function! s:stroverwrite.normal()
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

function! s:stroverwrite.above_is_longer_than_below()
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

function! s:stroverwrite.startidx_is_over_zero()
  let tests = [
  \   ['abc',   'x',   1, 'axc'],
  \   ['abc',   'x',   2, 'abx'],
  \   ['abcde', 'xxx', 1, 'axxxe'],
  \   ['abcde', 'xxx', 2, 'abxxx'],
  \   ['abcde', 'xxx', 3, 'abcxxx'],
  \   ['abcde', 'xxx', 4, 'abcdxxx'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:stroverwrite.startidx_is_over_length_of_below()
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

function! s:stroverwrite.startidx_is_under_zero()
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

function! s:stroverwrite.all_over()
  let tests = [
  \   ['abc',   'xxxxx',     -1, 'xxxx'],
  \   ['abc',   'xxxxx',     -2, 'xxx'],
  \   ['abcde', 'xxxxxxxxx', -3, 'xxxxxx'],
  \   ['abcde', 'xxxxxxxxx', -4, 'xxxxx'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:stroverwrite.empty()
  let tests = [
  \   ['',    'x', -1, ''],
  \   ['',    'x', 0,  'x'],
  \   ['',    'x', 1,  ' x'],
  \   ['abc', '',  -1, 'abc'],
  \   ['abc', '',  0,  'abc'],
  \   ['abc', '',  1,  'abc'],
  \   ['abc', '',  5,  'abc  '],
  \   ['',    '',  -1, ''],
  \   ['',    '',  0,  ''],
  \   ['',    '',  1,  ' '],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:stroverwrite.multi_byte_simple()
  let tests = [
  \   ['abcde',  'あ',      0, 'あcde'],
  \   ['abcde',  'あい',    0, 'あいe'],
  \   ['abcde',  'あいう',  0, 'あいう'],
  \   ['あいう', 'a',       0, 'a いう'],
  \   ['あいう', 'ab',      0, 'abいう'],
  \   ['あいう', 'abc',     0, 'abc う'],
  \   ['あいう', 'abcd',    0, 'abcdう'],
  \   ['あいう', 'abcde',   0, 'abcde '],
  \   ['あいう', 'abcdef',  0, 'abcdef'],
  \   ['あいう', 'abcdefg', 0, 'abcdefg'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:stroverwrite.multi_byte_and_start_over_zero()
  let tests = [
  \   ['abcde',      'あ',   1, 'aあde'],
  \   ['abcde',      'あ',   2, 'abあe'],
  \   ['abcde',      'あ',   3, 'abcあ'],
  \   ['abcde',      'あ',   4, 'abcdあ'],
  \   ['abcde',      'あ',   5, 'abcdeあ'],
  \   ['あいう',     'a',    1, ' aいう'],
  \   ['あいう',     'a',    2, 'あa う'],
  \   ['あいう',     'a',    3, 'あ aう'],
  \   ['あいう',     'a',    4, 'あいa '],
  \   ['あいう',     'a',    5, 'あい a'],
  \   ['あいう',     'a',    6, 'あいうa'],
  \   ['あいう',     'a',    7, 'あいう a'],
  \   ['あabいcdう', 'xん',  1, ' xんいcdう'],
  \   ['あabいcdう', 'xん',  2, 'あxん cdう'],
  \   ['あabいcdう', 'xん',  3, 'あaxんcdう'],
  \   ['あabいcdう', 'xん',  4, 'あabxんdう'],
  \   ['あabいcdう', 'xん',  5, 'あab xんう'],
  \   ['あabいcdう', 'xん',  6, 'あabいxん '],
  \   ['あabいcdう', 'xん',  7, 'あabいcxん'],
  \   ['あabいcdう', 'xん',  8, 'あabいcdxん'],
  \   ['あabいcdう', 'xん',  9, 'あabいcd xん'],
  \   ['あabいcdう', 'xん', 10, 'あabいcdうxん'],
  \   ['あabいcdう', 'xん', 11, 'あabいcdう xん'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:stroverwrite.multi_byte_and_start_under_zero()
  let tests = [
  \   ['abcde',  'あ',         -1,  ' bcde'],
  \   ['abcde',  'あ',         -2,  'abcde'],
  \   ['abcde',  'あ',         -3,  'abcde'],
  \   ['abcde',  'あいう',     -1,  ' いう'],
  \   ['abcde',  'あいう',     -2,  'いうe'],
  \   ['abcde',  'あいう',     -3,  ' うde'],
  \   ['abcde',  'あいう',     -4,  'うcde'],
  \   ['abcde',  'あいう',     -5,  ' bcde'],
  \   ['abcde',  'あいう',     -6,  'abcde'],
  \   ['abcde',  'あいう',     -7,  'abcde'],
  \   ['あいう', 'abc',        -1,  'bcいう'],
  \   ['あいう', 'abc',        -2,  'c いう'],
  \   ['あいう', 'abc',        -3,  'あいう'],
  \   ['あいう', 'abc',        -4,  'あいう'],
  \   ['xん',    'あabいcdう', -1,  ' abいcdう'],
  \   ['xん',    'あabいcdう', -2,  'abいcdう'],
  \   ['xん',    'あabいcdう', -3,  'bいcdう'],
  \   ['xん',    'あabいcdう', -4,  'いcdう'],
  \   ['xん',    'あabいcdう', -5,  ' cdう'],
  \   ['xん',    'あabいcdう', -6,  'cdう'],
  \   ['xん',    'あabいcdう', -7,  'dう'],
  \   ['xん',    'あabいcdう', -8,  'う '],
  \   ['xん',    'あabいcdう', -9,  ' ん'],
  \   ['xん',    'あabいcdう', -10, 'xん'],
  \   ['xん',    'あabいcdう', -11, 'xん'],
  \ ]
  for [below, above, startidx, dest] in tests
    let expect = dest
    let actual = telop#stroverwrite(below, above, startidx)
    call s:assert.equals(actual, expect)
  endfor
endfunction
