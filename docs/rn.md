# Regras de Negócio (RN)
> **Restrições e políticas que o sistema deve respeitar independentemente de quem o usa.**
> Documento vivo — versão alinhada à Proposta de Solução do Ecossistema Digital da Farmácia Americana.

---

## Atendimento e IA

### RN01 - Limite de Atuação da IA
A IA (Lumi) não deve realizar diagnósticos médicos. Sua atuação deve se limitar a fornecer informações de bula, posologia e indicações de medicamentos isentos de prescrição (MIPs), com base em protocolos de saúde pública.

### RN02 - Alerta de Encaminhamento Médico
Quando os sintomas relatados pelo usuário no chat ultrapassarem o escopo dos MIPs ou indicarem risco à saúde, a IA deve obrigatoriamente orientar o usuário a buscar atendimento médico, sem sugerir medicamentos para a situação.

### RN03 - Fluxo de Contingência do OCR
Caso a IA não consiga identificar com clareza os medicamentos de uma receita (leitura parcial ou ilegível), o atendimento deve ser obrigatoriamente transferido para um atendente humano, com o protocolo da sessão repassado automaticamente.

### RN04 - Geração Obrigatória de Protocolo
Todo atendimento iniciado pelo chatbot deve gerar um número de protocolo único. Esse protocolo deve ser visível ao usuário e acessível ao atendente para fins de continuidade e rastreabilidade.

---

## Receitas e Medicamentos Controlados

### RN05 - Trava de Medicamentos Controlados
É proibido adicionar ao carrinho ou finalizar a venda de medicamentos controlados sem o upload prévio e a validação bem-sucedida da receita médica via OCR.

### RN06 - Validade da Receita
O sistema deve verificar a data de emissão da receita. Receitas com data de validade expirada (conforme legislação vigente da Anvisa) devem ser recusadas, com mensagem explicativa ao usuário.

### RN07 - Reserva Temporária de Estoque
Após a validação de uma receita com medicamentos disponíveis, o sistema deve reservar os itens identificados no estoque por **30 minutos**. Expirado esse prazo sem finalização do pedido, a reserva deve ser cancelada automaticamente.

---

## Cadastro e Dados do Usuário

### RN08 - Cadastro Obrigatório para Compra
O usuário pode navegar pelo catálogo e usar o chatbot sem cadastro. Porém, para finalizar qualquer compra, o cadastro completo (e-mail, telefone e CPF) é obrigatório.

### RN09 - CPF Único por Conta
Cada CPF pode estar vinculado a apenas uma conta ativa no sistema, prevenindo duplicidade de cadastro.

### RN10 - Consentimento Explícito para Dados de Saúde
O armazenamento de dados relacionados à saúde do usuário (histórico de medicamentos, receitas, ciclo de uso) só pode ocorrer mediante aceite explícito dos termos de consentimento, em conformidade com a LGPD.

---

## Pagamentos e Pedidos

### RN11 - Confirmação de Pagamento Antes do Processamento
Nenhum pedido deve ser encaminhado para separação ou entrega antes da confirmação do pagamento pela API de terceiros. O status do pedido deve permanecer como "Aguardando pagamento" até essa confirmação.

### RN12 - Notificação de Recompra Baseada em Ciclo Real
A notificação push de recompra de medicamentos de uso contínuo só deve ser disparada quando o sistema identificar, com base no histórico de compras, um padrão recorrente de pelo menos **2 pedidos anteriores** do mesmo item.

---

> **Distinção importante:**
> Regras de Negócio (RN) definem **o que é permitido ou proibido** no domínio do negócio.
> Requisitos Funcionais (RF) definem **o que o sistema deve fazer**.
> Requisitos Não Funcionais (RNF) definem **como o sistema deve se comportar**.
> Os três documentos são complementares e devem ser consultados em conjunto.
