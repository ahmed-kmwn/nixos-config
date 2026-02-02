{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim.clipboard = {
        enable = true;
        registers = "unnamedplus";
      };

      vim = {
        options = {
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          smartindent = true;
          number = true;
          relativenumber = true;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
        };

        languages = {
          haskell.enable = true;
          nix.enable = true;
        };

        autocomplete.nvim-cmp.enable = true;

        visuals = {
          fidget-nvim.enable = true;
          nvim-web-devicons.enable = true;
          indent-blankline.enable = true;
        };

        theme = {
          enable = true;
          name = "tokyonight";
          style = "storm";
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        ui.noice.enable = true;
        filetree.nvimTree.enable = true;
        binds.whichKey.enable = true;
      };
    };
  };
}
