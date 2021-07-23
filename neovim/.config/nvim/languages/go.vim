" Vim-Go Settings {{{
" these go_highlight could massively slow it down... all enabled for now for
" kicks, but disable if deemed useless
let g:go_highlight_build_constraints = 1
let g:go_highlight_diagnostic_errors = 1 
let g:go_highlight_diagnostic_warnings = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_def_mapping_enabled = 0
let g:go_auto_sameids = 0
"let g:go_gopls_enabled = 0
let g:go_auto_type_info = 0
let g:go_code_completion_enabled = 0
let g:go_fmt_command = "goimports"
" }}}

let g:which_key_map.g['ie'] = "GoIfErr"
let g:which_key_map.g['ct'] = "GoCoverageToggle"
let g:which_key_map.g['at'] = "GoAddTags"
let g:which_key_map.g['dc'] = "GoDecls"
let g:which_key_map.g['dd'] = "GoDeclsDir"
let g:which_key_map.g['fs'] = "GoFillStruct"
let g:which_key_map.g['cl'] = "GoCallees"
let g:which_key_map.g['gd'] = "GoDoc"
let g:which_key_map.g['aa'] = "GoAlternate"
let g:which_key_map.g['vs'] = "VSplit Alternate"
let g:which_key_map.g['hs'] = "Split Alternate"
let g:which_key_map.g['ts'] = "Tab Alternate"
let g:which_key_map.g['im'] = "GoImplements"
let g:which_key_map.g['ut'] = "GoTest"

function! s:load_go_settings()
	" Go debug stuff {{{
	nnoremap <leader>dt :GoDebugTest<CR>
	nnoremap <leader>df :GoDebugTestFunc<CR>
	nnoremap <leader>dt :GoDebugStart<CR>
	nnoremap <leader>db :GoDebugBreakpoint<CR>
	nnoremap <leader>dc :GoDebugContinue<CR>
	nnoremap <leader>dh :GoDebugHalt<CR>
	nnoremap <leader>dn :GoDebugNext<CR>
	nnoremap <leader>dr :GoDebugRestart<CR>
	nnoremap <leader>ds :GoDebugStep<CR>
	nnoremap <leader>do :GoDebugStepOut<CR>
	nnoremap <leader>dx :GoDebugStop<CR>
	" }}} 

	" Custom go remappings {{{
	noremap <leader>gim :GoImplements<CR>
	noremap <leader>gut :GoTest<CR>
	noremap <leader>gie :GoIfErr<CR>
	noremap <leader>gct :GoCoverageToggle<CR>
	noremap <leader>gat :GoAddTags<CR>
	noremap <leader>gdc :GoDecls<CR>
	noremap <leader><leader>gdd :GoDeclsDir<CR>
	noremap <leader>gfs :GoFillStruct<CR>
	noremap <leader>gcl :GoCallees<CR>
	noremap <leader>ggd :GoDoc<CR>
	noremap <leader>gaa :GoAlternate<CR>
	noremap <leader>gvs :vsplit<CR> :GoAlternate<CR>
	noremap <leader>ghs :split<CR> :GoAlternate<CR>
	noremap <leader>gts :tab split<CR> :GoAlternate<CR>
	" }}}
endfunction

autocmd FileType go call s:load_go_settings()
