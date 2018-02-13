resource "null_resource" "start" {
  provisioner "local-exec" {
    command = "echo depends_id=${var.depends_id}"
  }
}

# create only:
#     --read-only                   Read-only root fs for the container (default: false)
#     --stateful                    Set service as stateful (default: false)
#     -v, --volume VOLUME           Add a volume or bind mount it from the host
#     --volumes-from VOLUMES_FROM   Mount volumes from another container

locals {
  volumes_or_none = "${length(var.volumes) == 0 ?
    ""
    :
    "${join(" ", formatlist("--volume %s", var.volumes))}"
    }"
}

locals {
  volume_froms_or_none = "${length(var.volume_froms) == 0 ?
    ""
    :
    "${join(" ", formatlist("--volume-from %s", var.volume_froms))}"
    }"
}

resource "null_resource" "kontena_service" {
  depends_on = ["null_resource.start"]

  provisioner "local-exec" {
    command = <<EOF
kontena service create \
${var.read_only == "" ? "" : "--read-only"} \
${var.stateful == "" ? "" : "--stateful"} \
${local.volumes_or_none} \
${local.volume_froms_or_none} \
${var.name} ${var.image}
EOF
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "kontena service rm --force ${var.name}"
  }
}

# update only:

locals {
  privileged_or_none = "${var.privileged == true ?
    "--privileged"
  :
    ""
  }"
}

locals {
  ports_or_none = "${length(var.ports) == 0 ?
    ""
    :
    "${join(" ", formatlist("--ports %s", var.ports))}"
    }"

  envs_or_none = "${length(var.envs) == 0 ?
    ""
    :
    "${join(" ", formatlist("--env %s", var.envs))}"
    }"

  links_or_none = "${length(var.links) == 0 ?
    ""
    :
    "${join(" ", formatlist("--link %s", var.links))}"
    }"

  affinities_or_none = "${length(var.affinities) == 0 ?
    ""
    :
    "${join(" ", formatlist("--affinity %s", var.affinities))}"
    }"

  cap_adds_or_none = "${length(var.cap_adds) == 0 ?
    ""
    :
    "${join(" ", formatlist("--cap-add %s", var.cap_adds))}"
    }"

  cap_drops_or_none = "${length(var.cap_drops) == 0 ?
    ""
    :
    "${join(" ", formatlist("--cap-drop %s", var.cap_drops))}"
    }"

  log_opts_or_none = "${length(var.log_opts) == 0 ?
    ""
    :
    "${join(" ", formatlist("--log-opt %s", var.log_opts))}"
    }"

  secrets_or_none = "${length(var.secrets) == 0 ?
    ""
    :
    "${join(" ", formatlist("--log-opt %s", var.secrets))}"
    }"
}

resource "null_resource" "kontena_service_update" {
  depends_on = ["null_resource.kontena_service"]

  triggers = {
    image                      = "${var.image}"
    ports                      = "${join(",", var.ports)}"
    envs                       = "${join(",", var.envs)}"
    links                      = "${join(",", var.links)}"
    affinities                 = "${join(",", var.affinities)}"
    cpus                       = "${var.cpus}"
    cpu_shares                 = "${var.cpu_shares}"
    memory                     = "${var.memory}"
    memory_swap                = "${var.memory_swap}"
    shm_size                   = "${var.shm_size}"
    cmd                        = "${var.cmd}"
    instances                  = "${var.instances}"
    user                       = "${var.user}"
    privileged                 = "${var.privileged}"
    cap_adds                   = "${join(",", var.cap_adds)}"
    cap_drops                  = "${join(",", var.cap_drops)}"
    net                        = "${var.net}"
    log_driver                 = "${var.log_driver}"
    log_opts                   = "${join(",", var.log_opts)}"
    deploy_strategy            = "${var.deploy_strategy}"
    deploy_wait_for_port       = "${var.deploy_wait_for_port}"
    deploy_min_health          = "${var.deploy_min_health}"
    deploy_interval            = "${var.deploy_interval}"
    pid                        = "${var.pid}"
    secrets                    = "${join(",", var.secrets)}"
    health_check_uri           = "${var.health_check_uri}"
    health_check_timeout       = "${var.health_check_timeout}"
    health_check_interval      = "${var.health_check_interval}"
    health_check_initial_delay = "${var.health_check_initial_delay}"
    health_check_port          = "${var.health_check_port}"
    health_check_protocol      = "${var.health_check_protocol}"
    stop_signal                = "${var.stop_signal}"
    stop_timeout               = "${var.stop_timeout}"
  }

  provisioner "local-exec" {
    command = <<EOF
kontena service update \
${var.image == "" ? "" : "--image ${var.image}"} \
${local.ports_or_none} \
${local.envs_or_none} \
${local.links_or_none} \
${local.affinities_or_none} \
${var.cpus == "" ? "" : "--cpus ${var.cpus}"} \
${var.cpu_shares == "" ? "" : "--cpu-shares ${var.cpu_shares}"} \
${var.memory == "" ? "" : "--memory ${var.memory}"} \
${var.memory_swap == "" ? "" : "--memory-swap ${var.memory_swap}"} \
${var.shm_size == "" ? "" : "--shm-size ${var.shm_size}"} \
${var.cmd == "" ? "" : "--cmd ${var.cmd}"} \
${var.instances == "" ? "" : "--instances ${var.instances}"} \
${var.user == "" ? "" : "--user ${var.user}"} \
${local.privileged_or_none} \
${local.cap_adds_or_none} \
${local.cap_drops_or_none} \
${var.net == "" ? "" : "--net ${var.net}"} \
${var.log_driver == "" ? "" : "--log-driver ${var.log_driver}"} \
${local.log_opts_or_none} \
${var.deploy_strategy == "" ? "" : "--deploy-strategy ${var.deploy_strategy}"} \
${var.deploy_wait_for_port == "" ? "" : "--deploy-wait-for-port ${var.deploy_wait_for_port}"} \
${var.deploy_min_health == "" ? "" : "--deploy-min-health ${var.deploy_min_health}"} \
${var.deploy_interval == "" ? "" : "--deploy-interval ${var.deploy_interval}"} \
${var.pid == "" ? "" : "--pid ${var.pid}"} \
${local.secrets_or_none} \
${var.health_check_uri == "" ? "" : "--health-check-uri ${var.health_check_uri}"} \
${var.health_check_timeout == "" ? "" : "--health-check-timeout ${var.health_check_timeout}"} \
${var.health_check_interval == "" ? "" : "--health-check-interval ${var.health_check_interval}"} \
${var.health_check_initial_delay == "" ? "" : "--health-check-initial-delay ${var.health_check_initial_delay}"} \
${var.health_check_port == "" ? "" : "--health-check-port ${var.health_check_port}"} \
${var.health_check_protocol == "" ? "" : "--health-check-protocol ${var.health_check_protocol}"} \
${var.stop_signal == "" ? "" : "--stop-signal ${var.stop_signal}"} \
${var.stop_timeout == "" ? "" : "--stop-timeout ${var.stop_timeout}"} \
${var.name}
EOF
  }
}
