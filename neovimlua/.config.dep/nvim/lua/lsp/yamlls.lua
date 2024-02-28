-- since all things are yaml now adays, use this as a list of correct types for kubernetes to attach the buffer on
local acceptableVersions = {
	["certificates.k8s.io/v1beta1"] = { "CertificateSigningRequest" },
	["rbac.authorization.k8s.io/v1"] = { "ClusterRoleBinding", "ClusterRole", "RoleBinding", "Role" },
	["v1"] = {
		"ComponentStatus",
		"ConfigMap",
		"Endpoints",
		"Event",
		"LimitRange",
		"Namespace",
		"Node",
		"PersistentVolumeClaim",
		"PersistentVolume",
		"Pod",
		"PodTemplate",
		"ReplicationController",
		"ResourceQuota",
		"Secret",
		"ServiceAccount",
		"Service",
	},
	["apps/v1"] = { "ControllerRevision", "StatefulSet" },
	["extensions/v1beta1"] = {
		"DaemonSet",
		"Deployment",
		"Ingress",
		"NetworkPolicy",
		"PodSecurityPolicy",
		"ReplicaSet",
	},
	["autoscaling/v1"] = { "HorizontalPodAutoscaler" },
	["batch/v1"] = { "Job" },
	["batch/v1beta1"] = { "CronJob" },
	["policy/v1beta1"] = { "PodDisruptionBudget" },
}

local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

require("lspconfig").yamlls.setup({
	-- don't allow the client to run if it's not a valid k8s version
	--
	-- NOTE: This is a very naiive implementaiton as it requires apiVersion
	-- to be the first entry and kind to be the second.
	on_attach = function(client, buffer)
		local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
		local k = split(lines[1], ": ")[2]
		local kinds = acceptableVersions[k]
		kinds = kinds or {}
		for _, kind in ipairs(kinds) do
			if lines[2] == "kind: " .. kind then
				-- found the right type, don't detach the buffer and let k8s lsp take the wheel.
				return
			end
		end
		vim.lsp.buf_detach_client(buffer, client.id)
	end,
	settings = {
		yaml = {
			schemas = { kubernetes = "/*.yaml" },
			schemaDownload = { enable = true },
			validate = true,
		},
	},
})
