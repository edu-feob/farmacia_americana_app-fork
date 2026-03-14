# 💊 Farmácia Americana Digital

> Plataforma móvel de atendimento de elite para a Farmácia Americana de Jacutinga — desenvolvida em Flutter.

---

## ⚠️ O Problema

O atendimento via WhatsApp da farmácia sofre com baixa escalabilidade. A dependência de intervenção humana para tarefas repetitivas — consultar estoque, ler receitas, processar pagamentos — gera um efeito cascata: sobrecarga do atendente principal, desvio de função de outros colaboradores e queda na qualidade do atendimento.

O resultado é um ciclo de ineficiência onde o estoque nem sempre é atualizado em tempo real e as dúvidas recorrentes dos clientes acumulam fila, consumindo o tempo que deveria ser dedicado a atendimentos que realmente exigem um farmacêutico.

---

## 🎯 Objetivo

Desenvolver um ecossistema digital em **Flutter** que atue como um braço inteligente da farmácia, fundindo a conveniência de um e-commerce (estilo iFood/Amazon) com o poder da **IA Generativa** para automatizar dúvidas recorrentes, processar receitas via OCR e prever a demanda de medicamentos de uso contínuo.

---

## 👥 Público-Alvo

| Perfil | Necessidade |
|---|---|
| **Pacientes Crônicos** | Previsibilidade na recompra de medicamentos de uso contínuo |
| **Consumidores Digitais** | Imediatismo, precisão e autonomia na compra |
| **Clientes Fidelizados** | Modernidade mantendo a confiança já estabelecida com a marca |

---

## 📱 Funcionalidades Principais

### 🏠 Home — Vitrine Inteligente
Tela inicial com algoritmo de recomendações sazonais (ex: antialérgicos no inverno de Jacutinga), ofertas em destaque e barra de busca com autocompletar e tolerância a erros ortográficos.

### 🤖 Atendimento — Chatbot Lumi (IA Generativa)
Central de atendimento automatizado com linguagem natural. O Lumi reconhece as **dúvidas frequentes dos clientes** e responde automaticamente com **orientações básicas** sobre posologia, modo de uso e armazenamento de medicamentos — sem realizar indicações ou diagnósticos. Casos que exigem julgamento clínico ou comercial (como pedidos de indicação de remédio) são **encaminhados automaticamente para um atendente humano**, com o histórico completo da conversa preservado via protocolo rastreável.

### 📷 Receitas — OCR com IA (Visão Computacional)
O cliente fotografa a receita médica. A IA extrai os medicamentos, valida a data de emissão e o CRM do prescritor, verifica o estoque e adiciona os itens ao carrinho automaticamente. Medicamentos controlados possuem trava de segurança obrigatória.

### 🛒 Carrinho e Checkout
Fluxo de compra sem fricção com pagamento via **PIX** e **Cartão de Crédito** (integração com API de terceiros), em conformidade com a LGPD.

### 🗂️ Categorias
Navegação segmentada por: MIPs, Suplementos, Higiene, Medicamentos Controlados e Cuidados Infantis.

### 👤 Conta — Dashboard do Paciente
Histórico de pedidos, gerenciamento de dados cadastrais e o **Ciclo de Saúde**: a IA aprende o padrão de recompra de medicamentos de uso contínuo e envia uma notificação push antes do estoque pessoal acabar.

---

## 🗂️ Estrutura da Documentação

```
docs/
├── rn.md              # 19 Requisitos Funcionais (3 MVPs)
├── rnf.md             # 15 Requisitos Não Funcionais
├── rn.md              # 13 Regras de Negócio
├── backlog.md         # 6 Épicos · 34 User Stories
├── UC_FarmaciaAmericanaApp.md              # 13 Casos de Uso detalhados
```

---

## 🏗️ Épicos do Backlog

| Épico | Escopo | User Stories |
|---|---|---|
| **01** · Identidade e Segurança | Auth, LGPD, perfil do paciente | 6 |
| **02** · Catálogo e E-commerce | Vitrine, busca, carrinho | 6 |
| **03** · Inteligência de Atendimento | Chatbot Lumi, dúvidas frequentes, encaminhamento | 8 |
| **04** · Visão Computacional | OCR, validação de receitas | 6 |
| **05** · Checkout e Pagamentos | PIX, cartão, confirmação | 4 |
| **06** · Fidelização e Predição | Histórico, ciclo de saúde, recompra | 4 |

---

## 📋 MVPs

```
MVP 1 — Jornada de Compra e Catálogo
  Catálogo dinâmico · Busca inteligente · Carrinho · Categorias · Recomendações sazonais

MVP 2 — Atendimento e IA (O Diferencial)
  Chatbot Lumi · Dúvidas frequentes automáticas · Encaminhamento de casos complexos
  OCR de receitas · Validação por IA · Trava de controlados · Protocolos rastreáveis

MVP 3 — Checkout e Recorrência
  PIX e Cartão · Cadastro/Login · Perfil · Histórico · Predição de recompra · LGPD
```

---

## 🤖 Escopo do Chatbot Lumi

O Lumi opera dentro de um escopo definido para garantir segurança e conformidade:

| O Lumi **faz** | O Lumi **não faz** |
|---|---|
| Responder dúvidas frequentes automaticamente | Indicar ou recomendar medicamentos |
| Fornecer orientações básicas de posologia e armazenamento | Realizar diagnósticos médicos |
| Encaminhar casos complexos para o atendente | Responder questões clínicas ou sobre interações medicamentosas |
| Gerar protocolo rastreável para cada sessão | Atender casos que exijam julgamento farmacêutico |

---

## 🔒 Segurança e Conformidade

- Dados de saúde e CPF criptografados em trânsito (**TLS 1.2+**) e em repouso (**AES-256**)
- Autenticação via **JWT** + login social com **OAuth 2.0** (Google)
- Controle de acesso por perfil: Cliente · Atendente · Administrador
- Gestão de consentimento de dados de saúde em conformidade com a **LGPD (Lei nº 13.709/2018)**

---

## ⚡ Metas de Performance

| Indicador | Meta |
|---|---|
| Carregamento da Home | ≤ 3 segundos |
| Resposta do Chatbot Lumi | ≤ 4 segundos |
| Processamento de OCR | ≤ 5 segundos |
| Uptime do sistema | ≥ 99% |

---

## 🛠️ Stack

| Camada | Tecnologia |
|---|---|
| Mobile | Flutter (Android 8.0+ · iOS 14+) |
| IA / Chatbot | IA Generativa (NLP + Vision/OCR) |
| Autenticação | JWT · OAuth 2.0 (Google) |
| Pagamentos | API de terceiros (PIX · Cartão) |
| Diagramas | PlantUML |

---

## 👤 Atores do Sistema

| Ator | Responsabilidade |
|---|---|
| **Cliente (Paciente)** | Navega, compra, envia receitas e interage com o Lumi |
| **Atendente / Farmacêutico** | Recebe protocolos encaminhados e dá continuidade ao atendimento humano |
| **Administrador** | Gerencia catálogo, estoque, base de dúvidas do Lumi e configurações do sistema |

---

*Repositório acadêmico — Projeto Integrador 3º Semestre · UNIFEOB*
