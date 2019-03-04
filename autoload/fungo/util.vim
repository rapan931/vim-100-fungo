" https://programming-place.net/ppp/contents/algorithm/other/002.html
" https://vim-jp.org/vim-users-jp/2009/11/05/Hack-98.html
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

