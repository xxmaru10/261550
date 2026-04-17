# Gerente de Tradução — Warhammer: The Old Realms (PT-BR)

Objetivo: traduzir apenas o conteúdo com o qual o jogador interage diretamente (diálogos, explicações de mecânicas, eventos narrativos, escolhas de personagem). Lore enciclopédico e dados técnicos são excluídos.

---

> [!IMPORTANT]
> **AUDITORIA DE PROGRESSO (17/04/2026):**
> - **Fases 1–5:** 100% CONCLUÍDAS.
> - **Status:** Projeto finalizado.

---

## CONTEXTO DO PROJETO

- **Mod:** The Old Realms (TOR) para Mount & Blade II: Bannerlord
- **Pasta do mod:** `3025574678/` (Steam Workshop ID)
- **Proteção:** o projeto usa git. Nunca é necessário ter medo de editar arquivos — tudo pode ser revertido.
- **Idioma alvo:** `"Português (BR)"` — já é um idioma nativo do Bannerlord.

### Por que dois tipos de estratégia?

O Bannerlord tem um sistema de localização nativo. Arquivos registrados como `GameText` no `SubModule.xml` suportam esse sistema: o jogo lê `{=CHAVE}Texto em inglês` e substitui pela tradução do arquivo de idioma, se existir.

**Para esses arquivos (`tor_strings.xml`, `tor_voiced_strings.xml`, `tor_concept_strings.xml`):** criamos arquivos de tradução separados em `ModuleData/Languages/BR/`. O Steam nunca toca esses arquivos ao atualizar o mod — a tradução sobrevive a updates automaticamente.

**Para os demais (`tor_itemtraits.xml`, `tor_cc_options.xml`, `tor_specialization_options.xml`, arquivos `.ink`):** não há `{=...}` — o sistema de localização nativo não os suporta. Esses são editados diretamente. O git protege o trabalho: após um update do mod, `git diff <arquivo>` mostra exatamente o que mudou para re-aplicar apenas as strings novas.

---

## SETUP (já concluído — não repetir)

Todos os arquivos de infraestrutura já existem. O `language_data.xml` atual tem o seguinte conteúdo (não alterar — adicionar novas entradas somente ao iniciar FASE 5):

```xml
<?xml version="1.0" encoding="utf-8"?>
<LanguageData id="Português (BR)">
  <LanguageFile xml_path="BR/tor_strings_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_voiced_strings_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_concept_strings_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_ror_settlement_templates_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_abilitytemplates_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_religions_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_troopdefinitions_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_townspeople_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_kingdoms_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_clans_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_npccharacters_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_cultures_ptbr.xml" />
</LanguageData>
```

> **Caminho completo a partir da raiz do repositório:** todos os caminhos neste arquivo usam raiz `3025574678/` implícita. Exemplo: `ModuleData/tor_strings.xml` = `3025574678/ModuleData/tor_strings.xml`.

---

## PROTOCOLO DE SESSÃO

### Ao iniciar
1. Leia este arquivo completo.
2. Encontre o **primeiro item sem `[x]`** na seção PROGRESSO.
3. Leia **apenas o intervalo de linhas indicado** do arquivo fonte. Nunca leia o arquivo inteiro.
4. Traduza e apresente o resultado ao usuário no formato correto para o tipo de arquivo.
5. Marque o item como `[x]` neste arquivo imediatamente após.

### Limite por sessão
Traduza no máximo:
- **2 seções** de `tor_strings.xml` ou `tor_itemtraits.xml` (arquivos grandes), **OU**
- **4 arquivos/seções** de arquivos pequenos (InkStories, `tor_specialization_options.xml`, etc.)

Ao atingir o limite, **pare e avise:**
> "Atingi o limite seguro de tradução por sessão para manter qualidade. Recomendo abrir um novo chat, informar o número da última seção concluída e continuar de onde paramos."

### Regras invioláveis
- Nunca alterar `id=`, `{=...}`, nem nomes de tags XML.
- Em arquivos Ink: não traduzir linhas com `~`, `->`, `===`, `INCLUDE`, `EXTERNAL`, tags `#STR_...` ou comentários `//` `/* */`.
- Tom: Dark Fantasy épico e solene. Sem informalidade.

---

## TIPOS DE ARQUIVO E FORMATOS DE SAÍDA

### Tipo 1 — GameText (tor_strings.xml, tor_voiced_strings.xml, tor_concept_strings.xml)

