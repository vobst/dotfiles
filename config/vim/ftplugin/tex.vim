" Configuration of VimTeX plugin
" :help vimtex-options
" :help vimtex-default-mappings
"  keyboard shortcuts for commands and actions, <Ctrl>] to get info
"   or :help vimtex-commands or :help vimtex-mappings
"  [cdt]s[ecd$f] surroundings
"  ]] [[ [] ][ ]m [m [n ]n movement
"  extra text objects
"   [ai][cde$Pm]
" :help vimtex-commands
"   compilation, viewer, ect.
" :help vimtex-completion
"   autocompletion of citations, labels
"   :h vimtex-completion-cites
"    You just need to type \cite{ and then press
"    <C-X><C-O>
" :help vimtex-toc
"   navigate document via toc
" :help vimtex-compiler

if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif

let g:vimtex_imaps_enabled = 0
let g:vimtex_format_enabled = 0

" Don't open QuickFix for warning messages if no errors are present
let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_delim_toggle_mod_list = [
  \ ['\left', '\right'],
  \ ['\big', '\big'],
  \]

let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-lualatex',
    \ 'pdfdvi'           : '-pdfdvi',
    \ 'pdfps'            : '-pdfps',
    \ 'pdflatex'         : '-pdf',
    \ 'luatex'           : '-lualatex',
    \ 'lualatex'         : '-lualatex',
    \ 'xelatex'          : '-xelatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
    \}

noremap <leader>wc <Cmd>VimtexCountWords<CR>

" Use Zathura as the VimTeX PDF viewer
let g:vimtex_view_method = 'zathura'

" Return focus to Vim after forward search
" Get Vim's window ID for switching focus from Zathura to Vim using xdotool.
" Only set this variable once for the current Vim instance.
if !exists("g:vim_window_id")
  let g:vim_window_id = system("xdotool getactivewindow")
endif

function! s:TexFocusVim() abort
  " Give window manager time to recognize focus moved to Zathura;
  " tweak the 200m as needed for your hardware and window manager.
  sleep 200m
  " Refocus Vim and redraw the screen
  silent execute "!xdotool windowfocus " . expand(g:vim_window_id)
redraw!
endfunction

" runs the above-defined refocus function s:TexFocusVim() in response to the
" VimTeX event VimtexEventView, which triggers whenever VimtexView completes
augroup vimtex_event_focus
  au!
  au User VimtexEventView call s:TexFocusVim()
augroup END
