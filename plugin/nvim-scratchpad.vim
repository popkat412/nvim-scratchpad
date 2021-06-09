if exists('g:loaded_nvim_scratchpad') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" command to run our plugin
command! -nargs=1  Scratchpad lua require 'nvim-scratchpad'.scratchpad(<q-args>)
command! -nargs=1 Scratch Scratchpad <args>

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_nvim_scratchpad = 1
