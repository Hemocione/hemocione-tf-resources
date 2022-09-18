# hemocione-tf-resources

Este repositório contém os arquivos de configuração para o Terraform que são utilizados para provisionar os recursos necessários para o projeto 

## Como utilizar

Para utilizar este repositório, é necessário ter o Terraform instalado na sua máquina. Para isso, siga as instruções de instalação disponíveis no site oficial do Terraform.

Após a instalação do Terraform, é necessário configurar as credenciais de acesso à AWS. Para isso, siga as instruções disponíveis no site oficial da AWS.

Após a configuração das credenciais, é necessário clonar este repositório e executar o comando `terraform init` para baixar os plugins necessários para provisionar os recursos.

Após a criação do terraform, recomendamos que executem o comando `terraform plan` para verificar se os recursos serão criados conforme o esperado.

Para criar os recursos, basta executar o comando `terraform apply` na raiz do repositório.

Antes de commitar as alterações, é necessário executar o comando `terraform fmt` para formatar os arquivos de configuração.