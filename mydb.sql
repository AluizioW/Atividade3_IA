-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 21-Fev-2025 às 18:40
-- Versão do servidor: 8.0.41-0ubuntu0.20.04.1
-- versão do PHP: 7.4.3-4ubuntu2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `mydb`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `estrategiaAprendizado`
--

CREATE TABLE `estrategiaAprendizado` (
  `id` int NOT NULL,
  `id_experimento` int NOT NULL,
  `tipo` enum('cross-validation','hold-out') NOT NULL,
  `folds` int DEFAULT NULL,
  `randomState` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Extraindo dados da tabela `estrategiaAprendizado`
--

INSERT INTO `estrategiaAprendizado` (`id`, `id_experimento`, `tipo`, `folds`, `randomState`) VALUES
(1, 1, 'hold-out', NULL, 42),
(2, 2, 'hold-out', NULL, 42);

-- --------------------------------------------------------

--
-- Estrutura da tabela `experimento`
--

CREATE TABLE `experimento` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Extraindo dados da tabela `experimento`
--

INSERT INTO `experimento` (`id`, `nome`) VALUES
(1, 'Logistic Regression 1'),
(2, 'KNN - Classification 1\r\n');

-- --------------------------------------------------------

--
-- Estrutura da tabela `experimento_hyperparam`
--

CREATE TABLE `experimento_hyperparam` (
  `id` int NOT NULL,
  `id_experimento` int NOT NULL,
  `id_hyperparâmetros` int NOT NULL,
  `valor` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Extraindo dados da tabela `experimento_hyperparam`
--

INSERT INTO `experimento_hyperparam` (`id`, `id_experimento`, `id_hyperparâmetros`, `valor`) VALUES
(1, 1, 1, '1000'),
(2, 2, 2, '5'),
(3, 2, 3, 'minkowski'),
(4, 2, 4, 'uniform');

-- --------------------------------------------------------

--
-- Estrutura da tabela `hyperparametros`
--

CREATE TABLE `hyperparametros` (
  `id` int NOT NULL,
  `modelo_id` int NOT NULL,
  `nome` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Extraindo dados da tabela `hyperparametros`
--

INSERT INTO `hyperparametros` (`id`, `modelo_id`, `nome`) VALUES
(1, 2, 'max_iter'),
(2, 1, 'n_neighbors'),
(3, 1, 'metric'),
(4, 1, 'weight'),
(5, 3, 'fit_intercept'),
(6, 3, 'copy_x'),
(7, 3, 'n_jobs'),
(8, 4, 'n_neighbors'),
(9, 4, 'metric'),
(10, 4, 'weight');

-- --------------------------------------------------------

--
-- Estrutura da tabela `metricas`
--

CREATE TABLE `metricas` (
  `id` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  `id_tipo_modelo` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Extraindo dados da tabela `metricas`
--

INSERT INTO `metricas` (`id`, `nome`, `id_tipo_modelo`) VALUES
(1, 'Acurácia', 1),
(2, 'Precisão', 1),
(3, 'Recall', 1),
(4, 'F1-Score', 1),
(5, 'AUC-ROC', 1),
(6, 'MAE', 2),
(7, 'MSE', 2),
(8, 'RMSE', 2),
(9, 'R2', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `metrica_experimento`
--

CREATE TABLE `metrica_experimento` (
  `id` int NOT NULL,
  `id_metrica` int NOT NULL,
  `id_experimento` int NOT NULL,
  `valor` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Extraindo dados da tabela `metrica_experimento`
--

INSERT INTO `metrica_experimento` (`id`, `id_metrica`, `id_experimento`, `valor`) VALUES
(1, 1, 1, 0.982456),
(2, 2, 1, 0.986111),
(3, 3, 1, 0.986111),
(4, 4, 1, 0.986111),
(5, 5, 1, 0.99537),
(6, 1, 2, 0.95614),
(7, 2, 2, 0.958904),
(8, 3, 2, 0.972222),
(9, 4, 2, 0.965517),
(10, 5, 2, 0.978836);

-- --------------------------------------------------------

--
-- Estrutura da tabela `modelo`
--

CREATE TABLE `modelo` (
  `id` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  `id_tipo` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Extraindo dados da tabela `modelo`
--

INSERT INTO `modelo` (`id`, `nome`, `id_tipo`) VALUES
(1, 'KNN', 1),
(2, 'Logistic Regression', 1),
(3, 'Linear Regression', 2),
(4, 'KNN', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `preprocessamento`
--

CREATE TABLE `preprocessamento` (
  `id` int NOT NULL,
  `id_experimento` int NOT NULL,
  `scaling` enum('none','min-max','standard') NOT NULL,
  `sampling` enum('stratified','none','undersampling','oversampling') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Extraindo dados da tabela `preprocessamento`
--

INSERT INTO `preprocessamento` (`id`, `id_experimento`, `scaling`, `sampling`) VALUES
(1, 1, 'standard', 'stratified'),
(2, 2, 'standard', 'stratified');

-- --------------------------------------------------------

--
-- Estrutura da tabela `resultados`
--

CREATE TABLE `resultados` (
  `id` int NOT NULL,
  `experimento_id` int NOT NULL,
  `modelo_id` int NOT NULL,
  `id_metrica_experimento` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Extraindo dados da tabela `resultados`
--

INSERT INTO `resultados` (`id`, `experimento_id`, `modelo_id`, `id_metrica_experimento`) VALUES
(1, 1, 2, 1),
(2, 1, 2, 2),
(3, 1, 2, 3),
(4, 1, 2, 4),
(5, 1, 2, 5),
(6, 2, 1, 6),
(7, 2, 1, 7),
(8, 2, 1, 8),
(9, 2, 1, 9),
(10, 2, 1, 10);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_modelo`
--

CREATE TABLE `tipo_modelo` (
  `id` int NOT NULL,
  `nome` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Extraindo dados da tabela `tipo_modelo`
--

INSERT INTO `tipo_modelo` (`id`, `nome`) VALUES
(1, 'classificação'),
(2, 'regressão');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `estrategiaAprendizado`
--
ALTER TABLE `estrategiaAprendizado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_estrategiaAprendizado_1_idx` (`id_experimento`);

--
-- Índices para tabela `experimento`
--
ALTER TABLE `experimento`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `experimento_hyperparam`
--
ALTER TABLE `experimento_hyperparam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_experimento_hyperparam_1` (`id_experimento`),
  ADD KEY `fk_experimento_hyperparam_2` (`id_hyperparâmetros`);

--
-- Índices para tabela `hyperparametros`
--
ALTER TABLE `hyperparametros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_hyperparametros_1_idx` (`modelo_id`);

--
-- Índices para tabela `metricas`
--
ALTER TABLE `metricas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_metricas_1_idx` (`id_tipo_modelo`);

--
-- Índices para tabela `metrica_experimento`
--
ALTER TABLE `metrica_experimento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_metrica_experimento_1_idx` (`id_experimento`),
  ADD KEY `fk_metrica_experimento_2_idx` (`id_metrica`);

--
-- Índices para tabela `modelo`
--
ALTER TABLE `modelo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_modelo_1_idx` (`id_tipo`);

--
-- Índices para tabela `preprocessamento`
--
ALTER TABLE `preprocessamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_preprocessamento_1_idx` (`id_experimento`);

--
-- Índices para tabela `resultados`
--
ALTER TABLE `resultados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_resultados_1_idx` (`experimento_id`),
  ADD KEY `fk_resultados_2_idx` (`modelo_id`),
  ADD KEY `fk_resultados_3_idx` (`id_metrica_experimento`);

--
-- Índices para tabela `tipo_modelo`
--
ALTER TABLE `tipo_modelo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `estrategiaAprendizado`
--
ALTER TABLE `estrategiaAprendizado`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `experimento`
--
ALTER TABLE `experimento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `experimento_hyperparam`
--
ALTER TABLE `experimento_hyperparam`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `hyperparametros`
--
ALTER TABLE `hyperparametros`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `metricas`
--
ALTER TABLE `metricas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `metrica_experimento`
--
ALTER TABLE `metrica_experimento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `modelo`
--
ALTER TABLE `modelo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `preprocessamento`
--
ALTER TABLE `preprocessamento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `resultados`
--
ALTER TABLE `resultados`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `tipo_modelo`
--
ALTER TABLE `tipo_modelo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `estrategiaAprendizado`
--
ALTER TABLE `estrategiaAprendizado`
  ADD CONSTRAINT `fk_estrategiaAprendizado_1` FOREIGN KEY (`id_experimento`) REFERENCES `experimento` (`id`);

--
-- Limitadores para a tabela `experimento_hyperparam`
--
ALTER TABLE `experimento_hyperparam`
  ADD CONSTRAINT `fk_experimento_hyperparam_1` FOREIGN KEY (`id_experimento`) REFERENCES `experimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_experimento_hyperparam_2` FOREIGN KEY (`id_hyperparâmetros`) REFERENCES `hyperparametros` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `hyperparametros`
--
ALTER TABLE `hyperparametros`
  ADD CONSTRAINT `fk_hyperparametros_1` FOREIGN KEY (`modelo_id`) REFERENCES `modelo` (`id`);

--
-- Limitadores para a tabela `metricas`
--
ALTER TABLE `metricas`
  ADD CONSTRAINT `fk_metricas_1` FOREIGN KEY (`id_tipo_modelo`) REFERENCES `tipo_modelo` (`id`);

--
-- Limitadores para a tabela `metrica_experimento`
--
ALTER TABLE `metrica_experimento`
  ADD CONSTRAINT `fk_metrica_experimento_1` FOREIGN KEY (`id_experimento`) REFERENCES `experimento` (`id`),
  ADD CONSTRAINT `fk_metrica_experimento_2` FOREIGN KEY (`id_metrica`) REFERENCES `metricas` (`id`);

--
-- Limitadores para a tabela `modelo`
--
ALTER TABLE `modelo`
  ADD CONSTRAINT `fk_modelo_1` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_modelo` (`id`);

--
-- Limitadores para a tabela `preprocessamento`
--
ALTER TABLE `preprocessamento`
  ADD CONSTRAINT `fk_preprocessamento_1` FOREIGN KEY (`id_experimento`) REFERENCES `experimento` (`id`);

--
-- Limitadores para a tabela `resultados`
--
ALTER TABLE `resultados`
  ADD CONSTRAINT `fk_resultados_1` FOREIGN KEY (`experimento_id`) REFERENCES `experimento` (`id`),
  ADD CONSTRAINT `fk_resultados_2` FOREIGN KEY (`modelo_id`) REFERENCES `modelo` (`id`),
  ADD CONSTRAINT `fk_resultados_3` FOREIGN KEY (`id_metrica_experimento`) REFERENCES `metrica_experimento` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
