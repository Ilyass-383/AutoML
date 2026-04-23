# ================================
# DOCKERFILE POUR AUTO-ML STREAMING
# ================================

# Image de base Python 3.11 (compatible avec River)
FROM python:3.11-slim

# Évite les fichiers .pyc et la mise en mémoire tampon
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Définit le répertoire de travail
WORKDIR /app

# Installe les dépendances système (nécessaire pour scipy, numpy, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Copie requirements.txt en premier (cache Docker)
COPY requirements.txt .

# Installe les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Copie le code source
COPY src/ ./src/
COPY data/ ./data/

# Crée un utilisateur non-root pour la sécurité
RUN useradd -m -u 1000 automl && chown -R automl:automl /app
USER automl

# Expose le port de l'API
EXPOSE 8000

# Démarre l'API avec uvicorn
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "1"]