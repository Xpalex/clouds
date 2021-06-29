#---------------------------------------------------------------
# provider.tf
#---------------------------------------------------------------
  variable "subscription_id" {} 
  variable "client_id"       {}
  variable "client_secret"   {}   
  variable "tenant_id"       {}   

#---------------------------------------------------------------
# instance.tf
#---------------------------------------------------------------
variable "instance_username" {
  default   = "remote_user"
}
#---------------------------------------------------------------
# Keys
#---------------------------------------------------------------
variable "private_key" {
  default   = "azure_key"
}
variable "public_key" {
  default   = "azure_key.pub"
}
variable "private_key_ans_ins" {
  default   = "ans_ins_key"
}
variable "public_key_ans_ins" {
  default   = "ans_ins_key.pub"
}
variable "private_ip_addresses" {
  default = [
    "10.0.1.7",
    "10.0.1.5",
    "10.0.1.6",
  ]
}
variable "name_vm" {
  default = [
    "ansible",
    "jenkins",
    "docker",
  ]
}
variable "prefix" {
  default = "tfvmex"
}
    