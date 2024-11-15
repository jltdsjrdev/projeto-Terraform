# Projeto Terraform - Configuração de Load Balancer 🌐

Bem-vindo ao repositório **Projeto Terraform - Load Balancer**! Este projeto utiliza o Terraform para criar e configurar um Load Balancer (Balanceador de Carga) na AWS, permitindo a distribuição eficiente de tráfego entre instâncias EC2. 🚀  

---

## 📋 **Descrição**
Este repositório contém a configuração necessária para:
- Criar um **Load Balancer** que distribui tráfego para múltiplas instâncias EC2.
- Garantir alta disponibilidade e escalabilidade da infraestrutura.
- Utilizar os recursos da AWS de forma automatizada com o Terraform.  

---

## 📁 **Estrutura**
### load-balance.tf: / Configuração principal do Load Balancer.
### variables.tf: 
Definição de variáveis usadas no projeto.
### outputs.tf: 
Define os valores de saída (ARN do Load Balancer, etc.).
###.gitignore: 
Ignora arquivos sensíveis como terraform.tfstate. <hr>
### Recursos Utilizados
### Elastic Load Balancer (ELB): 
Para balanceamento de carga.
### VPC e Subnets: 
Para integrar o Load Balancer às redes.
### Security Groups: 
Para controlar o acesso às instâncias.
### Auto Scaling (opcional):
Para escalar as instâncias automaticamente. <hr>

## Considerações de Segurança
Certifique-se de que as credenciais da AWS não estão expostas no repositório.
Use o arquivo .gitignore para evitar a inclusão de arquivos como terraform.tfstate.
Abaixo está a estrutura do repositório:  
📂 projeto-Terraform/ ├── load-balance.tf # Configuração do Load Balancer ├── variables.tf # Definição das variáveis utilizadas ├── main.tf # Arquivo principal para configuração ├── outputs.tf # Saídas do Terraform ├── .gitignore # Arquivos ignorados pelo Git └── README.md # Documentação do projeto


---

## 🚀 **Como Utilizar**  

### **Pré-requisitos**
- Conta na AWS.
- Terraform instalado na sua máquina. [(Guia de Instalação)](https://developer.hashicorp.com/terraform/downloads)
- Configuração das credenciais AWS (via CLI ou `~/.aws/credentials`).  

### **Passo a Passo**
1. Clone o repositório:   
   git clone https://github.com/jltdsjrdev/projeto-Terraform.git
   cd projeto-Terraform

Inicialize o Terraform:
terraform init  <hr>

Visualize o plano de execução:
terraform plan <hr>

Aplique as configurações:
terraform apply 

Confirme a aplicação digitando yes quando solicitado. <hr>
## 🔧 Configuração Importante
### O arquivo load-balance.tf configura um Load Balancer utilizando:

Listeners para regras de tráfego.
Target Groups para associar instâncias EC2.
Health Checks para garantir que o tráfego seja direcionado apenas para instâncias saudáveis. <hr>

Exemplo de um trecho do código:

resource "aws_lb" "example" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.lb_subnet_ids[*]
}

### 📜 Outputs
Após a aplicação, o Terraform fornece as seguintes informações:
Endereço DNS do Load Balancer para acessar os serviços.

### 🤝 Contribuições
Contribuições são bem-vindas! Para contribuir:

### Faça um fork do projeto.
Crie uma nova branch:
git checkout -b minha-nova-feature <hr>

### Commit suas alterações:
git commit -m "Adiciona nova feature" <hr>

### Faça o push para a branch:
git push origin minha-nova-feature 

Abra um Pull Request. <hr>

📄 Licença
Este projeto está sob a licença MIT. Consulte o arquivo LICENSE para mais detalhes.





 


