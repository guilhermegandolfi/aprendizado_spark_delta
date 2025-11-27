# Aprendizado Spark Delta

Projeto para aprendizado de Apache Spark com Delta Lake usando Jupyter Notebook e MinIO.

## 🚀 Infraestrutura

- **Jupyter Lab** com PySpark e Delta Lake
- **MinIO** como object storage (S3-compatible)
- **Docker Compose** para orquestração

## 📋 Pré-requisitos

- Docker
- Docker Compose
- Git

## 🔧 Instalação e Execução

### 1. Clone o repositório

```bash
git clone <seu-repositorio>
cd aprendizado_spark_delta
```

### 2. Crie os diretórios necessários

```bash
mkdir -p data src
```

### 3. Suba os containers

```bash
docker-compose up -d
```

### 4. Acesse o Jupyter Lab

Pegue o token de acesso:

```bash
docker-compose logs jupyter | grep token
```

Acesse: http://localhost:8888

### 5. Acesse o MinIO Console

- URL: http://localhost:9001
- User: `minioadmin`
- Password: `minioadmin`

## 📦 Serviços

| Serviço | Porta | Descrição |
|---------|-------|-----------|
| Jupyter Lab | 8888 | Interface do Jupyter |
| Spark UI | 4040 | Interface do Spark (quando job está rodando) |
| MinIO API | 9000 | API S3-compatible |
| MinIO Console | 9001 | Interface web do MinIO |

## 🛠️ Comandos Úteis

```bash
# Parar os containers
docker-compose down

# Parar e remover volumes
docker-compose down -v

# Ver logs
docker-compose logs -f

# Reconstruir imagens
docker-compose up --build -d

# Acessar shell do Jupyter
docker exec -it jupyter-spark-delta bash
```

## 📁 Estrutura do Projeto

```
.
├── data/                   # Dados locais (montado no container)
├── src/                    # Notebooks e scripts
├── dockerfiles/
│   └── Dockerfile         # Imagem customizada do Jupyter
├── docker-compose.yml     # Orquestração dos serviços
├── requirements.txt       # Dependências Python
└── README.md
```

## 📚 Dependências Python

- `delta-spark` - Delta Lake
- `pandas` - Manipulação de dados
- `pyarrow` - Formato columnar
- `boto3` - AWS SDK para Python
- `s3fs` - Interface S3 para filesystem

## 🎯 Próximos Passos

1. Criar buckets no MinIO
2. Desenvolver notebooks de exemplo
3. Testar leitura/escrita com Delta Lake
4. Integrar Spark com MinIO

## 📝 Licença

[Sua licença aqui]