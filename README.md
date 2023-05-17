# AutoPark
Auto Park é um estacionamento autônomo que acomoda os carros nas vagas disponíveis e utiliza IA para validar o cadastro dos carros

Design:
https://www.figma.com/file/bK3G5ll5rnHdS2LEwv4ed3/AutoPark?node-id=0%3A1&t=yP3H130RSt0GWJXg-1

## Arquitetura do projeto:

<img src="assets/Sem título-2023-04-22-1137.png" title="Imagem que representa o fluxo de entrada de um carro no estacionamento."/>

## Iniciando o projeto

### Prerequisitos

- <a href="https://docs.docker.com/engine/install/">Docker compose</a>
- <a href="https://nodejs.org/en/download">Node</a>
- <a href="https://docs.flutter.dev/get-started/install">Flutter</a>


O projeto possui três serviços organizados das seguintes formas:

### autopark-api

É um container que executa todas as todas de requisões http, tanto publicas quanto privadas e faz o acesso ao banco de dados utilizando o ORM Prisma.

### postgres

É uma instância que roda um banco de dados PostgreSql.

### auto--park-stream

Cointener que controla toda a questão de processamento de imagem e comunica como a API /request-access quando requisitada.



Para inicializar o projeto é necessário rodar todas as instancias utilizando o docker. Então garanta que o tenha o docker compose instalado na sua maquina.

As instâncias auto-park-stream e auto-park-api precisam de um documento proprio chamado _.developement.env_. Este arquivo contem informações de constantes bases para que a aplicação possa iniciar.

Vá até a pasta _/environment_ e copie os arquivos _api.developement.env_ e cole na pasta _server_ e o renomeie para **".developement.env"**

```bash
mv environment/api.developement.env server/.developement.env
```

Agora, na mesma pasta _/environment_ e copie o outro arquivo _stream.developement.env_ e cole na pasta _CamStreaming_ e renomeie para **".developement.env"**

```bash
mv environment/stream.developement.env CamStreaming/.developement.env
```

Agora podemos executar os containers.

```bash
make #inicia o projeto
```
<img src="./assets/docker-terminal.png">

# Swagger

Todas as requisições estão sendo documentada e, caso você esteja com o serviço rodando, podem ser acessadas <a href="http://localhost:3000/api-docs/#/"> AQUI</a>.

Em sua maioria é utiolizado validação de autenticação. No entanto existem apis de testes que permite a vizualização de alguns dados.

<img src="./assets/swagger.png" title="Print da tela do swagger">

