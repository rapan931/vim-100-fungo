" REF: http://www.cl.ecei.tohoku.ac.jp/nlp100/

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let s:fungo_vim_file_path = expand('%:p')
let s:hightemp_txt_file_path = expand('%:p:h:h') . '/t/hightemp.txt'
let s:t_dir_path = expand('%:p:h:h') . '/t'

function! fungo#1() abort
  " let str = "ぱたとくかしーー"
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

function! fungo#9() abort
  let str = "I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind ."
  echo join(map(split(str, ' '), {k, v -> len(v) > 4 ? v[0] . fungo#util#shuffle(v[1:-2]) . v[len(v) - 1]  : v}), ' ')
endfunction

function! fungo#10() abort
  echo len(readfile(s:hightemp_txt_file_path))
endfunction

function! fungo#11() abort
  try
    let save_enc = &l:encoding
    setlocal encoding=utf-8

    " call writefile(map(readfile(s:hightemp_txt_file_path), {k, v -> substitute(v, '\t', ' ', "g")}), s:t_dir_path . '/hightemp11.txt')
    echo join(map(readfile(s:hightemp_txt_file_path), {k, v -> v}), "\n")

  finally
    let &l:encoding = save_enc
  endtry
endfunction

function! fungo#12() abort
  try
    let save_enc = &l:encoding
    setlocal encoding=utf-8

    let col1s = map(map(readfile(s:hightemp_txt_file_path), {k, v -> split(v, '\t')}), {k, v -> v[0]})
    let col2s = map(map(readfile(s:hightemp_txt_file_path), {k, v -> split(v, '\t')}), {k, v -> v[1]})

    call writefile(col1s, s:t_dir_path . '/col1.txt')
    call writefile(col2s, s:t_dir_path . '/col2.txt')
  finally
    let &l:encoding = save_enc
  endtry
endfunction

function! fungo#13() abort
  let col1s = readfile(s:t_dir_path . '/col1.txt')
  let col2s = readfile(s:t_dir_path . '/col2.txt')
  " echo join(fungo#util#zip(col1s, col2s), "\n")
  " call  fungo#util#zip(col1s, col2s)
  " echo  len(fungo#util#zip(col1s, col2s))
    call writefile(map(fungo#util#zip(col1s, col2s), {k, v -> join(v, "\t")}), s:t_dir_path . '/hightemp13.txt')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
