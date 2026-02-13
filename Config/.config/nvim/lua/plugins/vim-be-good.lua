return{
  {
    "thePrimeagen/vim-be-good",
    lazy = false,
    cmd = "VimBeGood",
    config = function()
      require("VimBeGood").setup {}
    end,
  },
}
