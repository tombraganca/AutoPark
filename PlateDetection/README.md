# Documentação do Projeto de Detecção de Placas e Leitura OCR 

Este documento fornece uma visão geral e uma documentação passo a passo para o projeto de Detecção de Placas, que utiliza várias bibliotecas populares, como OpenCV, YOLOv8, Python 3.10, MQTT Cliente e EasyOCR. O objetivo do projeto é detectar placas de veículos em imagens enviadas por um microcontrolador ESP32 Cam através do protocolo MQTT.

## Pré-requisitos

Certifique-se de ter os seguintes componentes e software instalados em seu sistema:

- Python 3.10
- OpenCV
- YOLOv8
- MQTT Cliente
- EasyOCR
- Bibliotecas nativas (se necessário para o seu ambiente)
- Docker
- Ubuntu
- build-essential

## Passos para Renomear o Arquivo

Siga os passos abaixo para renomear o arquivo `.env.example` para `.env`:

1. Navegue até o diretório raiz do seu projeto.

2. Localize o arquivo chamado `.env.example`. Esse arquivo geralmente está na raiz do projeto.

3. Renomeie o arquivo `.env.example` para `.env`. Você pode fazer isso usando o comando `mv` no terminal ou por meio de um gerenciador de arquivos.

   ```
   mv .env.example .env
   ```

## Configuração do Ambiente - Ubuntu

Antes de iniciar o projeto, verifique se você configurou corretamente o ambiente. 

1. Certifique-se de que o Python 3.10 está instalado em seu sistema. Você pode verificar a versão do Python digitando o seguinte comando no terminal:

   ```
   python --version
   ```

2. Instale as dependências necessárias executando o seguinte comando:

   ```
   Make
   ```

3. Baixe e instale as bibliotecas nativas necessárias para o seu ambiente específico. Certifique-se de seguir as instruções fornecidas pela biblioteca, especialmente se você estiver usando um sistema operacional diferente do Ubuntu.
    ```
    build-essential, python3 e pip3 
    ``` 


## Estrutura do Projeto

O projeto está organizado da seguinte forma:

```
src/
training/
test/
./ (best.onnx, last.pt, best.pt)
```

- `src`: Aplicação cli que assi
- `traning`: Script reponsável por organizar o [dataset](https://www.kaggle.com/datasets/scholngusmaximus/numberplate-bounding-box-india-eu-brazil-us?select=indian_eu_br_us.csv) para fazer o treinamento.
- `test`: Utilizado para fazer teste em imagem dectecção de placas e OCR.
- `(best.onnx, last.pt, best.pt)`: Modelos YoloV8 treinandos para classe de Placas 


## Uso do Script de Detecção de Placa

Existem duas partes neste projeto: detecção de placa em uma imagem local e detecção de placa em uma imagem recebida via MQTT. Siga as instruções abaixo para executar cada uma das partes.

### Detecção de Placa em uma Imagem Local

Para executar a detecção de placa em uma imagem local, siga os passos abaixo:

1. Navegue até a pasta raiz do projeto.

2. Execute o seguinte comando no terminal:

   ```
   make test0
   make test1
   make test2
   ```

### Detecção de Placa em um Tópico MQTT
Para executar a detecção de placa em uma imagem local, siga os passos abaixo:

1. Navegue até a pasta raiz do projeto.

2. Execute o seguinte comando no terminal:

   ```
   make start
   ```
3. Agora o Micro Serviço irá aguardar uma imagem para processar

4. Execute um publish para testar 
   ```
   make publish
   ```

### Treino YOLOv8
Para executar a detecção de placa em uma imagem local, siga os passos abaixo:

1. Navegue até a pasta raiz do projeto.

2. Execute o seguinte comando no terminal:

   ```
   chmod +x setup.sh
   make train
   ```
3. Os resultados são salvos em `runs/detect/train#`

### Criando um Servidor Local MQTT


## Dockerfile mosquito-eclipse

Certifique-se de ter o Docker e Make instalado em seu sistema antes de prosseguir.

0. Navegue até o diretório que contém o Dockerfile.

1. Para instalar o servidor MQTT, execute o seguinte comando:

   ```
   make mqtt-server-install
   ```

   Isso instalará o servidor MQTT necessário para o projeto.

2. Para executar o contêiner MQTT, execute o seguinte comando:

   ```
   make mqtt-start
   ```
   ```
   make mqtt-stop
   ```
   Isso iniciará o contêiner MQTT com base nas configurações fornecidas.

Certifique-se de ler a documentação completa para obter informações detalhadas sobre as opções disponíveis e as configurações necessárias para o projeto.


## README Criado com ajuda do chat GPT

## [Kaggle dataset](https://www.kaggle.com/datasets/scholngusmaximus/numberplate-bounding-box-india-eu-brazil-us?select=indian_eu_br_us.csv)