-- require('lualine').setup({options = {theme = "everforest"}})
local colors = {
  red = "#ca1243",
  grey = "#a0a1a7",
  black = "#383a42",
  white = "#f3f3f3",
  light_green = "#83a598",
  orange = "#fe8019",
  green = "#8ec07c",
}

-- local theme = {
-- 	normal = {
-- 		a = { fg = colors.black, bg = colors.green },
-- 		b = { fg = colors.black, bg = colors.grey },
-- 		c = { fg = colors.black, bg = colors.black },
-- 		z = { fg = colors.black, bg = colors.light_green },
-- 	},
-- 	insert = { a = { fg = colors.black, bg = colors.light_green } },
-- 	visual = { a = { fg = colors.black, bg = colors.orange } },
-- 	replace = { a = { fg = colors.black, bg = colors.green } },
-- }

local empty = require("lualine.component"):extend()
function empty:draw(default_highlight)
  self.status = ""
  self.applied_separator = ""
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < "x"
    for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.black } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= "table" then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = "" } or { left = "" }
    end
  end
  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local last_search = vim.fn.getreg("/")
  if not last_search or last_search == "" then
    return ""
  end
  local searchcount = vim.fn.searchcount({ maxcount = 9999 })
  return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
end

local function modified()
  if vim.bo.modified then
    return "+"
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return "-"
  end
  return ""
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = process_sections({
      lualine_a = { {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
      } },
      lualine_b = {
        "branch",
        "diff",
        {
          "diagnostics",
          source = { "nvim" },
          sections = { "error" },
          diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
        },
        {
          "diagnostics",
          source = { "nvim" },
          sections = { "warn" },
          diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
        },
        { "filename", file_status = false,        path = 1 },
        { modified,   color = { bg = colors.red } },
        {
          "%w",
          cond = function()
            return vim.wo.previewwindow
          end,
        },
        {
          "%r",
          cond = function()
            return vim.bo.readonly
          end,
        },
        {
          "%q",
          cond = function()
            return vim.bo.buftype == "quickfix"
          end,
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { search_result, "filetype" },
      lualine_z = { "%l:%c", "%p%%/%L" },
    }),
    inactive_sections = {
      lualine_c = { "%f %y %m" },
      lualine_x = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
}
