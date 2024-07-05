render ansi esc sequences

https://github.com/haolian9/zongzi/assets/6236829/1f3f82b3-018c-4b3d-aac3-aebbc38754df


## impl, limits, design choices
* it simply reads from the source (a buffer or a file), 
  and sends the contents to a terminal buffer
* it wont delete the source bufnr
* as it's a terminal buffer, it inherits limits:
    * terminal mode instead insert mode
    * no responsing user inputs
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
do --:AnsiEsc
  local spell = cmds.Spell("AnsiEsc", function(args) require("ansiesc")(0, args.open_mode) end)
  spell:add_arg("open_mode", "string", false, "inplace", cmds.ArgComp.constant({ "inplace", "left", "right", "above", "below", "tab" }))
  cmds.cast(spell)
end
```

## credits
thanks to AnsiEsc.vim, which i had used for a long time.
