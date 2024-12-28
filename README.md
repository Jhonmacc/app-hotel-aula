# Estrutura do Banco de Dados para Hotéis

Esta modelagem cobre os seguintes aspectos:

- **Gestão de hóspedes:** Informações pessoais, endereço e contato.
- **Quartos:** Disponibilidade e tipos.
- **Reservas:** Controle de estadias e status.
- **Serviços adicionais:** Lavanderia, transporte, restaurante, entre outros.
- **Pagamentos:** Pagamento conjunto (reserva e serviços) ou separado.

---

## Estrutura das Tabelas

### **Tabela `hospedes`**
Armazena as informações básicas dos hóspedes.

**Colunas:**
- `id` (PK): Identificador único.
- `nome`, `data_nascimento`, `cpf` (único), `sexo`.
- `created_at`, `updated_at`.

**Relacionamentos:**
- 1:1 com `endereco`.
- 1:1 com `contato`.
- 1:N com `reservas`.

---

### **Tabela `endereco`**
Armazena os endereços dos hóspedes.

**Colunas:**
- `id` (PK), `hospede_id` (FK), `logradouro`, `numero`, `bairro`, `cidade`, `estado`, `cep`, `complemento` (opcional).

**Relacionamentos:**
- 1:1 com `hospedes`.

---

### **Tabela `contato`**
Armazena informações de contato.

**Colunas:**
- `id` (PK), `hospede_id` (FK), `telefone`, `email` (único).

**Relacionamentos:**
- 1:1 com `hospedes`.

---

### **Tabela `quartos`**
Armazena as informações dos quartos do hotel.

**Colunas:**
- `id` (PK), `numero` (único), `tipo`, `capacidade`, `preco_diaria`, `status` (Disponível, Ocupado, Manutenção).

**Relacionamentos:**
- 1:N com `reservas`.

---

### **Tabela `reservas`**
Controla as estadias dos hóspedes no hotel.

**Colunas:**
- `id` (PK), `hospede_id` (FK), `quarto_id` (FK), `data_entrada`, `data_saida`, `status` (Confirmada, Cancelada, Concluída), `total`.

**Relacionamentos:**
- N:1 com `hospedes`.
- N:1 com `quartos`.
- 1:1 com `pagamentos`.

---

### **Tabela `servicos_adicionais`**
Armazena os serviços extras oferecidos pelo hotel.

**Colunas:**
- `id` (PK), `nome` (ex.: Lavanderia, Transporte, Restaurante), `descricao`, `preco`.

---

### **Tabela `hospede_servico`**
Relaciona hóspedes aos serviços solicitados.

**Colunas:**
- `id` (PK), `hospede_id` (FK), `servico_id` (FK), `data_solicitacao`, `quantidade`, `total` (quantidade * preço do serviço).

**Relacionamentos:**
- N:N entre `hospedes` e `servicos_adicionais`.

---

### **Tabela `pagamentos`**
Controla os pagamentos realizados pelos hóspedes.

**Colunas:**
- `id` (PK), `reserva_id` (FK), `hospede_servico_id` (FK opcional), `metodo_pagamento`, `valor`, `data_pagamento`, `status` (Pago, Pendente, Cancelado).

**Relacionamentos:**
- 1:1 com `reservas`.
- 1:N com `hospede_servico`.

---

## Modelo Relacional (Diagrama de Relacionamentos)

```plaintext
hospedes —(1:1)— endereco
hospedes —(1:1)— contato
hospedes —(1:N)— reservas
reservas —(1:N)— quartos
reservas —(1:1)— pagamentos
hospedes —(N:N)— servicos_adicionais (através de hospede_servico)
hospede_servico —(1:N)— pagamentos
```
## Benefícios da Modelagem

### **Normalização**
- Separar informações por contexto reduz redundâncias.

### **Flexibilidade**
- Suporte a diferentes cenários de pagamento (conjunto ou independente).

### **Clareza**
- Estrutura fácil de entender e manter.

### **Escalabilidade**
- Possibilidade de adicionar novos módulos (relatórios, promoções, etc.) sem reestruturar o banco.

---

## Tipos de Dados

- **Eficiência:** Campos com tamanhos otimizados economizam espaço.
- **Validação:** Usar ENUM para valores predefinidos minimiza erros.
- **Integridade:** Campos definidos como UNIQUE garantem consistência e evitam dados duplicados.
- **Escalabilidade:** Campos como BIGINT e DECIMAL atendem a grandes volumes e valores monetários.

---

## Conclusão

Essa é uma modelagem simples e ideal para sistemas de hotelaria, refletindo boas práticas de design. Cada relação foi planejada para atender às regras de negócio mais comuns, mantendo o banco de dados eficiente e extensível.

Se você gostou dessa abordagem ou tem ideias para melhorar, deixe um comentário! Vamos trocar conhecimentos!

---

## 🏷️ Tags

`#Bancodedados` `#MySql` `#Oracle` `#PostgreSQL` `#SQL` `#SGBD` `#Php` `#Laravel` `#React` `#Vuejs` `#Nodejs` `#DesenvolvimentoWeb` `#Gestão` `#Inovação` `#Automação` `#Tecnologia`

---

💻 Desenvolvido com ❤️ e muita dedicação para simplificar a modelagem de dados em bancos.

