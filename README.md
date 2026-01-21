# 🎯 Aprendizado Spark Delta

Um projeto completo para aprender **Apache Spark** com **Delta Lake**, processamento de dados em larga escala e integração com **MinIO** (object storage S3-compatible). Tudo executado em containers Docker para facilitar o ambiente de desenvolvimento.

## ✨ Sobre o Projeto

Este repositório demonstra:
- 📊 Processamento de dados com **PySpark** em um ambiente containerizado
- 🗄️ Integração com **Delta Lake** para ACID transactions e versionamento de dados
- ☁️ Uso de **MinIO** como S3-compatible object storage
- 📓 Notebooks Jupyter interativos com exemplos práticos
- 🐳 Infraestrutura reproduzível com Docker Compose

**Dataset utilizado:** Netflix Titles (com dados aumentados)

---

## 🚀 Quick Start

### Pré-requisitos

- **Docker** e **Docker Compose** instalados
- 2GB de memória RAM disponível
- Git

### Setup Inicial

```bash
# 1. Clone o repositório
git clone <seu-repositorio>
cd aprendizado_spark_delta

# 2. Inicie os containers
docker-compose up -d

# 3. Aguarde 10-15 segundos para os serviços inicializarem

# 4. Acesse o Jupyter Lab
# http://localhost:8888 (sem token necessário)
```

---

## 📚 Notebooks Disponíveis

| Notebook | Descrição |
|----------|-----------|
| **01_upload_file_to_bucket.ipynb** | Exemplos de upload de arquivos para MinIO usando boto3 |
| **02_lendo_arquivo.ipynb** | Leitura de arquivos CSV com PySpark |
| **03_usando_delta.ipynb** | Criação e manipulação de Delta Tables |
| **04_usando_delta_sql.ipynb** | Queries SQL em Delta Tables |

---

## 🏗️ Arquitetura & Serviços

```
┌─────────────────────────────────────────────────────────────┐
│                     Docker Network                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────────┐          ┌──────────────────────┐ │
│  │  Jupyter Lab + Spark │          │   MinIO Storage      │ │
│  │  - Port 8888         │◄────────►│  - Port 9000 (API)   │ │
│  │  - Port 4040 (UI)    │          │  - Port 9001 (Web)   │ │
│  └──────────────────────┘          └──────────────────────┘ │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

| Serviço | Porta | URL | Credenciais |
|---------|-------|-----|-------------|
| 📔 Jupyter Lab | 8888 | http://localhost:8888 | Sem token |
| ⚡ Spark UI | 4040 | http://localhost:4040 | Disponível durante execução |
| 🪣 MinIO API | 9000 | http://localhost:9000 | `minioadmin/minioadmin` |
| 💻 MinIO Console | 9001 | http://localhost:9001 | `minioadmin/minioadmin` |

---

## 🛠️ Gerenciamento dos Containers

```bash
# Iniciar containers
docker-compose up -d

# Parar containers (mantém volumes)
docker-compose down

# Parar e remover tudo (incluindo volumes)
docker-compose down -v

# Ver logs em tempo real
docker-compose logs -f jupyter

# Reconstruir imagens
docker-compose up --build -d

# Executar comando no container Jupyter
docker exec -it jupyter-spark-delta bash

# Ver status dos containers
docker-compose ps
```

---

## 📁 Estrutura do Projeto

```
aprendizado_spark_delta/
├── src/
│   ├── 01_upload_file_to_bucket.ipynb    # Upload para MinIO
│   ├── 02_lendo_arquivo.ipynb             # Leitura com Spark
│   ├── 03_usando_delta.ipynb              # Delta Lake basics
│   ├── 04_usando_delta_sql.ipynb          # SQL queries
│   ├── metastore_db/                      # Derby metadata store
│   ├── spark-warehouse/                   # Warehouse directory
│   └── RAW/                               # Raw data layer
│
├── data/
│   ├── netflix_titles.csv                 # Dataset original
│   ├── netflix_titles_augmented.csv       # Dataset aumentado
│   ├── delta/                             # Delta Lake tables
│   └── _delta_log/                        # Delta transaction logs
│
├── dockerfiles/
│   └── Dockerfile                         # Imagem customizada
│
├── docker-compose.yml                     # Orquestração
├── requirements.txt                       # Dependências Python
└── README.md                              # Este arquivo
```

---

## 📦 Tecnologias & Dependências

### Stack Tecnológico
- **Apache Spark 3.x** - Processamento distribuído de dados
- **Delta Lake 4.x** - ACID transactions e versionamento
- **Jupyter Lab** - Ambiente interativo
- **MinIO** - Object storage S3-compatible
- **Docker** - Containerização

### Dependências Python

```
delta-spark==4           # Delta Lake para Spark
pandas==2.2.0            # Manipulação de dados
pyarrow==15.0.0          # Formato columnar Apache Arrow
boto3==1.34.0            # AWS SDK para Python
s3fs==2024.2.0           # Interface S3 para filesystem
sparkmagic               # Visualizações Spark no Jupyter
```

---

## 💡 Casos de Uso

### 1. **Exploração de Dados**
Leia arquivos CSV e explore dados com PySpark DataFrames.

### 2. **Object Storage**
Envie e recupere arquivos para MinIO usando boto3.

### 3. **Delta Lake**
Crie tabelas com garantias ACID e acesse o histórico de versões.

### 4. **Queries SQL**
Execute SQL em Delta Tables diretamente.

---

## 🔧 Troubleshooting

### Containers não iniciam
```bash
# Limpe volumes antigos e reinicie
docker-compose down -v
docker-compose up -d
```

### Jupyter não acessível
```bash
# Verifique os logs
docker-compose logs jupyter

# Aguarde mais tempo (pode levar 30s na primeira inicialização)
```

### MinIO credenciais não funcionam
- Usuário: `minioadmin`
- Senha: `minioadmin`
- Use a console web para testar conexão

### Erros de memória no Spark
Aumente a memória alocada para o Docker Desktop (Settings → Resources).

---

## 📖 Recursos Adicionais

- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [Delta Lake Guide](https://docs.delta.io/)
- [MinIO Documentation](https://docs.min.io/)
- [PySpark SQL API](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql.html)

---

## 📝 Licença

Este projeto está sob a licença [MIT](LICENSE).

---

## 🤝 Contribuindo

Sinta-se livre para fazer fork, abrir issues e enviar pull requests!

---

**Desenvolvido com ❤️ para aprendizado de Big Data & Apache Spark**
3. Testar leitura/escrita com Delta Lake
4. Integrar Spark com MinIO

## 📝 Licença

[Sua licença aqui]