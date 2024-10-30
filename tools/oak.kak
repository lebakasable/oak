hook global BufCreate .*[.](oak) %{
   set-option buffer filetype oak
}

hook global WinSetOption filetype=oak %{
   require-module oak
   hook -once -always window WinSetOption filetype=.* %{ remove-hooks window oak-.+ }
}

hook -group oak-highlight global WinSetOption filetype=oak %{
   add-highlighter window/oak ref oak
   hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/oak }
}

provide-module oak %{
   add-highlighter shared/oak regions
   add-highlighter shared/oak/code default-region group
   add-highlighter shared/oak/code/function regex \b(\w+)\h*(?:\() 1:function
   add-highlighter shared/oak/code/keyword regex \b(if|else|for|match|break|return|sizeof|assert|as|use|fn|let|const|alias|struct|print)\b 0:keyword
   add-highlighter shared/oak/code/builtin_type regex \b(char|int|bool)\b 0:type
   add-highlighter shared/oak/code/type regex \b([A-Z_][\w\d]*)\b 0:type
   add-highlighter shared/oak/code/builtin_constant regex \b(true|false)\b 0:value
   add-highlighter shared/oak/code/constant regex \b([A-Z_][A-Z_\d]*)\b 0:value
   add-highlighter shared/oak/code/number regex \b(\d+)\b 0:value
   add-highlighter shared/oak/code/char regex %{'((\\.)|[^'\\])'} 0:value
   add-highlighter shared/oak/string region %{(?<!')(?<!'\\\\)"} %{(?<!\\)(?:\\\\)*"} fill string
   add-highlighter shared/oak/comment region '##' '##' fill comment
   add-highlighter shared/oak/line_comment region '#' '$' fill comment
}
