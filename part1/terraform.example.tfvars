aws_profile          = "XXXXX"
aws_region           = "XXXXX"
ami                  = "ami-0badcc5b522737046"
instance_type        = "t2.micro"
ansible_control_name = "ansible-controller"
ansible_nodes_name = [
  "ansible-node01",
  "ansible-node02",
  "ansible-node03"
]
environment_type = [
  "staging",
  "prod"
]
key_name = "ansible_lab_key_pair"