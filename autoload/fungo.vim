" REF: http://www.cl.ecei.tohoku.ac.jp/nlp100/

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! fungo#1() abort
  let str = 'パタトクカシーー'
  echo join(filter(split(str, '\zs'), {k, v -> k % 2 == 0}), '')
endfunction

function! fungo#2() abort
  let str1 = 'パトカー'
  let str2 = 'タクシー'
  echo join(map(sort(map(split(str1, '\zs'), {k, v -> [k, v]}) + map(split(str2, '\zs'), {k, v -> [k, v]}), {a1, a2 -> a1[0] - a2[0]}), {k, v -> v[1]}), '')
endfunction

function! fungo#3() abort
  let str = 'Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics.'
  echo map(split(str, '\( \|\.\|,\)\+'), {k, v -> len(v)})
endfunction

function! fungo#4() abort
  let str = 'Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can.'
  let targets = [1, 5, 6, 7, 8, 9, 15, 16, 19]
  " REF: :h byteidx()
  echo map(split(str, '\( \|\.\)\+'), {k, v -> index(targets, k+1) < 0 ? v[:1] : v[:0]})
endfunction

" REF: http://d.hatena.ne.jp/kangar/20100608/1275983429
" skip
function! fungo#5() abort
  echo 'skip'
endfunction

" skip
function! fungo#6() abort
  echo 'skip'
endfunction

function! fungo#7(x, y, z) abort
  echo printf('%d時の%sは%.1f', a:x, a:y, a:z)
endfunction

function! fungo#8_encode(str) abort
  echo join(map(split(a:str, '\zs'), {k, v -> v =~ '[a-z]' ? nr2char(219 - char2nr(v)) : v}), '')
  " return join(map(split(a:str, '\zs'), {k, v -> v =~ '[a-z]' ? nr2char(219 - char2nr(v)) : v}), '')
endfunction

function! fungo#8_decode(str) abort
  echo join(map(split(a:str, '\zs'), {k, v -> nr2char(219 - char2nr(v)) =~ '[a-z]' ? nr2char(219 - char2nr(v)) : v}), '')
endfunction

" https://programming-place.net/ppp/contents/algorithm/other/002.html
function! fungo#9(str) abort
  echo join(map(split(a:str, '\zs'), {k, v -> nr2char(219 - char2nr(v)) =~ '[a-z]' ? nr2char(219 - char2nr(v)) : v}), '')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
