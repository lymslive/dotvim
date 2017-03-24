#! /bash/bin
# run vim-note, open two windows automatically

exec vim-note -c ":NoteList -T" -c ":wincmd v" -c ":NoteEdit"
