-- ============================================================================
-- ASCII Art Functions - Quick Reference
-- ============================================================================

-- Get random art from any category
local art = require("ascii").get_random_global()

-- Get random art from specific category
local art = require("ascii").get_random("animals", "cats")
local art = require("ascii").get_random("gaming", "doom")
local art = require("ascii").get_random("movies", "starwars")
local art = require("ascii").get_random("computers", "linux")

-- Browse all art interactively
require("ascii").preview()

-- List all categories
require("ascii").print_category()

-- View specific art
require("ascii").print_subcategory("animals", "cats")

-- ============================================================================
-- Available Categories
-- ============================================================================
-- animals: cats, dinosaurs, dogs, lions, pandas
-- anime: onepiece
-- cartoons: futurama, simpsons
-- computers: amiga, apple, atari, consoles, linux
-- gaming: doom, pacman, undertale
-- misc: hydra, krakens, skulls
-- movies: starwars, toystory
-- planets: planets
-- text: doom, neovim, slogons
