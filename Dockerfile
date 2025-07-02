# Etapa 1: Escolher uma imagem base oficial do Python.
# A versão -slim é uma boa escolha por ser menor que a padrão,
# mas ainda contendo as ferramentas básicas necessárias.
# O README menciona Python 3.10+, então a 3.11 é uma escolha segura e moderna.
FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências.
# Fazemos isso primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .

# Etapa 4: Instalar as dependências.
# O --no-cache-dir ajuda a manter a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação.
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada.
EXPOSE 8000

# Etapa 7: Comando para iniciar a aplicação com Uvicorn.
# O host 0.0.0.0 é necessário para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]