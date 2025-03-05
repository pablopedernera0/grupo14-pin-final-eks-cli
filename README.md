# Proyecto Final de Formación en DevOps - Grupo 14

## Implementación de un Cluster EKS con Terraform, Grafana y Prometheus

### Integrantes del grupo:
- Silvia Imperiale
- Belén Carabajal
- Vanina Armida
- Pablo Contardi
- Pablo Pedernera

En el marco del programa de formación en DevOps impartido por MundosE, el Grupo 14 presenta el proyecto para generar un cluster en Amazon EKS. Este cluster, denominado `grupo14-eks-cluster`, se despliega en la región `us-east-1` de AWS.

El cluster está compuesto por un grupo de nodos (`grupo14-ng`) configurados con máquinas virtuales del tipo `t2.micro`. Además, se implementaron Prometheus y Grafana utilizando Helm para el monitoreo. Un servicio NGINX (`nginx-logs-service`) se encarga de gestionar los registros.

## Entorno

Para comenzar, es necesario instalar las herramientas necesarias:

1. Instalación de Terraform:
   - Actualizar los paquetes y luego instalar Terraform.
     - sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
     - wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
     - echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
     - sudo apt update
     - sudo apt-get install terraform 

2. Instalación de AWS CLI:
   - Descargar e instalar AWS CLI:
     - curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install


3. Instalación de kubectl:
   - Descargar y configurar kubectl:
       - curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
       - chmod +x kubectl
       - sudo mv kubectl /usr/local/bin/

4. Instalación de eksctl:
   - Descargar y configurar eksctl:
       - curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
       - sudo mv /tmp/eksctl /usr/local/bin

5. Instalación de Helm:
   - Instalar Helm para desplegar Prometheus y Grafana:
       - curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

6. Configuración de AWS
   - Configurar las credenciales de AWS ejecutando `aws configure`. 
   - IngresarAWS Access Key ID, Secret Access Key, región preferida (por ejemplo, sa-east-1) y formato de salida (json)

## Ejecución del proyecto
1. Inicialización de Terraform
   - Inicializar el proyecto y descargar los módulos necesarios ejecutando `terraform init`

2. Plan de Implementación
   - Generar un plan de implementación con `terraform plan` para revisar los recursos a crear.

3. Aplicación de la Configuración
   - Desplegar el cluster y los recursos asociados con `terraform apply -auto-approve`.

4. Acceso al Cluster EKS
   - Configurar `kubectl` para usar el cluster creado con `aws eks --region us-east-1 update-kubeconfig --name grupo14-eks-cluster`.

5. Despliegue de Prometheus y Grafana
   - Estos servicios se despliegan automáticamente como parte de la infraestructura. 
   - Verificar los puntos de acceso con `kubectl get svc -n monitoring`.

## Resultado final

Después de completar el despliegue, se tiene acceso a:
- Cluster EKS
- Endpoint del cluster
- Prometheus
- Grafana
- NGINX

## Pasos finales

1. Grafana:
   - Ingresar a Grafana y agregar una nueva fuente de datos con Prometheus.

2. Prometheus:
   - Utilizar la URL `http://prometheus-release-server` para conectar con Prometheus.

3. Grafana Panels:
   - Importar nuevos paneles desde la biblioteca.

4.Visualización de Datos:
   - Verificar que los datos del cluster se carguen correctamente.

## Limpieza del entorno
   - Eliminar todos los recursos creados, ejecutando `terraform destroy -auto-approve`. 
