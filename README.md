# Terraform criando VM (IaaS) no GCP

Pré-requisitos

- gcloud instalado
- Terraform instalado

Logar no GCP usando gcloud com o comando abaixo

```sh
gcloud auth application-default login
```

Gerar chave pública e privada para acessar a VM, com nome "id_rsa" na raiz do projeto

```sh
ssh-keygen -t rsa -b 4096
```

Inicializar o Terraform

```sh
terraform init
```

Executar o Terraform

```sh
terraform apply -auto-approve
```
