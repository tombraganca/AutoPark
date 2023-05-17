# AutoPark Server

Este server é um conjunto de APIs e regras de negocios utilizadas para o controle de acessos e cadastro dos motoristas do AutoPark. 

Podemos dizer que o AutoPark Server é o coração da aplicação, responsável por receber e enviar informações para todas as direções da aplicação.

Este serviço faz contato direto com o App Mobile AutoPark, com o CasStreaming AutoPark e com o Server MQTT. Além disso ele é responsável por acessar o Banco de dados Postgres para fazer a persisténcia dos dados.

## Pré requisitos

Caso você não esteja utilizando o docker para executar a aplicação completa ou queira executar este ambiente em um local remoto do Docker, você precisará:

* Node 16^
* Uma instância do banco postgres

Lembre-se que é necesspario ter o arquivo **.env** com todas as variáveis previamente configuradas. Caso tenha alguma duvida entre em contato com os desenvolvedores.

Instale as depencias do processo:

```bash
npm install
```

Nós optamos por utilizar uma ORM chamado Prisma. Esta ferramenta possui recursos que nos auxiliou na hora do desenvilvimento e reduziu o tempo. Esta escolha se deu por causa do conhecimento prévio dos componentes do projeto.

O prisma cria interfaces na hora do desenvolvimento e é necessário que gera-las:

```bash
npx prisma generate
```

Além disso durante o processo foram criadas migrates de modificação do banco de dados Postgres. O prisma lida com isto ao rodas o comando:

```bash
npx prisma migrade dev
```

Após isto o ambiente está configurado e pode ser executado usando o comando:

```bash
npm run dev #executa em modo de desenvolvimento
```

ou 

```bash
npm start #executa em modo de produção
```

Como este projeto é meramente academico, ambos os comandos geram o mesmo resulto, salve pelo fato de que em modo de desenvolvimento o sistema rodara em modo _watch_. Isso significa que todas as alterações nos arquivos do projeto será recarregado em live reload.

É importante ressaltar que as credenciais e chaves do google devem ser inseridas utilizando um projeto válidado no mobile.