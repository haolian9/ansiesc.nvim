render ansi esc sequences

https://github.com/haolian9/zongzi/assets/6236829/1f3f82b3-018c-4b3d-aac3-aebbc38754df


## impl, limits, design choices
* it simply reads given source (a buffer or a file), then sends content to a terminal buffer
* it wont replace/delete the source bufnr
* as being a terminal buffer, it inherits limits:
    * terminal mode instead insert mode
    * no responsing user inputs
    * not modifiable by default
    * limited scrollback
    * no undo history
* it wont be updated as source buffer changing

## status
* just works

## prerequisites
* nvim 0.11.*
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
