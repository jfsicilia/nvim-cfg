-- Smart abbreviations, substitutions and coercions (tpope/vim-abolish): e.g. :S/foo/bar/
-- preserves case, and cr<letter> (crs, crm, crc, cr_, cru...) converts the word under the
-- cursor between snake_case/camelCase/MixedCase/etc.
-- Keybinds: none defined here; uses the plugin's own coercion defaults (cr + a letter, over
-- the word under the cursor):
--   crs   snake_case
--   crm   MixedCase
--   crc   camelCase
--   cr_   snake_case (alias of crs)
--   cru   UPPER_CASE
return {
  {
    'tpope/vim-abolish',
    event = 'BufReadPost', -- Only load when file is loaded.
  },
}
