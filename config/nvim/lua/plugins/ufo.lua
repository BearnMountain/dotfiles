return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async'
  },
  config = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.foldmethod = 'manual'

    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
    })

    -- Key mappings for folding
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, {desc = 'Open all folds'})
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, {desc = 'Close all folds'})
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, {desc = 'Open folds except kinds'})
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, {desc = 'Close folds with'})
    
    -- Use za to toggle fold under cursor (standard vim keybind, should work)
    -- Use zc to close fold under cursor
    -- Use zo to open fold under cursor
  end
}
