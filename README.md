
# Atividade 3_IA: Comparação de Métricas de Classificação e Regressão com Armazenamento em Banco de Dados

## Objetivo

Desenvolver um sistema para experimentação e comparação de modelos de Machine Learning (ML) que armazene os modelos, hiperparâmetros, estratégias de pré-processamento e métricas de desempenho em um banco de dados. O sistema permitirá o recálculo e a geração de relatórios comparativos de desempenho dos modelos treinados.

---

## Dataset

Utilizar datasets conhecidos como:

- **Classificação:**  
  - Iris Dataset  
  - Breast Cancer Dataset  

- **Regressão:**  
  - Boston Housing Dataset  
  - California Housing Dataset  

---

## Estrutura do Projeto

1. **Criar um banco de dados relacional** que contenha tabelas para armazenar:
   - Modelos de ML e seus hiperparâmetros;
   - Estratégias de pré-processamento (*Scaling*, *Sampling*, *Feature Selection*);
   - Estratégias de aprendizado (*Cross-Validation*, *Hold-out*);
   - Resultados de treino, validação e teste;
   - Métricas calculadas para cada modelo e experimento.

2. **Pré-processamento de dados**
   - Normalização e padronização dos dados;
   - Amostragem dos dados (*Undersampling*, *Oversampling*, *Stratified Sampling*);
   - Separação dos dados em treino, validação e teste (*Hold-out* e *Cross-Validation*).

3. **Definição dos modelos e suas características**
   - Escolha de algoritmos de ML para classificação e regressão (exemplos: `RandomForest`, `SVM`, `DecisionTree`, `Linear Regression`, `XGBoost`);
   - Configuração de hiperparâmetros;
   - Armazenamento do modelo treinado e suas configurações no banco de dados.

4. **Avaliação de desempenho das medidas de ML**
   - Cálculo de métricas de classificação:
     - Acurácia
     - Precisão
     - Recall
     - F1-score
     - AUC-ROC
   - Cálculo de métricas de regressão:
     - MSE
     - RMSE
     - MAE
     - R²
   - Registro das métricas no banco de dados para posterior análise comparativa.

5. **Relatórios e estrutura de armazenamento genérico**
   - Consultas SQL para recuperar resultados anteriores;
   - Reavaliação de modelos com diferentes métricas;
   - Geração de relatórios comparativos entre os modelos e diferentes estratégias de pré-processamento e treinamento.

---

## Resumo das Tarefas

- Criar o esquema do banco de dados para armazenar os experimentos e resultados.
- Implementar um pipeline de pré-processamento configurável.
- Treinar pelo menos **dois modelos de ML de classificação** e **dois de regressão**.
- Implementar a persistência dos modelos treinados no banco de dados.
- Desenvolver um sistema para visualizar e comparar os resultados dos experimentos.

---

## 📦 Entregáveis

- Código-fonte do sistema;
- Esquema do banco de dados (*SQL* ou *ORM*);
- Relatório detalhado dos experimentos e comparações;
- Scripts SQL para consulta e recuperação dos modelos.
