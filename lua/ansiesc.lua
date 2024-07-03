local buflines = require("infra.buflines")
local bufopen = require("infra.bufopen")
local Ephemeral = require("infra.Ephemeral")
local jelly = require("infra.jellyfish")("ansiesc", "debug")
local ni = require("infra.ni")

---@param name_or_nr string|integer @bufnr or file name
---@param open_mode infra.bufopen.Mode
---@return integer winid
---@return integer bufnr
return function(name_or_nr, open_mode)
  local function namefn(bufnr) return string.format("ansi://%s/%s", name_or_nr, bufnr) end
  local bufnr = Ephemeral({ namefn = namefn, modifiable = false, bufhidden = "hide" })

  do
    local tid = ni.open_term(bufnr, {})

    --todo: it's a bug?
    -- ni.create_autocmd("bufwipeout", { buffer = bufnr, once = true, callback = function() jelly.debug("bufwipeout") end })

    ni.create_autocmd("bufhidden", {
      buffer = bufnr,
      once = true,
      callback = function()
        vim.schedule(function()
          vim.fn.chanclose(tid)
          ni.buf_delete(bufnr, { force = false })
        end)
      end,
    })

    local lines
    if type(name_or_nr) == "number" then
      lines = buflines.iter(name_or_nr)
    elseif type(name_or_nr) == "string" then
      lines = io.lines(name_or_nr, "*l")
    else
      error("unreaachable")
    end

    for line in lines do
      vim.fn.chansend(tid, line)
      vim.fn.chansend(tid, "\n")
    end
  end

  local winid = bufopen(open_mode, bufnr)

  return winid, bufnr
end

