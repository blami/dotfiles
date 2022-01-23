-- blami's Lua utilities for Neovim
--
-- This library contains some utility functions and wrappers I use in my
-- Neovim configuration.

local M = {}

-- Utilities
--
-- Single-file utilities that can be either used standalone or in libraries.
M.autofmt   = require('blami.autofmt')
M.prequire  = require('blami.prequire')

-- Libraries
M.lsp       = require('blami.lsp')


return M
