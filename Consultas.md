## 1. Listar todos os experimentos

```sql
SELECT * FROM experimento;
```

## 2. Obter as estratégias de aprendizado usadas em cada experimento

```sql
SELECT e.nome AS Experimento, ea.tipo, ea.folds, ea.randomState
FROM estrategiaAprendizado ea
JOIN experimento e ON ea.id_experimento = e.id;
```

## 3. Listar os hiperparâmetros de cada experimento

```sql
SELECT e.nome AS Experimento, h.nome AS Hyperparametro, eh.valor
FROM experimento_hyperparam eh
JOIN experimento e ON eh.id_experimento = e.id
JOIN hyperparametros h ON eh.id_hyperparâmetros = h.id;

```

## 4. Obter as métricas de cada experimento

```sql
SELECT e.nome AS Experimento, m.nome AS Metrica, me.valor
FROM metrica_experimento me
JOIN experimento e ON me.id_experimento = e.id
JOIN metricas m ON me.id_metrica = m.id;

```

## 5. Verificar os modelos e seus tipos

```sql
SELECT m.nome AS Modelo, tm.nome AS Tipo
FROM modelo m
JOIN tipo_modelo tm ON m.id_tipo = tm.id;

```

## 6. Mostrar os resultados dos experimentos

```sql
SELECT e.nome AS Experimento, m.nome AS Modelo, me.valor AS Metrica
FROM resultados r
JOIN experimento e ON r.experimento_id = e.id
JOIN modelo m ON r.modelo_id = m.id
JOIN metrica_experimento me ON r.id_metrica_experimento = me.id;

```

## 7. Mostrar os resultados e dados relacionados
```sql
SELECT 
    e.id AS Experimento_ID,
    e.nome AS Experimento_Nome,

    -- Estratégia de Aprendizado
    (SELECT ea.tipo FROM estrategiaAprendizado ea WHERE ea.id_experimento = e.id LIMIT 1) AS Estrategia_Tipo,
    (SELECT ea.folds FROM estrategiaAprendizado ea WHERE ea.id_experimento = e.id LIMIT 1) AS Estrategia_Folds,
    (SELECT ea.randomState FROM estrategiaAprendizado ea WHERE ea.id_experimento = e.id LIMIT 1) AS Estrategia_RandomState,

    -- Modelos e Tipos de Modelos
    (SELECT GROUP_CONCAT(DISTINCT m.nome) FROM modelo m 
     JOIN resultados r ON m.id = r.modelo_id 
     WHERE r.experimento_id = e.id) AS Modelos_Utilizados,
    (SELECT GROUP_CONCAT(DISTINCT tm.nome) FROM tipo_modelo tm 
     JOIN modelo m ON tm.id = m.id_tipo 
     JOIN resultados r ON m.id = r.modelo_id 
     WHERE r.experimento_id = e.id) AS Tipos_Modelos,

    -- Hiperparâmetros
    (SELECT GROUP_CONCAT(DISTINCT CONCAT(h.nome, ': ', eh.valor)) FROM hyperparametros h
     JOIN experimento_hyperparam eh ON h.id = eh.id_hyperparâmetros 
     WHERE eh.id_experimento = e.id) AS Hiperparametros,

    -- Pré-processamento
    (SELECT p.scaling FROM preprocessamento p WHERE p.id_experimento = e.id LIMIT 1) AS Preprocessamento_Scaling,
    (SELECT p.sampling FROM preprocessamento p WHERE p.id_experimento = e.id LIMIT 1) AS Preprocessamento_Sampling,

    -- Separação das métricas em colunas
    (SELECT me.valor FROM metrica_experimento me 
     JOIN metricas met ON me.id_metrica = met.id 
     WHERE me.id_experimento = e.id AND met.nome = 'Acurácia' LIMIT 1) AS Metrica_Acuracia,

    (SELECT me.valor FROM metrica_experimento me 
     JOIN metricas met ON me.id_metrica = met.id 
     WHERE me.id_experimento = e.id AND met.nome = 'Precisão' LIMIT 1) AS Metrica_Precisao,

    (SELECT me.valor FROM metrica_experimento me 
     JOIN metricas met ON me.id_metrica = met.id 
     WHERE me.id_experimento = e.id AND met.nome = 'Recall' LIMIT 1) AS Metrica_Recall,

    (SELECT me.valor FROM metrica_experimento me 
     JOIN metricas met ON me.id_metrica = met.id 
     WHERE me.id_experimento = e.id AND met.nome = 'F1-Score' LIMIT 1) AS Metrica_F1_Score

FROM experimento e;

```
