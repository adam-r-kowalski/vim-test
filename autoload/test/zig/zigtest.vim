if !exists('g:test#zig#zigtest#file_pattern')
  let g:test#zig#zigtest#file_pattern = '\v\.zig$'
endif

" Returns true if the given file belongs to your test runner
function! test#zig#zigtest#test_file(file) abort
  return a:file =~# g:test#zig#zigtest#file_pattern
endfunction

" Returns test runner's arguments which will run the current file and/or line
function! test#zig#zigtest#build_position(type, position)
  if a:type ==# 'nearest'
    let name = s:nearest_test(a:position)
    if !empty(name)
      return [a:position['file'], '--test-filter', name]
    else
      return [a:position['file']]
    end
  elseif a:type ==# 'file'
    return [a:position['file']]
  endif
  return []
endfunction

" Returns processed args (if you need to do any processing)
function! test#zig#zigtest#build_args(args)
  return a:args
endfunction

" Returns the executable of your test runner
function! test#zig#zigtest#executable()
  return 'zig test'
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#zig#patterns)
  return join(name['test'])
endfunction
