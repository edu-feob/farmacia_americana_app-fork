# Requisitos Funcionais (RF)
> **O que o sistema deve fazer para ser considerado funcional.**
> Documento vivo — versão alinhada à Proposta de Solução do Ecossistema Digital da Farmácia Americana.

---

## MVP 1: Jornada de Compra e Catálogo

### RF01 - Catálogo Dinâmico
O sistema deve listar produtos com nome, imagem, preço, categoria e disponibilidade em estoque em tempo real.

### RF02 - Busca Inteligente
O usuário deve conseguir pesquisar itens por nome, princípio ativo ou categoria, com suporte a autocompletar e tolerância a erros ortográficos básicos.

### RF03 - Carrinho de Compras
O sistema deve permitir adicionar, remover e alterar quantidades de produtos, exibindo subtotal atualizado dinamicamente.

### RF04 - Gestão de Categorias
O app deve segmentar produtos em, no mínimo: MIPs (Medicamentos Isentos de Prescrição), Suplementos, Higiene, Medicamentos Controlados e Cuidados Infantis.

### RF05 - Recomendações Sazonais
A Home deve exibir um bloco de produtos em destaque baseado em sazonalidade e relevância local (ex: antialérgicos no inverno), atualizado pela equipe ou por regras automatizadas.

---

## MVP 2: Atendimento e IA (O Diferencial)

### RF06 - Chatbot de Atendimento (Lumi)
O sistema deve disponibilizar uma interface de chat com IA Generativa capaz de reconhecer dúvidas frequentes dos clientes e responder automaticamente com orientações básicas sobre medicamentos (posologia, modo de uso e cuidados gerais de armazenamento), em linguagem natural, sem realizar indicações ou diagnósticos médicos.

### RF07 - Reconhecimento de Dúvidas Frequentes
O Lumi deve identificar automaticamente perguntas recorrentes dos clientes — como dúvidas sobre horário de funcionamento, disponibilidade de produtos, formas de pagamento e orientações gerais de uso de medicamentos — e respondê-las sem necessidade de intervenção humana.

### RF08 - Encaminhamento de Casos Complexos
Quando o Lumi identificar que uma dúvida ou situação ultrapassa o escopo das orientações básicas — como questões clínicas, interações medicamentosas, necessidade de indicação de remédio ou reclamações — o sistema deve encaminhar o atendimento automaticamente para um atendente humano, repassando o protocolo com o histórico completo da conversa.

### RF09 - OCR de Receitas
O usuário deve poder fotografar ou fazer upload de uma receita médica; o sistema deve extrair o texto via IA (Vision/OCR), identificar os medicamentos listados e verificar a disponibilidade no estoque, adicionando-os automaticamente ao carrinho.

### RF10 - Validação de Receita por IA
O sistema deve analisar a receita fotografada para verificar indicadores de validade (data de emissão, assinatura/CRM do prescritor) e exibir um alerta caso a receita esteja potencialmente vencida ou ilegível.

### RF11 - Trava de Segurança para Controlados
Medicamentos da categoria "Controlados" somente devem ser adicionados ao carrinho mediante validação prévia da receita via OCR. O fluxo de compra desses itens deve ser bloqueado sem essa etapa.

### RF12 - Protocolo de Atendimento
Cada sessão de chat iniciada pelo usuário deve gerar um número de protocolo único e rastreável, permitindo que o farmacêutico dê continuidade ao atendimento com contexto completo, se necessário.

### RF13 - Pagamento Conversacional
O usuário deve conseguir iniciar e concluir o processo de pagamento diretamente pela interface de chat, sem necessidade de navegar para outra tela.

---

## MVP 3: Checkout, Conta e Recorrência

### RF14 - Métodos de Pagamento
O sistema deve oferecer pagamento via PIX e Cartão de Crédito, integrados a uma API de pagamentos de terceiros.

### RF15 - Cadastro e Autenticação
O sistema deve permitir criação de conta com e-mail, número de telefone e CPF, além de opção de login social via conta Google. O cadastro completo deve ser obrigatório para finalizar uma compra.

### RF16 - Perfil e Gerenciamento de Conta
O usuário deve poder visualizar e editar seus dados cadastrais (endereço de entrega, telefone) e preferências dentro da seção "Conta".

### RF17 - Histórico de Compras
O sistema deve registrar e exibir o histórico completo de pedidos do usuário, com status de cada pedido (em preparo, enviado, entregue).

### RF18 - Predição de Recompra (Ciclo de Saúde)
Para medicamentos de uso contínuo identificados no histórico, o sistema deve calcular o ciclo de uso e enviar uma notificação push proativa ao usuário antes do término estimado do estoque pessoal, oferecendo repetição do pedido com um único toque.

### RF19 - Consentimento LGPD
No momento do cadastro, o sistema deve exibir os Termos de Uso e a Política de Privacidade, exigindo aceite explícito antes de prosseguir. O usuário deve poder revogar o consentimento de uso de dados de saúde a qualquer momento pela seção "Conta".

---

> **Legenda de MVPs:**
> - **MVP 1** — Fundação do e-commerce (catálogo, busca, carrinho).
> - **MVP 2** — Diferencial competitivo (IA, OCR, chatbot).
> - **MVP 3** — Monetização e retenção (checkout, perfil, recorrência).
