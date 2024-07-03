render ansi esc sequences


## impl, limits, design choices
* it simply reads from the source (either a buffer nor a file),
  then sends the contents to a terminal buffer and show it
* it wont delete the source bufnr
* as it's a terminal buffer, it has limits:
    * terminal mode instead insert mode
    * not responsible to user input
    * not modifiable by default
    * limited scrollback
    * no undo history

## status
* just works

## prerequisites
* nvim 0.10.*
* haolian9/infra.nvim

## usage
here is my personal config
```
usercmd("AnsiEsc", function() require("ansiesc")(ni.get_current_buf(), "inplace") end)
```

## credits
thanks to AnsiEsc.vim, which i have used for a long time.
