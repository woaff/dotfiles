require("git"):setup()

-- cross instance yank
require("session"):setup {
	sync_yanked = true,
}
