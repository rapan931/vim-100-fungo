" REF: http://www.cl.ecei.tohoku.ac.jp/nlp100/
" "hogehog

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let s:hightemp_file_path = expand('<sfile>:h:h') . '/t/hightemp.txt'
let s:jawiki_file_path = expand('<sfile>:h:h') . '/t/jawiki-country.json'

" let g:t_dir_path = get(g:, 'fungo_output_dir', expand('%:p:h:h') . '/t')
let s:t_dir_path = expand('%:p:h:h') . '/t'

function! fungo#1() abort
  " let str = "ぱたとくかしーー"
  let str = 'パタトクカシーー'
  echo join(filter(split(str, '\zs'), {k, v -> k % 2 == 0}), '')
endfunction

function! fungo#2() abort
  let str1 = 'パトカー'
  let str2 = 'タクシー'
  let str1_and_str2 = map(split(str1, '\zs'), {k, v -> [k, v]}) + map(split(str2, '\zs'), {k, v -> [k, v]})

  echo join(map(sort(str1_and_str2, {a1, a2 -> a1[0] == a2[0] ? 0 : a1[0] > a2[0] ? 1 : -1}), {k, v -> v[1]}), '')
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
function! fungo#5() abort
  " 回答が何になるのか理解できていない
  echo 'skip'
endfunction

function! fungo#6() abort
  " 回答が何になるのか理解できていない
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
  echo str
  echo join(map(split(str, ' '), {k, v -> len(v) > 4 ? v[0] . fungo#util#shuffle(v[1:-2]) . v[len(v) - 1]  : v}), ' ')
endfunction

function! fungo#10() abort
  echo len(readfile(s:hightemp_file_path))
endfunction

function! fungo#11() abort
  echo join(map(readfile(s:hightemp_file_path), {k, v -> fungo#util#conv_my_enc(v)}), "\n")
endfunction

function! fungo#12() abort
  let col1s = map(map(readfile(s:hightemp_file_path), {k, v -> split(fungo#util#conv_my_enc(v), '\t')}), {k, v -> v[0]})
  let col2s = map(map(readfile(s:hightemp_file_path), {k, v -> split(fungo#util#conv_my_enc(v), '\t')}), {k, v -> v[1]})

  call writefile(map(col1s, {k, v -> fungo#util#conv_utf8(v)}), s:t_dir_path . '/col1.txt')
  call writefile(map(col2s, {k, v -> fungo#util#conv_utf8(v)}), s:t_dir_path . '/col2.txt')
endfunction

function! fungo#13() abort
  let col1s = readfile(s:t_dir_path . '/col1.txt')
  let col2s = readfile(s:t_dir_path . '/col2.txt')
  call writefile(map(fungo#util#zip(col1s, col2s), {k, v -> fungo#util#conv_utf8(join(v, "\t"))}), s:t_dir_path . '/13.txt')
endfunction

function! fungo#14(num) abort
  let rows = readfile(s:hightemp_file_path)

  if (a:num < 1)  || (len(rows) < a:num)
    echohl ErrorMsg | echo 'invalid!' | echohl none
    return
  endif

  for i in range(a:num)
    echo fungo#util#conv_my_enc(rows[i])
  endfor
endfunction

function! fungo#15(num) abort
  let rows = readfile(s:hightemp_file_path)
  let row_count = len(rows)

  if (a:num < 1)  || (row_count < a:num)
    echohl ErrorMsg | echo 'invalid!' | echohl none
    return
  endif

  for i in range(row_count - a:num + 1, row_count)
    echo fungo#util#conv_my_enc(rows[i])
  endfor
endfunction

function! fungo#16(num) abort
  let alpha = 0x61 " "a" == 0x61
  let each_rows = fungo#util#each_slice(readfile(s:hightemp_file_path), a:num)

  for i in range(len(each_rows))
    call writefile(each_rows[i], s:t_dir_path . '/16_' . nr2char(alpha + i))
  endfor
endfunction

function! fungo#17() abort
  let rows = readfile(s:hightemp_file_path)
  echo uniq(sort(map(rows, {k, v -> split(fungo#util#conv_my_enc(v), '\t')[0]})))
endfunction

function! fungo#18() abort
  let rows =  map(readfile(s:hightemp_file_path), {k, v -> [fungo#util#conv_my_enc(v), split(fungo#util#conv_my_enc(v), '\t')[2]]})
  let rows = sort(rows, {a1, a2 -> str2float(a1[1][2]) == str2float(a2[1][2]) ? 0 : str2float(a1[1][2]) < str2float(a2[1][2]) ? 1 : -1})
  echo join(map(rows, {k, v -> v[0]}), "\n")
endfunction

function! fungo#19() abort
  let col1s =  map(readfile(s:hightemp_file_path), {k, v -> split(fungo#util#conv_my_enc(v), '\t')[0]})
  let dict = {}
  for v in col1s
    let dict[v] = has_key(dict, v) ? dict[v] + 1 : 1
  endfor

  let tmp = []
  for k_v in items(dict)
    call add(tmp, k_v)
  endfor
  echo join(map(sort(tmp, {a1, a2 -> a2[1] - a1[1]}), {k, v -> v[0]}), "\n")
endfunction

function! fungo#20() abort
  echo fungo#util#englad_text(s:jawiki_file_path)
endfunction

" [[Category:xxxxxxx]]
function! fungo#21() abort
  let str = fungo#util#englad_text(s:jawiki_file_path)
  call substitute(str, 'Category:\(.\{-\}\)\ze\]', {m -> execute('echo m[1]', "")}, 'g')
endfunction

" \n====xxxxx====\n
function! fungo#22() abort
  " let str = fungo#util#englad_text(s:jawiki_file_path)
  " call substitute(str, '\n\zs=\{-\}\([^=]\{-\}\)=*\ze\n', {m -> execute('echo m[1]', "")}, 'g')
endfunction

function! fungo#23() abort
  echo 'skip'
endfunction

function! fungo#other_sintyoku() abort
  let s:str = '進捗どうですか'
  let s:list = split(s:str, '\zs')
  echo s:str
  echo join(reverse(split(s:str, '\zs')), '')
  echo join(map(split(s:str, '\zs'), {k, v -> repeat(' ', k) . v}), "\n")
  echo join(map(range(len(s:list)), {k -> join(s:list[k:], '') . join(s:list[:-len(s:list) - 1 + k], '')}), "\n")
  " echo call({f, n -> f(f, n)}, [{f, n -> n < len(s:list) ? repeat(n * f(f, n + 1), ' ') . s:list[n - 1] : 1}, 1])
  " call({f, n -> f(f, n)}, [{f, n -> n < len(s:list) ? execute('echo ' .  n * f(f, n + 1)) : 1}, 1])

  echo call({f,n->f(f,n)}, [{f, n -> n > 0  ? execute('echo ' . n * f(f, n - 1)) : 1}, 3])
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" NOTE:
" [] + [] => []
" add([], []) => [[]]
