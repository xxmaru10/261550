# Registro de Tradução - Warhammer: The Old Realms (PT-BR)

Este documento serve para coordenar o esforço de tradução do mod "The Old Realms" entre diferentes sessões de IA. O objetivo é traduzir apenas o conteúdo narrativo, diálogos e lore in-game com o qual o jogador interage diretamente.

## 📋 Instruções para a IA (Protocolo de Trabalho)
1.  **Tamanho do Bloco:** Traduzir em blocos de no máximo **50-80 linhas**. NUNCA tente traduzir o arquivo inteiro de uma vez.
2.  **Sequência de Trabalho:** 
    *   Lê o arquivo original.
    *   Gera a tradução no formato XML.
    *   **Imediatamente** abre o `AI.md` e marca o bloco como concluído [x] e atualiza a porcentagem de status.
3.  **Preservação Estrutural:** NUNCA alterar as chaves `{=...}` ou as tags XML (ex: `<string>`, `id=`, `<Description>`).
4.  **Tom de Voz:** Estilo "Dark Fantasy" épico e solene. Evitar termos informais.

## ⚠️ Atenção: Dois Tipos de Arquivo

- **Arquivos de localização** (`tor_strings.xml`, `tor_voiced_strings.xml`, `tor_concept_strings.xml`): traduzir o atributo `text="..."` preservando a chave `{=...}` intacta.
- **Arquivos com texto inline** (`tor_itemtraits.xml`, `tor_specialization_options.xml`, `tor_cc_options.xml`): os textos estão diretamente no XML, **sem** chave de localização correspondente em `tor_strings.xml`. Traduzir o conteúdo das tags diretamente.

## 📚 Glossário de Termos (Consistência)
| Termo Original | Tradução Sugerida | Notas |
| :--- | :--- | :--- |
| The Empire | O Império | Sempre com I maiúsculo |
| Warp / Imaterium | Warp / O Imatério | Manter Warp para contexto técnico |
| Witch Hunter | Caçador de Bruxas | |
| Winds of Magic | Ventos da Magia | |
| Chaos | Caos | |
| Sigmar | Sigmar | Não traduzir |
| Old Ones | Antigos | |
| Greenskins | Peles-verdes | |
| Lore of Magic | Saber da Magia | Ex: Saber do Fogo |
| State Troops | Tropas Estaduais | |
| Spellcraft | Arte Arcana | |
| Winds of Magic recharge | Recarga dos Ventos da Magia | |
| Miscast | Falha de Conjuração | |

## 🚀 Progresso da Tradução

### 1. Strings Principais (UI, Skills, Diálogos, Eventos)
**Arquivo:** `3025574678/ModuleData/tor_strings.xml`
- **Status:** 0% (~450k caracteres)
- **Conteúdo:** Interface, nomes de habilidades, descrições de skills, diálogos, eventos pop-up, nomes de raças, efeitos de skill
- **Monitoramento:**
    - [ ] Bloco 01 (Início)

### 2. Diálogos de Raças (Vampiros, Elfos, etc.)
**Arquivo:** `3025574678/ModuleData/tor_voiced_strings.xml`
- **Status:** 0%
- **Conteúdo:** Linhas de diálogo por raça (vampiros, elfos da floresta, cultistas, etc.)
- **Monitoramento:**
    - [ ] Tradução completa

### 3. Conceitos e Tooltips (Explicações de Mecânicas)
**Arquivo:** `3025574678/ModuleData/tor_concept_strings.xml`
- **Status:** 0%
- **Conteúdo:** Explicações de mecânicas, glossário in-game, tooltips de conceitos
- **Monitoramento:**
    - [ ] Tradução completa

### 4. Traços e Encantos de Itens
**Arquivo:** `3025574678/ModuleData/tor_custom_xmls/tor_itemtraits.xml`
- **Status:** 0%
- **Conteúdo:** Nomes e descrições de encantos/traços de armas e equipamentos (ex: Runefang, Flaming Weapon, Azyr Infused). Texto **hardcoded** — editar diretamente as tags `<ItemTraitName>` e `<ItemTraitDescription>`.
- **Monitoramento:**
    - [ ] Tradução completa

### 5. Especializações e Escolas de Magia
**Arquivo:** `3025574678/ModuleData/tor_custom_xmls/tor_specialization_options.xml`
- **Status:** 0%
- **Conteúdo:** Nomes, descrições, efeitos positivos e negativos de cada escola de magia (Aqshy, Ghyran, Shyish, etc.) e especializações de classe. Texto **inline** — editar diretamente as tags `<Name>`, `<Description>`, `<PositiveEffect>`, `<NegativeEffect>`.
- **Monitoramento:**
    - [ ] Tradução completa

### 6. Criação de Personagem (Origens e Backgrounds)
**Arquivo:** `3025574678/ModuleData/tor_custom_xmls/tor_cc_options.xml`
- **Status:** 0%
- **Conteúdo:** Textos de origem e flavor text exibidos durante a criação de personagem. Texto **inline** — editar diretamente as tags `<OptionText>` e `<OptionFlavourText>`.
- **Monitoramento:**
    - [ ] Tradução completa

---

## ❌ Arquivos Excluídos (Não Traduzir)

| Arquivo | Motivo |
| :--- | :--- |
| `tor_extendeditemproperties.xml` | Quase inteiramente vazio; as ~31 entradas com texto são extratos de livros in-universe (lore enciclopédico) |
| `Languages/VoicedLines/EN/PC/*.xml` | Dados de lip-sync (rhubarbResult), sem texto |
| `tor_extendedunitproperties.xml` | Dados de stats de unidades, sem texto |
| `tor_statuseffects.xml` | Dados de efeitos de status, sem texto |
| `tor_factionbanneroverrides.xml`, `tor_animation_triggers.xml`, `tor_config.xml` | Dados técnicos, sem texto |

---

## 📝 Como Continuar
Para continuar o trabalho, a IA deve ler este arquivo, verificar o próximo bloco pendente e postar a tradução no formato XML. Atualize este arquivo após cada bloco concluído.
