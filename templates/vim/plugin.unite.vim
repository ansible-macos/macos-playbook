"
" Desc: Settings for Unite plugin
" Link: https://github.com/Shougo/unite.vim
"

"
" Option: Filter vcs ignores by default
" Link:   https://github.com/ggreer/the_silver_searcher
" Notes:  To search ignoring VCS ingoring files use --skip-vcs-ignores
"
let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore ".tmp" --ignore ".hg" --ignore ".svn" --ignore ".git" --ignore ".bzr" --hidden -g ""'

"
" Desc: Map command for file search with fuzzyfinder style by default it
" searchs only if not present in .gitignore
"
noremap <Leader>0 :Unite -start-insert file_rec/async:!<CR>
noremap <Leader>9 :Unite -start-insert<CR>
