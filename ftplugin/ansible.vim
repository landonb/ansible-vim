" 2020-02-08: On rebase upstream/master, the 'regexpengine' 'slow yaml workaround'
" was removed, so the file is now just the two lines:
"
"  set isfname+=@-@
"  set path+=./../templates,./../files,templates,files
"
" but see reasoning below (in original comment from a little over a year ago)
" for why these 2 lines are disabled in Dubs Vim.

" ***

" [lb]: Slow yaml highlighting workaround!
"
" Upstream code:
"
"   if exists('+regexpengine') && ('&regexpengine' == 0)
"     setlocal regexpengine=1
"   endif
"
" But I think there's a typo! Why is &regexpengine quoted??
" It should really be:
"
"   if exists('+regexpengine') && (&regexpengine == 0)
"
" Also, regexpengine is global! Meaning, even if I have other
" filetype plugins set it back to 0, when reST loads, it sources
" syntax plugins, and regexpengine gets set to 1 ("old engine"),
" which is too slow, and reST timesout while parsing, so nothing
" is highlighted.
"
" So do not regress the regex engine.
"
" WATCH/2018-12-17: Be aware of this change, in case Yaml parsing breaks.

" [lb]: Do not add '@' as a legal filename character.
" FIXME/2018-12-17: At least not now; I'm concerned
" it'll mess up something else... though not sure
" what.
"
" WATCH/2018-12-17: Be aware of this change, in case Yaml parsing breaks.
"
" Upstream code:
"
"   " Add '@' as legal filename character.
"   set isfname+=@-@

" [lb]: Do not update the path. Once any ansible file is loaded, this'll
" apply for the rest of the Vim session, which feels kinda weird. I also
" don't rely on Vim's path- think ripgrep and dubs_grep_steady plugin, I
" got my own way of doing things.
"
" Upstream code:
"
"   set path+=./../templates,./../files,templates,files

set indentexpr=

