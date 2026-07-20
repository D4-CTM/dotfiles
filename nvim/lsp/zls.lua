---@brief
--- https://github.com/zigtools/zls
---
--- Zig LSP implementation + Zig Language Server

return {
	cmd = { 'zls' },
	filetypes = { 'zig', 'zir' },
	root_markers = { 'zls.json', 'build.zig', '.git' },
	workspace_required = false,
	zls = {
		enable_snippets = true,
		enable_inlay_hints = true,
		include_dirs = {
			"/usr/include",
			"/usr/local/include",
		},
		clang_path = "/usr/bin/clang",
	},
	on_attach = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end,
}
