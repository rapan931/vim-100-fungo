" REF: http://www.cl.ecei.tohoku.ac.jp/nlp100/

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let g:fungo_hightemp_path = get(g:, 'fungo_hightemp_path', '')
let g:fungo_jawiki_path = get(g:, 'fungo_jawiki_path', '')

let s:t_dir_path = expand('<sfile>:h:h') . '/t'

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
  echo len(readfile(g:fungo_hightemp_path))
endfunction

function! fungo#11() abort
  echo join(map(readfile(g:fungo_hightemp_path), {k, v -> fungo#util#conv_my_enc(v)}), "\n")
endfunction

function! fungo#12() abort
  let col1s = map(map(readfile(g:fungo_hightemp_path), {k, v -> split(fungo#util#conv_my_enc(v), '\t')}), {k, v -> v[0]})
  let col2s = map(map(readfile(g:fungo_hightemp_path), {k, v -> split(fungo#util#conv_my_enc(v), '\t')}), {k, v -> v[1]})

  call writefile(map(col1s, {k, v -> fungo#util#conv_utf8(v)}), s:t_dir_path . '/col1.txt')
  call writefile(map(col2s, {k, v -> fungo#util#conv_utf8(v)}), s:t_dir_path . '/col2.txt')
endfunction

function! fungo#13() abort
  let col1s = readfile(s:t_dir_path . '/col1.txt')
  let col2s = readfile(s:t_dir_path . '/col2.txt')
  call writefile(map(fungo#util#zip(col1s, col2s), {k, v -> fungo#util#conv_utf8(fungo#util#conv_my_enc(join(v, "\t")))}), s:t_dir_path . '/13.txt')
endfunction

function! fungo#14(num) abort
  let rows = readfile(g:fungo_hightemp_path)

  if (a:num < 1)  || (len(rows) < a:num)
    echohl ErrorMsg | echo 'invalid!' | echohl none
    return
  endif

  for i in range(a:num)
    echo fungo#util#conv_my_enc(rows[i])
  endfor
endfunction

function! fungo#15(num) abort
  let rows = readfile(g:fungo_hightemp_path)
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
  let each_rows = fungo#util#each_slice(readfile(g:fungo_hightemp_path), a:num)

  for i in range(len(each_rows))
    call writefile(each_rows[i], s:t_dir_path . '/16_' . nr2char(alpha + i))
  endfor
endfunction

function! fungo#17() abort
  let rows = readfile(g:fungo_hightemp_path)
  echo uniq(sort(map(rows, {k, v -> split(fungo#util#conv_my_enc(v), '\t')[0]})))
endfunction

function! fungo#18() abort
  let rows =  map(readfile(g:fungo_hightemp_path), {k, v -> [fungo#util#conv_my_enc(v), split(fungo#util#conv_my_enc(v), '\t')[2]]})
  let rows = sort(rows, {a1, a2 -> str2float(a1[1][2]) == str2float(a2[1][2]) ? 0 : str2float(a1[1][2]) < str2float(a2[1][2]) ? 1 : -1})
  echo join(map(rows, {k, v -> v[0]}), "\n")
endfunction

function! fungo#19() abort
  let col1s =  map(readfile(g:fungo_hightemp_path), {k, v -> split(fungo#util#conv_my_enc(v), '\t')[0]})
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
  echo fungo#util#englad_text(g:fungo_jawiki_path)
endfunction

" [[Category:xxxxxxx]]
function! fungo#21() abort
  let str = fungo#util#englad_text(g:fungo_jawiki_path)
  call substitute(str, '\(^\|\n\)\zs[^\n]\{-\}\[Category:.\+\][^\n]\{-\}\ze\(\n\|$\)', {m -> execute('echo m[0]', "")}, 'g')
endfunction

" [[Category:xxxxxxx]] の xxxxxxxだけ
function! fungo#22() abort
  let str = fungo#util#englad_text(g:fungo_jawiki_path)
  call substitute(str, '\[\[Category:\(.\{-\}\)\ze\]\]', {m -> execute('echo m[1]', "")}, 'g')
endfunction

" \n====xxxxx====\n
" "== セクション名 ==" ならレベル2(?)にする(問題がおかしい？)
function! fungo#23() abort
  let str = fungo#util#englad_text(s:jawiki_file_path)
  call substitute(str, '\n\zs\(=\+\)\([^=]\+\)\(=\+\)\ze\n', {m -> execute('echo "レベル:" . len(m[1]) m[2]', "")}, 'g')
endfunction

" メディアフィアル is 何？
" [[ファイル:Wikipedia-logo-v2-ja.png|thumb|説明文]]
" https://ja.wikipedia.org/wiki/Help:%E6%97%A9%E8%A6%8B%E8%A1%A8
" https://qiita.com/segavvy/items/03b97eb6a39f5ae6aa34
function! fungo#24() abort
  let str = fungo#util#englad_text(g:fungo_jawiki_path)
  call substitute(str, '\[\[\(file\|ファイル\):\zs\([^|]\{-\}\)\ze|', {m -> execute('echo m[0]', '')}, 'g')
endfunction

function! fungo#25() abort
  let s:n = 0
  let s:a = []
  let s:d = {}
  let str = fungo#util#englad_text(g:fungo_jawiki_path)
  call substitute(str, '\n{{\s*基礎情報.\{-\}\n\zs.\{-\}\ze\n}}', {m -> substitute(m[0], '\(\n\|^\)|\zs.\{-\}\ze\(\n|\|$\)', {m2 -> substitute(m2[0], '^\(.\{-\}\)\s\+=\s\+\(.\+\)\s*$', {m3 -> execute('call add(s:a, m3[1]) | let s:d[m3[1]] = m3[2] | let s:n += 1', '')}, 'g')}, 'g')}, 'g')
  for k in s:a
    echo '-------'
    echo 'key: ' k
    echo 'value: ' s:d[k]
  endfor
endfunction

function! fungo#all() abort
  let i = 1
  while 1
    if exists('*fungo#' . i)
      echo '-- No.' . i . ' --'
      try
        call fungo#{i}()
      catch /^Vim\%((\a\+)\)\=:E119\>/
        echo 'skip fungo#' . i
      endtry

      echo ' '
    else
      if i != 8
        break
      endif
    endif

    let i += 1
  endwhile
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
