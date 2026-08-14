require("java").setup({
	checks = {
		nvim_version = false,
		nvim_jdtls_conflict = false,
	},

	log = {
		use_file = false,
		log_file = "/dev/null",
	},

	jdtls = {
		path = vim.fn.exepath("jdtls"),
		auto_install = false,
	},

	jdk = {
		path = vim.uv.os_getenv("JAVA_HOME"),
		auto_install = false,
	},

	java_debug_adapter = {
		enable = false,
	},

	java_test = {
		auto_install = false,
	},

	lombok = {
		path = vim.uv.os_getenv("LOMBOK_JAR"),
		auto_install = false,
	},

	spring_boot_tools = {
		path = vim.uv.os_getenv("SPRING_BOOT_VSIX"),
		auto_install = false,
	},
})
