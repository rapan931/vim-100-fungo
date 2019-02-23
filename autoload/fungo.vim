" REF: http://www.cl.ecei.tohoku.ac.jp/nlp100/

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! fungo#1() abort
  return 0
endfunction

function! fungo#2() abort
  return 0
endfunction

function! fungo#3() abort
  let l:str = 'Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics.'
  echo map(split(str, '\( \|\.\|,\)\+'), {k, v -> len(v)})
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
