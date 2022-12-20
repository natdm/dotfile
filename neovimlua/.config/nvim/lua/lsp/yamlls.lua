-- since all things are yaml now adays, use this as a list of correct types for kubernetes to attach the buffer on
local acceptableVersions = {
	{ ["kind"] = "CertificateSigningRequest", ["apiVersion"] = "certificates.k8s.io/v1beta1" },
	{ ["kind"] = "ClusterRoleBinding", ["apiVersion"] = "rbac.authorization.k8s.io/v1" },
	{ ["kind"] = "ClusterRole", ["apiVersion"] = "rbac.authorization.k8s.io/v1" },
	{ ["kind"] = "ComponentStatus", ["apiVersion"] = "v1" },
	{ ["kind"] = "ConfigMap", ["apiVersion"] = "v1" },
	{ ["kind"] = "ControllerRevision", ["apiVersion"] = "apps/v1" },
	{ ["kind"] = "CronJob", ["apiVersion"] = "batch/v1beta1" },
	{ ["kind"] = "DaemonSet", ["apiVersion"] = "extensions/v1beta1" },
	{ ["kind"] = "Deployment", ["apiVersion"] = "extensions/v1beta1" },
	{ ["kind"] = "Endpoints", ["apiVersion"] = "v1" },
	{ ["kind"] = "Event", ["apiVersion"] = "v1" },
	{ ["kind"] = "HorizontalPodAutoscaler", ["apiVersion"] = "autoscaling/v1" },
	{ ["kind"] = "Ingress", ["apiVersion"] = "extensions/v1beta1" },
	{ ["kind"] = "Job", ["apiVersion"] = "batch/v1" },
	{ ["kind"] = "LimitRange", ["apiVersion"] = "v1" },
	{ ["kind"] = "Namespace", ["apiVersion"] = "v1" },
	{ ["kind"] = "NetworkPolicy", ["apiVersion"] = "extensions/v1beta1" },
	{ ["kind"] = "Node", ["apiVersion"] = "v1" },
	{ ["kind"] = "PersistentVolumeClaim", ["apiVersion"] = "v1" },
	{ ["kind"] = "PersistentVolume", ["apiVersion"] = "v1" },
	{ ["kind"] = "PodDisruptionBudget", ["apiVersion"] = "policy/v1beta1" },
	{ ["kind"] = "Pod", ["apiVersion"] = "v1" },
	{ ["kind"] = "PodSecurityPolicy", ["apiVersion"] = "extensions/v1beta1" },
	{ ["kind"] = "PodTemplate", ["apiVersion"] = "v1" },
	{ ["kind"] = "ReplicaSet", ["apiVersion"] = "extensions/v1beta1" },
	{ ["kind"] = "ReplicationController", ["apiVersion"] = "v1" },
	{ ["kind"] = "ResourceQuota", ["apiVersion"] = "v1" },
	{ ["kind"] = "RoleBinding", ["apiVersion"] = "rbac.authorization.k8s.io/v1" },
	{ ["kind"] = "Role", ["apiVersion"] = "rbac.authorization.k8s.io/v1" },
	{ ["kind"] = "Secret", ["apiVersion"] = "v1" },
	{ ["kind"] = "ServiceAccount", ["apiVersion"] = "v1" },
	{ ["kind"] = "Service", ["apiVersion"] = "v1" },
	{ ["kind"] = "StatefulSet", ["apiVersion"] = "apps/v1" },
}
require("lspconfig").yamlls.setup({
	-- don't allow the client to run if it's not a valid k8s version
	on_attach = function(client, buffer)
		local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
		for _, value in ipairs(acceptableVersions) do
			local isAPIVersion = lines[1] == "apiVersion: " .. value["apiVersion"]
			local isKind = lines[2] == "kind: " .. value["kind"]
			if isAPIVersion and isKind then
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
