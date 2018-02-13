variable "depends_id" {
  default = ""
}

variable "name" {}
variable "image" {}

# create
variable "stateful" {
  default = ""
}

variable "read_only" {
  default = ""
}

variable "volumes" {
  default = []
}

variable "volume_froms" {
  default = []
}

# update
variable "ports" {
  default = []
}

variable "envs" {
  default = []
}

variable "links" {
  default = []
}

variable "affinities" {
  default = []
}

variable "cpus" {
  default = ""
}

variable "cpu_shares" {
  default = ""
}

variable "memory" {
  default = ""
}

variable "memory_swap" {
  default = ""
}

variable "shm_size" {
  default = ""
}

variable "cmd" {
  default = ""
}

variable "instances" {
  default = "1"
}

variable "user" {
  default = ""
}

variable "privileged" {
  default = false
}

variable "cap_adds" {
  default = []
}

variable "cap_drops" {
  default = []
}

variable "net" {
  default = ""
}

variable "log_driver" {
  default = ""
}

variable "log_opts" {
  default = []
}

variable "deploy_strategy" {
  default = ""
}

variable "deploy_wait_for_port" {
  default = ""
}

variable "deploy_min_health" {
  default = ""
}

variable "deploy_interval" {
  default = ""
}

variable "pid" {
  default = ""
}

variable "secrets" {
  default = []
}

variable "health_check_uri" {
  default = ""
}

variable "health_check_timeout" {
  default = ""
}

variable "health_check_interval" {
  default = ""
}

variable "health_check_initial_delay" {
  default = ""
}

variable "health_check_port" {
  default = ""
}

variable "health_check_protocol" {
  default = ""
}

variable "stop_signal" {
  default = ""
}

variable "stop_timeout" {
  default = ""
}
