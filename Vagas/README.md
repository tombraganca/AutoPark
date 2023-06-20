# Documentação do Projeto de Detecção de Vagas 

Este documento fornece uma visão geral e uma documentação passo a passo para o projeto de Detecção de Vagas, que utiliza várias bibliotecas populares, como OpenCV, YOLOv8, Python 3.10 O objetivo do projeto é detectar localização de veículos e identificação de ocupação das vagas.

## Pré-requisitos

Certifique-se de ter os seguintes componentes e software instalados em seu sistema:

- Python 3.10
- OpenCV
- YOLOv8
- Pillow
- Matplot
- Bibliotecas nativas (se necessário para o seu ambiente)
- Docker
- Ubuntu
- build-essential


## Configuração do Ambiente - Ubuntu

Antes de iniciar o projeto, verifique se você configurou corretamente o ambiente. 

1. Certifique-se de que o Python 3.10 está instalado em seu sistema. Você pode verificar a versão do Python digitando o seguinte comando no terminal:

   ```
   python --version
   ```

2. Instale as dependências necessárias executando o seguinte comando:

   ```
   make
   ```

3. Baixe e instale as bibliotecas nativas necessárias para o seu ambiente específico. Certifique-se de seguir as instruções fornecidas pela biblioteca, especialmente se você estiver usando um sistema operacional diferente do Ubuntu.
    ```
    build-essential, python3 e pip3 
    ``` 


### Detecção de Vagas em um Video Local

Para executar a detecção das vagas em um video local, siga os passos abaixo:

1. Navegue até a pasta raiz do projeto.

2. Execute o seguinte comando no terminal:

   ```
   make test
   ```

Certifique-se de ler a documentação completa para obter informações detalhadas sobre as opções disponíveis e as configurações necessárias para o projeto.
