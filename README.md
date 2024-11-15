
# Projeto Terraform: Load Balancer na AWS 🌐
Descrição
Este projeto utiliza o Terraform para provisionar uma infraestrutura de Load Balancer na AWS. O objetivo é distribuir o tráfego de rede entre várias instâncias EC2, garantindo alta disponibilidade e balanceamento de carga. 🚀🚀

# Recursos Criados
O script load-balance.tf configura os seguintes recursos:

# Load Balancer (ALB): 
Configurado para distribuir o tráfego de forma eficiente entre as instâncias.
# Listeners: 
Define as regras para escutar o tráfego HTTP/HTTPS.
# Target Groups: 
Especifica os alvos (instâncias EC2) para onde o tráfego será enviado.
# Regras de Segurança: 
Configuradas para permitir apenas tráfego autorizado.
<br>
Pré-requisitos
Antes de usar este projeto, certifique-se de ter instalado: <br>

Terraform: Versão >= 1.0.0.
Instruções de instalação.
AWS CLI: Configurado com um perfil válido.
Guia de configuração.
Uma conta válida na AWS.
Configuração
Clone o repositório:

bash
Copiar código
git clone https://github.com/jltdsjrdev/projeto-Terraform.git
cd projeto-Terraform
Inicialize o Terraform:

bash
Copiar código
terraform init
Ajuste o arquivo variables.tf com os valores necessários, como:

Região da AWS
IDs das sub-redes
ARNs das instâncias EC2
Valide os arquivos de configuração:

bash
Copiar código
terraform validate
Aplique o plano para provisionar a infraestrutura:

bash
Copiar código
terraform apply

# Estrutura do Repositório
load-balance.tf: Configuração principal do Load Balancer.
variables.tf: Definição de variáveis usadas no projeto.
outputs.tf: Define os valores de saída (ARN do Load Balancer, etc.).
.gitignore: Ignora arquivos sensíveis como terraform.tfstate.
Recursos Utilizados
Elastic Load Balancer (ELB): Para balanceamento de carga.
VPC e Subnets: Para integrar o Load Balancer às redes.
Security Groups: Para controlar o acesso às instâncias.
Auto Scaling (opcional): Para escalar as instâncias automaticamente.
Considerações de Segurança
Certifique-se de que as credenciais da AWS não estão expostas no repositório.
Use o arquivo .gitignore para evitar a inclusão de arquivos como terraform.tfstate.
Licença
Este projeto é distribuído sob a licença MIT. Consulte o arquivo LICENSE para mais detalhes.






# Projeto Terraform - Configuração de Load Balancer 🌐

Bem-vindo ao repositório **Projeto Terraform - Load Balancer**! Este projeto utiliza o Terraform para criar e configurar um Load Balancer (Balanceador de Carga) na AWS, permitindo a distribuição eficiente de tráfego entre instâncias EC2. 🚀  

---

## 📋 **Descrição**
Este repositório contém a configuração necessária para:
- Criar um **Load Balancer** que distribui tráfego para múltiplas instâncias EC2.
- Garantir alta disponibilidade e escalabilidade da infraestrutura.
- Utilizar os recursos da AWS de forma automatizada com o Terraform.  

---

## 📁 **Estrutura de Arquivos**
Abaixo está a estrutura do repositório:  