O arquivo fonte usa o formato:
```xml
<string id="id_interno" text="{=CHAVE}Texto em inglês" />
```

A IA deve:
1. Ler o bloco do arquivo fonte
2. Extrair a `CHAVE` de dentro do `{=...}` (ignorar o `id_interno`)
3. Gerar entradas de tradução com `id="CHAVE"` e `text="Tradução em português"`
4. Acrescentar ao arquivo de saída correspondente (NÃO sobrescrever — acumular blocos)

**Formato do arquivo de saída** (cabeçalho só na primeira vez que o arquivo for criado):
```xml
<?xml version="1.0" encoding="utf-8"?>
<base type="string">
    <tags>
        <tag language="Português (BR)" />
    </tags>
    <strings>
        <string id="CHAVE" text="Tradução em português" />
        <string id="CHAVE2" text="Outra tradução" />
    </strings>
</base>
```

**Exemplo concreto:**
- Fonte: `<string id="str_career_screen.title" text="{=str_tor_career_screen_title}Career"/>`
- Saída: `<string id="str_tor_career_screen_title" text="Carreira"/>`

**Destinos:**
| Arquivo fonte | Arquivo de saída |
| :--- | :--- |
| `ModuleData/tor_strings.xml` | `ModuleData/Languages/BR/tor_strings_ptbr.xml` |
| `ModuleData/tor_voiced_strings.xml` | `ModuleData/Languages/BR/tor_voiced_strings_ptbr.xml` |
| `ModuleData/tor_concept_strings.xml` | `ModuleData/Languages/BR/tor_concept_strings_ptbr.xml` |

---

### Tipo 2 — Inline (tor_itemtraits.xml, tor_cc_options.xml, tor_specialization_options.xml)

Esses arquivos não têm `{=...}`. O sistema de localização nativo não os suporta. **Editar diretamente** as tags de texto no arquivo original.

| Arquivo | Tags a traduzir |
| :--- | :--- |
| `tor_itemtraits.xml` | `<ItemTraitName>` e `<ItemTraitDescription>` |
| `tor_cc_options.xml` | `<OptionText>` e `<OptionFlavourText>` |
| `tor_specialization_options.xml` | `<Name>`, `<Description>`, `<PositiveEffect>`, `<NegativeEffect>` |

---

### Tipo 4 — GameText em Atributos XML (FASE 5)

Os arquivos da FASE 5 (`tor_troopdefinitions.xml`, `tor_kingdoms.xml`, `tor_cultures.xml`, etc.) são registrados no `SubModule.xml` como `NPCCharacters`, `Kingdoms`, `SPCultures`, etc. O texto traduzível está em **atributos XML**, não em nós de texto como `tor_strings.xml`.

**Formato fonte (exemplos por arquivo):**
```xml
<!-- tor_troopdefinitions.xml / tor_npccharacters / tor_townspeople -->
<NPCCharacter name="{=KEY}Empire Recruit" ... />

<!-- tor_kingdoms.xml -->
<Kingdom name="{=KEY}Empire of Men" shortname="{=KEY}Empire" title="{=KEY}Elector Count" rulertitle="{=KEY}Kaiser" ... />

<!-- tor_clans.xml -->
<Clan name="{=KEY}House von Carstein" ... />

<!-- tor_religions.xml -->
<Religion name="{=KEY}Sigmar" ... />

<!-- tor_cultures.xml (apenas nomes de facção/cultura — ignorar _male_/_female_/_last_) -->
<CultureObject name="{=KEY}Empire of Men" ... />
```

**Regra:** extrair o `KEY` de cada `{=KEY}` e traduzir o texto que vem depois. Os campos `text=` longos (descrições de lore) **não são traduzidos** — escopo do projeto é conteúdo visível ao jogador, não enciclopédia.

**Formato de saída:** idêntico ao Tipo 1 (GameText) — arquivo `*_ptbr.xml` em `Languages/BR/`.

---

### Tipo 3 — Ink (InkStories/*.ink)

Traduzir: texto narrativo simples e o texto dentro de `[colchetes]` nas escolhas.

**Não traduzir:** linhas com `~`, `->`, `===`, `INCLUDE`, `EXTERNAL`; tags `#STR_...`; comentários `//` e `/* */`.

