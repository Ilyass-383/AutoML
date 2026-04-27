# 🔒 Auto-ML Intrusion Detection System

[![Python 3.11](https://img.shields.io/badge/Python-3.11-blue.svg)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.104-green.svg)](https://fastapi.tiangolo.com/)
[![Docker](https://img.shields.io/badge/Docker-24.0-blue.svg)](https://www.docker.com/)
[![Grafana](https://img.shields.io/badge/Grafana-10.0-orange.svg)](https://grafana.com/)
[![River](https://img.shields.io/badge/River-0.21-red.svg)](https://riverml.xyz/)

## 📋 Description

Système de **détection d'intrusions en temps réel** utilisant l'**Auto-ML** avec bandit (ε-greedy + UCB1), 4 modèles incrémentaux, détection de drift (ADWIN), API FastAPI, et dashboard de monitoring Grafana.

## 🎯 Objectifs du projet

- ✅ Mettre en place un service **Auto-ML "always-on"** qui sélectionne automatiquement le meilleur modèle
- ✅ Gérer la **dérive de concept** avec ADWIN
- ✅ Fournir une **API REST** pour les prédictions en temps réel
- ✅ Assurer un **monitoring complet** avec Prometheus + Grafana
- ✅ **Conteneuriser** l'application avec Docker

## 🏆 Performances

| Métrique | Valeur |
|----------|--------|
| **F1-Score Ensemble** | **95.73%** |
| Instances traitées | 175,341 |
| Drifts détectés | 1 |
| Latence moyenne | ~11 ms |
| Temps de réponse API | < 10 ms |

## 🤖 Modèles utilisés

| Modèle | Type | F1-Score |
|--------|------|----------|
| **Ensemble (ARF)** | Forêt d'arbres adaptative | **95.73%** 🥇 |
| **HT** | Hoeffding Tree | 85.82% 🥈 |
| **KNN_ADWIN** | KNN avec détection de drift | 82.10% 🥉 |
| **SGD** | Gradient stochastique | 78.35% |

## 🏗️ Architecture
┌─────────────────────────────────────────────────────────────────┐
│ REQUÊTES CLIENTS │
│ │ │
│ ▼ │
│ ┌─────────────────┐ │
│ │ API FastAPI │ │
│ │ (Port 8000) │ │
│ └────────┬────────┘ │
│ │ │
│ ┌──────────────┼──────────────┐ │
│ │ │ │ │
│ ▼ ▼ ▼ │
│ ┌────────┐ ┌────────┐ ┌────────┐ │
│ │ HT │ │ KNN │ │ SGD │ │
│ │ 86.6% │ │ 82.1% │ │ 78.4% │ │
│ └────────┘ └────────┘ └────────┘ │
│ │ │ │ │
│ └──────────────┼──────────────┘ │
│ │ │
│ ┌────▼────┐ │
│ │ BANDIT │ │
│ │(UCB1+ε) │ │
│ └────┬────┘ │
│ │ │
│ ▼ │
│ ┌─────────────────┐ │
│ │ Ensemble │ │
│ │ (5 arbres) │ │
│ │ 95.73% F1 │ │
│ └─────────────────┘ │

## 🚀 Démarrage rapide

### Prérequis
- Docker & Docker Compose
- Git

### Installation

```bash
# 1. Clonez le dépôt
git clone https://github.com/Ilyass-383/AutoML.git
cd AutoML

# 2. Lancez tous les services
docker-compose up -d

# 3. Vérifiez que tout tourne
docker-compose ps

│ │
│ ┌─────────────────────────────────────────────────────────┐ │
│ │ MONITORING │ │
│ │ Prometheus (9090) ←→ Grafana (3000) │ │
│ └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
