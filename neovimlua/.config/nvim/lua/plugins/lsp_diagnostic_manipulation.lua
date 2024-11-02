return {
    "m-gail/diagnostic_manipulation.nvim",
    init = function ()
        require("diagnostic_manipulation").setup {
            blacklist = {
              function(diagnostic)
                  return string.find(diagnostic.message, "'require' call may be converted to an import.")
              end
            },
            whitelist = {
                -- Your whitelist here
            }
        }
    end
}