**Exemplo:**
```
Antes:  A haunting aura hangs over the battlefield. #STR_Start1
Depois: Uma aura sombria paira sobre o campo de batalha. #STR_Start1

Antes:  * [Search for any survivors among the fallen.] -> SearchForSurvivors
Depois: * [Procurar sobreviventes entre os caídos.] -> SearchForSurvivors

Não traduzir: -> END   /   === Start ===   /   ~ temp x = 1
```

---

## GLOSSÁRIO

> Referência oficial PT-BR: [Total War: Warhammer (honga.net)](https://www.honga.net/totalwar/warhammer/faction.php?l=pt-BR) e Warhammer: Vermintide 2. Termos marcados com ⚠️ divergem da localização oficial — ver nota.

### Facções e Culturas

| Termo Original | Tradução | Notas |
| :--- | :--- | :--- |
| The Empire | O Império | I maiúsculo sempre — confirmado TW:WH |
| Bretonnia | Bretônia | Confirmado TW:WH |
| Vampire Counts | Condes Vampiro | Confirmado TW:WH |
| Blood Dragons | Dragões de Sangue | |
| Greenskins | Peles-verdes | Confirmado TW:WH e Warhammer Online |
| Warriors of Chaos | Guerreiros do Caos | Confirmado TW:WH |
| Beastmen | Homens-fera | Confirmado TW:WH |
| Chaos | Caos | |
| Kislev / Mousillon / Eonir | Kislev / Mousillon / Eonir | Manter — nomes próprios da ambientação |
| Sigmar / Ulric / Shallya / Nurgle / Tzeentch / Khorne | *(idem)* | Não traduzir — nomes de divindades e deuses do Caos |
| Old Ones | Antigos | |

### Títulos e Cargos

| Termo Original | Tradução | Notas |
| :--- | :--- | :--- |
| Elector Count | Conde Eleitor | Traduzir título; manter nome próprio (ex: "Conde Eleitor Marius Leitdorf") |
| Supreme Patriarch | Patriarca Supremo | |
| Grail Knight | Cavaleiro do Graal | Confirmado TW:WH |
| Green Knight | O Cavaleiro Verde | Confirmado TW:WH |
| Witch Hunter | Caçador de Bruxas | Confirmado TW:WH e Vermintide 2 |
| Warrior Priest | Sacerdote Guerreiro | Confirmado TW:WH e Vermintide 2 |
| Runelord | Senhor das Runas | Confirmado TW:WH |
| Ironbreaker | Quebra-Ferro | Não confirmado em TW:WH; mantido por consistência |
| Slayer | Matador | Vermintide 2 PT-BR mantém "Slayer", mas os arquivos já traduzidos do mod usam "Matador" consistentemente (7+ ocorrências em tor_abilitytemplates_ptbr.xml, tor_strings_ptbr.xml, tor_cc_options.xml) — manter "Matador" |
| Warden | Guardião | |
| Grey Lord | Senhor Cinza | |
| Lady of the Lake | Dama do Lago | |
| Career | Carreira | |

### Tropas e Unidades

| Termo Original | Tradução | Notas |
| :--- | :--- | :--- |
| State Troops | Tropas Estaduais | Confirmado TW:WH |
| Halberdiers | Alabardeiros | Confirmado TW:WH |
| Greatswords | Espadões | Confirmado TW:WH |
| Demigryph Knights | Cavaleiros de Semigrifos | Confirmado TW:WH |
| Empire Recruit | Recruta Imperial | |
| Prison Guard | Guarda Prisional | Para NPCs de cidades |
| Townsman | Cidadão | Para NPCs de cidades |
| Trader / Merchant | Comerciante | Para NPCs de cidades |

### Mecânicas de Jogo

| Termo Original | Tradução | Notas |
| :--- | :--- | :--- |
| Warp / Imaterium | Warp / O Imatério | Manter "Warp" em contexto técnico |
| Winds of Magic | Ventos da Magia | |
| Lore of Magic | Saber da Magia | Ex: Saber do Fogo |
| Spellcraft | Arte Arcana | |
| Miscast | Falha de Conjuração | |
| Winds of Magic recharge | Recarga dos Ventos | |
| Oath Gold | Ouro do Juramento | |
| Ward Save | Salvaguarda | Bônus contra qualquer tipo de dano |
| Cleave | Trespassar | Atributo de arma que acerta múltiplos inimigos |
| Enchantment Blueprint | Projeto de Encantamento | Pergaminho que ensina uma receita |
| Swing Speed | Velocidade de Ataque | Usado em StatsTuple |
| Missile Speed | Velocidade de Projétil | |
| Armor Penetration | Penetração de Armadura | |
| Shield HP / Shield Health | PV do Escudo | |
| Physical / Magical / Fire damage | Dano físico / mágico / de fogo | Minúsculo salvo início de frase |
| Stackable | Acumulável | Quando o efeito se acumula |
| Unaware enemies | Inimigos desprevenidos | Para efeitos de ataque furtivo |

---

## PROGRESSO

> Regra: marque `[x]` imediatamente após concluir. Nunca pule um item.

---

### FASE 1 — Arquivos GameText (saída em Languages/BR/)

#### 1.1 tor_concept_strings.xml — Conceitos e Tooltips
**Fonte:** `ModuleData/tor_concept_strings.xml` | 28 linhas
**Saída:** `ModuleData/Languages/BR/tor_concept_strings_ptbr.xml` (criar do zero)
**Uma única chamada — 28 linhas.**

- [x] C01 — linhas 1–28

---

#### 1.2 tor_voiced_strings.xml — Diálogos de Raças
**Fonte:** `ModuleData/tor_voiced_strings.xml` | 218 linhas
**Saída:** `ModuleData/Languages/BR/tor_voiced_strings_ptbr.xml` (criar do zero)

- [x] V01 — linhas 1–218

---

#### 1.3 tor_strings.xml — Strings Principais
**Fonte:** `ModuleData/tor_strings.xml` | ~~6.257 linhas~~ → **6.281 linhas** (update do mod adicionou 17 strings de Diplomacia)
**Saída:** `ModuleData/Languages/BR/tor_strings_ptbr.xml` (criar com S01, acumular nos seguintes)

- [x] S01 — linhas 1–265 -> **CONCLUÍDO**
- [x] S02 — linhas 266–550 -> **CONCLUÍDO**
- [x] S03 — linhas 551–817 (Encantamentos) -> **CONCLUÍDO**
- [x] S04 — linhas 817–1136 (Guildas Dawi, Ouro do Juramento, Quest de Engenharia) -> **CONCLUÍDO**
- [x] S05 — linhas 1137–1500 *(Encontros Customizados, Grail Knight / Mercenary / Grail Damsel dialogs, início Diálogos de Cultura)* -> **CONCLUÍDO**
- [x] S06 — linhas 1500–1944 -> **CONCLUÍDO** *(Diálogos de Cultura — continuação)*
- [x] S07 — linhas 1945–2215 *(Skills/Crafting/Inventário/Party Screen, Assentamentos Customizados, Village Types, Wanderer Stories)* -> **CONCLUÍDO**
- [x] S08 — linhas 2215–2471 *(Companheiros do Império: Bright Wizard, Warrior Priest, Witch Hunter, Light Wizard, Celestial Wizard, Engineer, Priestess of Shallya, Huntsman, Metal Wizard, Life Wizard, Beast Wizard, Priest of Ulric, Captain, Imperial Noble)* -> **CONCLUÍDO**
- [x] S09 — linhas 2471–2773 *(Companheiros: Vampiros 0–4, Bretônia 0–5, Mousillon 0–4)* -> **CONCLUÍDO**
- [x] S10 — linhas 2773–3040 *(Companheiros: Eonir 0–2, Wood Elf 0–2, Dwarf 0–2, Greenskin 0–3, Chaos 0)* -> **CONCLUÍDO**
- [x] S11 — linhas 3040–3468 *(Religiões, Career related, Nomes de Grupos de Escolha de Carreira por classe)* -> **CONCLUÍDO**
- [x] S12 — linhas 3468–3693 *(Descrições de Carreira: Warrior Priest, Warrior Priest of Ulric, Witch Hunter, Imperial Magister, Knight of the Old World)* -> **CONCLUÍDO**
- [x] S13 — linhas 3693–4053 *(Descrições de Carreira: Mercenary, Necromancer, Vampire Count, Blood Knight, Necrarch, Grail Knight, Grail Damsel, Black Grail Knight)* -> **CONCLUÍDO**
- [x] S14 — linhas 4053–4534 *(Descrições de Carreira: Waywatcher, Spellsinger, Warden, Grey Lord, Ironbreaker, Slayer, Runelord, Orc Boss, Orc Shaman)* -> **CONCLUÍDO**
- [x] S15 — linhas 4534–4998 *(Desbloqueios de Carreira, Recompensas, Purity Seal, Spell Damage Display, Damage Types, Career Perks, Recursos Customizados, Chivalry, Oath Gold, Forest Harmony)* -> **CONCLUÍDO**

> [!NOTE]
> **Por que S16–S19 estão concluídos antes de S05–S15?** Numa sessão anterior, a tradução foi iniciada pelo final do arquivo (eventos narrativos), pois eram os mais urgentes para o jogador. Retomar **sempre pelo primeiro bloco sem `[x]`** — atualmente é o **S20**.

- [x] S16 — linhas 4998–5395 (Eventos Narrativos: Battlefield, Cabin, Fair, Duel, Overturned Cart; Sistema Hireling) -> **100%**
- [x] S17 — linhas 5395–5625 (Prestige Noble, Construções, Mecânicas Peles-verdes, Blood Keep) -> **100%**
- [x] S18 — linhas 5625–5865 (Diálogos de Blood Kiss, Spell Trainers, Quests de Classe) -> **100%**
- [x] S19 — linhas 5865–6257 (Powerstones, Runas de Unidade, Enciclopédia, Personagem, Diplomacia) -> **100%**
- [x] S20 — linhas 6258–6281 *(Diplomacia: tor_alliance_*, tor_trade_*, tor_stats_troll_bonus_text — 17 strings adicionadas após update do mod)* -> **CONCLUÍDO**

---

### FASE 2 — Arquivos Inline (edição direta)

#### 2.1 tor_specialization_options.xml — Escolas de Magia & Especializações
**Arquivo:** `ModuleData/tor_custom_xmls/tor_specialization_options.xml` | 410 linhas
**Editar diretamente:** `<Name>`, `<Description>`, `<PositiveEffect>`, `<NegativeEffect>`

- [x] E01 — linhas 1–210 (Escolas de Magia — Ventos de Ghyran, Aqshy, Shyish, Hysh, Azyr, Ghur, Chamon; Linhagens de Vampiros) -> **CONCLUÍDO**
- [x] E02 — linhas 211–410 (Vampiros de Mousillon; Sacerdotes Guerreiros; Ordens de Cavalaria) -> **CONCLUÍDO**

---
#### 2.2 tor_cc_options.xml — Criação de Personagem
**Arquivo:** `ModuleData/tor_custom_xmls/tor_cc_options.xml` | 1.563 linhas
**Editar diretamente:** `<OptionText>` e `<OptionFlavourText>`

- [x] CC01 — linhas 1–400
- [x] CC02 — linhas 401–800
- [x] CC03 — linhas 801–1200 -> **CONCLUÍDO**
- [x] CC04 — linhas 1201–1563 -> **CONCLUÍDO**

#### 2.3 tor_itemtraits.xml — Traços, Encantos, Runas, Livros e Blueprints
**Arquivo:** `ModuleData/tor_custom_xmls/tor_itemtraits.xml` | ~~4.672 linhas~~ → **4.406 linhas** (mod removeu ~266 linhas em update — tail verificado, tradução integral ainda presente)
**Editar diretamente:** `<ItemTraitName>` e `<ItemTraitDescription>`

> O arquivo contém **4 tipos de conteúdo** — todos usam as mesmas tags, mas com semântica diferente:
> - **Enchantments** (`emp_enchant_*`, `we_enchant_*`, etc.) — encantamentos de armas/armaduras
> - **Runes** (`dw_rune_*`, `dw_master_rune_*`) — runas anãs gravadas em equipamentos
> - **Skill Books** (`learn_engineering`, `learn_bow`, etc.) — livros consumíveis que dão XP de perícia
> - **Enchantment Blueprints** (`learn_emp_enchant_*`) — pergaminhos que ensinam receitas de encantamento por Vento da Magia

- [x] T01 - Encantamentos Gerais e de Magia (Linhas 1-100)
- [x] T02 - Encantamentos do Império I (Linhas 101-200)
- [x] T03 - Encantamentos do Império II (Linhas 201-300)
- [x] T04 - Encantamentos Hysh (Linhas 301-443)
- [x] T05 - Encantamentos Ghyran/Aqshy (Linhas 444-600)
- [x] T06 - Encantamentos Chamon/Azyr (Linhas 601-720)
- [x] T07 - Encantamentos Shyish/Sigmar (Linhas 721-801)
- [x] T08 - Bênçãos de Ulric/Shallya (Linhas 802-963)
- [x] T09 - Bênçãos da Bretônia (Linhas 964-1039)
- [x] T10 - Encantamentos de Vampiros (Linhas 1040-1200)
- [x] T11 - Elfos Silvestres, Altos Elfos e Peles-verdes (Linhas 1201-1600)
- [x] T12 - Runas Anãs e Livros de Skill (Linhas 1601-2000)
- [x] T13 - Bloco 13 de Traços (Linhas 2001-2400) -> **CONCLUÍDO**
- [x] T14 - Bloco 14 de Traços (Linhas 2401-2800) -> **CONCLUÍDO**
- [x] T15 - Bloco 15 de Traços (Linhas 2801-3200) -> **CONCLUÍDO**
- [x] T16 - Bloco 16 de Traços (Linhas 3201-3600) -> **CONCLUÍDO**
- [x] T17 - Bloco 17 de Traços (Linhas 3601-4000) -> **CONCLUÍDO**
- [x] T18 - Bloco 18 de Traços (Linhas 4001-4400) -> **CONCLUÍDO**
- [x] T19 - Bloco 19 de Traços (Linhas 4401-4406) -> **CONCLUÍDO** (arquivo encolheu para 4.406 linhas após update; tail verificado traduzido)

---

### FASE 3 — Eventos Narrativos (Ink, edição direta)

**Diretório:** `3025574678/InkStories/` | ~128 linhas por arquivo
**Cada arquivo = uma chamada.**
**Não traduzir:** `include.ink` (funções técnicas) e `Template.ink` (template vazio).

> **Nota Técnica:** Os eventos abaixo, originalmente listados como arquivos `.ink`, foram integrados ao `tor_strings.xml` (Blocos S16-S18). Traduzir via sistema GameText.
> Battlefield, BlessingsOfMen, CabinInTheWoodsLocked, CampFireLearning, CultistInOurMidst, DawiAndRuneMagic, Duel, EnchantingAndArtifacts, Fair, FozzriksFortress, Meadow, Minstrel, Miracle, MorrsliebWaxes, NurgleCultists, OrcBossQuest1, OrcBossQuest2, OrcEnchantmentStone, OrcShamanPrayerPrompt, OrcShamanQuest1InitialVision, OrcShamanQuest2InitialVision, OverturnedCart, Pond, ProtectOurDead, TheHangedMen, TravelingMerchant.

---

### FASE 4 — Arquivos Adicionais (Missing Files)

#### 4.1 tor_ror_settlement_templates.xml — Regimentos de Renome
**Fonte:** `ModuleData/tor_custom_xmls/tor_ror_settlement_templates.xml` | 260 linhas
**Saída:** `ModuleData/Languages/BR/tor_ror_settlement_templates_ptbr.xml` (criar)

- [x] R01 — linhas 1–260 -> **CONCLUÍDO**

#### 4.2 tor_abilitytemplates.xml — Habilidades e Feitiços
**Fonte:** `ModuleData/tor_custom_xmls/tor_abilitytemplates.xml` | 6.070 linhas
**Saída:** `ModuleData/Languages/BR/tor_abilitytemplates_ptbr.xml` (criar)

- [x] A01 — Bloco 1 de Habilidades (Linhas 1-500) -> **CONCLUÍDO**
- [x] A02 — Bloco 2 de Habilidades (Linhas 501-1000) -> **CONCLUÍDO**
- [x] A03 — Bloco 3 de Habilidades (Linhas 1001-1500) -> **CONCLUÍDO**
- [x] A04 — Bloco 4 de Habilidades (Linhas 1501-2000) -> **CONCLUÍDO**
- [x] A05 — Bloco 5 de Habilidades (Linhas 2001-2500) -> **CONCLUÍDO**
- [x] A06 — Bloco 6 de Habilidades (Linhas 2501-3000) -> **CONCLUÍDO**
- [x] A07 — Bloco 7 de Habilidades (Linhas 3001-3500) -> **CONCLUÍDO**
- [x] A08 — Bloco 8 de Habilidades (Linhas 3501-4000) -> **CONCLUÍDO**
- [x] A09 — Bloco 9 de Habilidades (Linhas 4001-4500) -> **CONCLUÍDO**
- [x] A10 — Bloco 10 de Habilidades (Linhas 4501-5000) -> **CONCLUÍDO**
- [x] A11 — Bloco 11 de Habilidades (Linhas 5001-5500) -> **CONCLUÍDO**
- [x] A12 — Bloco 12 de Habilidades (Linhas 5501-6070) -> **CONCLUÍDO**

**STATUS FINAL: 100% TRADUZIDO**

---

### FASE 5 — Arquivos GameText Adicionais (descobertos em auditoria 17/04/2026)

> Esses arquivos usam `{=KEY}Texto` mas **não estão em `tor_strings.xml`** — cada um precisa de um arquivo de saída separado em `Languages/BR/` e registro no `language_data.xml`.
> O usuário deve decidir a prioridade de cada bloco conforme o escopo do projeto.
> Ver **Tipo 4** na seção TIPOS DE ARQUIVO para o formato de fonte e saída.

> [!IMPORTANT]
> **Antes de iniciar qualquer bloco da FASE 5** — dois passos obrigatórios:
>
> **Passo 1 — Descomentar no `.gitignore`** (raiz do repositório, fora de `3025574678/`):
> Localizar a linha comentada correspondente ao arquivo e remover o `# ` do início.
> Exemplo para TD01: `# !3025574678/ModuleData/tor_troopdefinitions.xml` → `!3025574678/ModuleData/tor_troopdefinitions.xml`
>
> **Passo 2 — Adicionar entrada no `language_data.xml`:**
> Arquivo: `3025574678/ModuleData/Languages/language_data.xml`
> Adicionar uma linha `<LanguageFile>` antes de `</LanguageData>`:
> ```xml
> <LanguageFile xml_path="BR/tor_troopdefinitions_ptbr.xml" />
> ```
> (substituir `tor_troopdefinitions_ptbr.xml` pelo nome do arquivo de saída do bloco atual)
>
> Só então iniciar a tradução e criar o arquivo de saída em `Languages/BR/`.

#### 5.1 tor_troopdefinitions.xml — Nomes de Tropas
**Arquivo:** `ModuleData/tor_troopdefinitions.xml` | 5.389 linhas | **432 chaves GameText**
**Saída:** `Languages/BR/tor_troopdefinitions_ptbr.xml` (criar)
**Exemplos:** `Empire Recruit`, `Bright Wizard`, `Ironbreaker`, `Orc Boss` — visíveis na tela de batalha e exército.

- [x] TD01 — todas as 432 entradas de nomes de tropa -> **100%**

---

#### 5.2 tor_townspeople — Papéis de NPCs nas Cidades
**Arquivos:** `ModuleData/tor_townspeople/*.xml` (12 arquivos) | total: **309 chaves GameText**
**Saída:** `Languages/BR/tor_townspeople_ptbr.xml` (criar, consolidar os 12 arquivos em um)
**Exemplos:** `Prison Guard`, `Townsman`, `Trader`, `Cautious imperial merchant` — visíveis em interações nas cidades.

- [x] TP01 — todas as 309 entradas de papéis e descrições de NPCs -> **100%**

---

#### 5.3 tor_kingdoms.xml — Reinos e Títulos
**Arquivo:** `ModuleData/tor_kingdoms.xml` | 1.294 linhas | **275 chaves GameText**
**Saída:** `Languages/BR/tor_kingdoms_ptbr.xml` (criar)
**Nota:** Incluir apenas `name=`, `shortname=`, `title=`, `rulertitle=`. Os campos `text=` são descrições enciclopédicas de lore — excluídos por escopo.
**Exemplos visíveis:** `Averland`, `Empire of Men`, `Elector Count` (no mapa e diplomacia).

- [x] KG01 — nomes e títulos dos reinos (excluir campos `text=`) -> **100%**

---

#### 5.4 tor_clans.xml — Clãs
**Arquivo:** `ModuleData/tor_clans.xml` | 1.789 linhas | **284 chaves GameText**
**Saída:** `Languages/BR/tor_clans_ptbr.xml` (criar)
**Nota:** Verificar quais campos são nomes próprios (não traduzir) vs. títulos/descrições (traduzir).

- [x] CL01 — nomes dos clãs (excluir campos `text=`) -> **100%**

---

#### 5.5 tor_npccharacters — Lordes e Templates de Companheiros
**Arquivos:** `ModuleData/tor_npccharacters/tor_campaign_lords.xml` (751 chaves) e `tor_charactertemplates.xml` (154 chaves)
**Saída:** `Languages/BR/tor_npccharacters_ptbr.xml` (criar)
**Nota:** São nomes com títulos (`Elector Count Marius Leitdorf`, `Supreme Patriarch Balthazar Gelt`). Traduzir apenas títulos, manter nomes próprios.

- [x] NPC01 — títulos de lordes e templates -> **100%**

---

#### 5.6 tor_religions.xml — Religiões
**Arquivo:** `ModuleData/tor_religions.xml` | 559 linhas | **24 chaves GameText** (pequeno)
**Saída:** `Languages/BR/tor_religions_ptbr.xml` (criar)

- [x] REL01 — 24 nomes de religiões -> **100%**

---

#### 5.7 tor_cultures.xml — Nomes de Facções/Culturas
**Arquivo:** `ModuleData/tor_cultures.xml` | 7.385 linhas | **93 chaves relevantes** (de 5.470 totais)
**Nota importante:** 5.377 das 5.470 chaves são **listas de nomes próprios de personagens** (_male_*, _female_*, _last_*) — não traduzir, são nomes do universo Warhammer.
As 93 chaves restantes são nomes de facções/culturas visíveis no jogo (`Empire of Men`, `Vampire Counts`, `Greenskins`, etc.).
**Saída:** `Languages/BR/tor_cultures_ptbr.xml` (criar)

> [!NOTE]
> **Criação de personagem em inglês:** A tela de seleção de cultura na criação de personagem exibe os nomes em inglês porque `tor_cultures.xml` está registrado como `SPCultures` no `SubModule.xml` e ainda não foi traduzido. Concluir CU01 resolve esse problema — os nomes de facção/cultura passarão a aparecer em português nessa tela.

- [x] CU01 — ~93 nomes de facções e culturas (excluir listas de nomes _male_/_female_/_last_) -> **CONCLUÍDO**

---

> **Arquivos de baixíssima prioridade / decisão do usuário:**
> - `tor_lords.xml` — 17 chaves (nomes de lordes, quase todos nomes próprios)
> - `tor_settlements.xml` — 3.904 chaves (nomes de assentamentos — nomes próprios do universo Warhammer como "Altdorf", "Oak of Ages"; excluir salvo decisão contrária)

---

## ARQUIVOS EXCLUÍDOS

| Arquivo | Motivo |
| :--- | :--- |
| `tor_extendeditemproperties.xml` | Quase vazio; ~31 entradas com texto são extratos de livros in-universe (lore enciclopédico) |
| `Languages/VoicedLines/EN/PC/*.xml` | Dados de lip-sync (rhubarbResult), sem texto |
| `tor_extendedunitproperties.xml` | Dados de stats de unidades, sem texto |
| `tor_statuseffects.xml` | Dados de efeitos de status, sem texto |
| `tor_factionbanneroverrides.xml`, `tor_animation_triggers.xml`, `tor_config.xml` | Dados técnicos, sem texto |
| `tor_heroes.xml` | 751 chaves — todas são biografias enciclopédicas (`str_encyclopedia_*`), lore in-universe excluído por escopo |
| `tor_cultures.xml` listas de nomes | 5.377 chaves `_male_*/_female_*/_last_*` — nomes próprios do universo Warhammer, não traduzir |
| `tor_settlements.xml` | 3.904 chaves — nomes próprios de assentamentos Warhammer (Altdorf, Oak of Ages, etc.). Baixíssima prioridade salvo decisão do usuário |

---

## WORKFLOW PÓS-UPDATE DO MOD (Steam)

O Steam sobrescreve os arquivos originais → execute `git status` para ver o que mudou.

1. **Arquivos de linguagem (`tor_strings_ptbr.xml`, etc.):** Não precisa fazer nada. O Steam nunca criou esses arquivos, então nunca os sobrescreve.
2. **Arquivos editados inline (`tor_cc_options.xml`, `tor_itemtraits.xml`, etc.):**
   - Ver o que o Steam mudou: `git diff "3025574678/ModuleData/tor_custom_xmls/tor_cc_options.xml"`
   - Restaurar sua tradução (sobrescreve a versão nova do Steam): `git checkout "arquivo"`
   - Após restaurar, identifique entradas novas em inglês que ainda não existiam e adicione a tradução manualmente.

