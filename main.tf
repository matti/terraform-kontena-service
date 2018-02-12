resource "null_resource" "start" {
  provisioner "local-exec" {
    command = "echo depends_id=${var.depends_id}"
  }
}

resource "null_resource" "kontena_service" {
  depends_on = ["null_resource.start"]

  provisioner "local-exec" {
    command = <<EOF
kontena service create ${var.name} ${var.image}
EOF
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "kontena service rm --force ${var.name}"
  }
}

resource "null_resource" "kontena_service_update" {
  depends_on = ["null_resource.kontena_service"]

  triggers = {
    cpus      = "${var.cpus}"
    image     = "${var.image}"
    instances = "${var.instances}"
  }

  provisioner "local-exec" {
    command = <<EOF
kontena service update \
${var.image == "" ? "" : "--image ${var.image}"} \
${var.cpus == "" ? "" : "--cpus ${var.cpus}"} \
${var.instances == "" ? "" : "--instances ${var.instances}"} \
${var.name}
EOF
  }
}
