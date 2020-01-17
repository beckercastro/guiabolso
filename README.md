# Tarefas

### Pré-requisitos 

- docker
- docker-compose

### Iniciando ambiente e aplicação

**Build**

O DockerFile da aplicação está dentro de seu respectivo diretórios.

O mesmo será utilizado para o build e configuração dos containers.

**Como iniciar**



O arquivo chamado `'docker-compose.yml'` é utilizado para a criação do ambiente contendo:
- App exposto na porta 8000.

Execute o comando abaixo para que o ambiente seja criado:

 ```docker-compose up -d .```

O mesmo iniciará o processo de build e execução da aplicação e iniciará os containers em background.

Aguarde alguns momentos até o termino das tarefas a serem executadas.

Após esse período, em seu browser acesse o ambiente utilizando a URL http://localhost.
