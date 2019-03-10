" https://programming-place.net/ppp/contents/algorithm/other/002.html
" https://vim-jp.org/vim-users-jp/2009/11/05/Hack-98.html
" specified String or List
scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! fungo#util#shuffle(obj) abort
  if type(a:obj) == v:t_string
    return join(fungo#util#shuffle_list(split(a:obj, '\zs')), '')
  else
    let len = len(a:obj)
    for i in range(len)
      let i1 = len - i - 1
      let v1 = a:obj[i1]

      let t = reltimestr(reltime())
      let i2 = t[matchend(t, '\d\+\.'):] % (len - i)
      let v2 = a:obj[i2]

      let a:obj[i1] = v2
      let a:obj[i2] = v1
    endfor
    return a:obj
  endif
endfunction

function! fungo#util#zip(list1, list2) abort
  let len1 = len(a:list1)
  let len2 = len(a:list2)
  let ret = []
  for i in range(len1 >= len2 ? len1 : len2)
    call add(ret, (len1 > i ? [a:list1[i]] : []) + (len2 > i ? [a:list2[i]] : []))
  endfor
  return ret
endfunction

function! fungo#util#conv_utf8(str) abort
  return iconv(a:str, &encoding, 'utf-8')
endfunction

function! fungo#util#conv_my_enc(str) abort
  return iconv(a:str, 'utf-8', &encoding)
endfunction

function! fungo#util#each_slice(list, num) abort
  let ret = []
  if 0 == a:num
    return []
  endif

  let roop_count = len(a:list) / a:num + (len(a:list) % a:num == 0 ? 0 : 1)
  for i in range(roop_count)
    call add(ret, a:list[i * a:num : i * a:num + a:num - 1])
  endfor
  return ret
endfunction

function! fungo#util#englad_text(path) abort
  let rows = readfile(a:path)
  for i in range(len(rows))
    if json_decode(rows[i])['title'] == 'イギリス'
      return json_decode(rows[i])['text']
    endif
  endfor
  return 'none'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
