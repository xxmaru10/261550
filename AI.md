# Gerente de Tradução — Warhammer: The Old Realms (PT-BR)

Objetivo: traduzir apenas o conteúdo com o qual o jogador interage diretamente (diálogos, explicações de mecânicas, eventos narrativos, escolhas de personagem). Lore enciclopédico e dados técnicos são excluídos.

---

> [!IMPORTANT]
> **AUDITORIA DE PROGRESSO (14/04/2026 — atualizado 16:40):** Sessão focada em `tor_itemtraits.xml`. Blocos T01–T12 traduzidos e integrados ao arquivo local (linhas 1–2001). O arquivo local está XML válido com tag `</ItemTraits>` de fechamento. Próximo passo: retomar em T13 (linha 2001 da Steam = Livros de Arma + Blueprints de Encantamento do Império).

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

- [x] Criado `3025574678/ModuleData/Languages/BR/language_data.xml` — registra os arquivos PT-BR no jogo
- [x] Criar `3025574678/ModuleData/Languages/BR/tor_concept_strings_ptbr.xml` ← primeiro a fazer
- [x] Criar `3025574678/ModuleData/Languages/BR/tor_voiced_strings_ptbr.xml`
- [x] Criado `3025574678/ModuleData/Languages/BR/tor_strings_ptbr.xml` — **PARCIAL**: contém apenas descrições e nomes de cultura (linhas 1197–1216 do tor_strings.xml). Ao trabalhar nos blocos S04/S05, verificar se os IDs já estão no arquivo antes de re-traduzir.

O `language_data.xml` já existe com o seguinte conteúdo (não alterar):
```xml
<?xml version="1.0" encoding="utf-8"?>
<LanguageData id="Português (BR)">
  <LanguageFile xml_path="BR/tor_strings_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_voiced_strings_ptbr.xml" />
  <LanguageFile xml_path="BR/tor_concept_strings_ptbr.xml" />
</LanguageData>
```

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

| Termo Original | Tradução | Notas |
| :--- | :--- | :--- |
| The Empire | O Império | I maiúsculo sempre |
| Warp / Imaterium | Warp / O Imatério | Manter "Warp" em contexto técnico |
| Witch Hunter | Caçador de Bruxas | |
| Winds of Magic | Ventos da Magia | |
| Chaos | Caos | |
| Sigmar | Sigmar | Não traduzir |
| Old Ones | Antigos | |
| Greenskins | Peles-verdes | |
| Lore of Magic | Saber da Magia | Ex: Saber do Fogo |
| State Troops | Tropas Estaduais | |
| Spellcraft | Arte Arcana | |
| Miscast | Falha de Conjuração | |
| Winds of Magic recharge | Recarga dos Ventos | |
| Career | Carreira | |
| Oath Gold | Ouro do Juramento | |
| Grail Knight | Cavaleiro do Graal | |
| Runelord | Senhor das Runas | |
| Ironbreaker | Quebra-Ferro | |
| Slayer | Matador | |
| Warden | Guardião | |
| Grey Lord | Senhor Cinza | |

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
**Fonte:** `ModuleData/tor_strings.xml` | 6.257 linhas
**Saída:** `ModuleData/Languages/BR/tor_strings_ptbr.xml` (criar com S01, acumular nos seguintes)

- [x] S01 — linhas 1–265 -> **CONCLUÍDO**
- [x] S02 — linhas 266–550 -> **CONCLUÍDO**
- [x] S03 — linhas 551–817 (Encantamentos) -> **CONCLUÍDO**
- [x] S04 — linhas 817–1136 (Guildas Dawi, Ouro do Juramento, Quest de Engenharia) -> **CONCLUÍDO**
- [ ] S05 — linhas 1137–1500 *(Encontros Customizados, Grail Knight / Mercenary / Grail Damsel dialogs, início Diálogos de Cultura)* — **ATENÇÃO: linhas 1197–1216 (nomes e descrições de cultura) já traduzidos no tor_strings_ptbr.xml — pular esses IDs**
- [ ] S06 — linhas 1500–1944 *(Diálogos de Cultura — continuação)*
- [ ] S07 — linhas 1945–2215 *(Skills/Crafting/Inventário/Party Screen, Assentamentos Customizados, Village Types, Wanderer Stories)*
- [ ] S08 — linhas 2215–2471 *(Companheiros do Império: Bright Wizard, Warrior Priest, Witch Hunter, Light Wizard, Celestial Wizard, Engineer, Priestess of Shallya, Huntsman, Metal Wizard, Life Wizard, Beast Wizard, Priest of Ulric, Captain, Imperial Noble)*
- [ ] S09 — linhas 2471–2773 *(Companheiros: Vampiros 0–4, Bretônia 0–5, Mousillon 0–4)*
- [ ] S10 — linhas 2773–3040 *(Companheiros: Eonir 0–2, Wood Elf 0–2, Dwarf 0–2, Greenskin 0–3, Chaos 0)*
- [ ] S11 — linhas 3040–3468 *(Religiões, Career related, Nomes de Grupos de Escolha de Carreira por classe)*
- [ ] S12 — linhas 3468–3693 *(Descrições de Carreira: Warrior Priest, Warrior Priest of Ulric, Witch Hunter, Imperial Magister, Knight of the Old World)*
- [ ] S13 — linhas 3693–4053 *(Descrições de Carreira: Mercenary, Necromancer, Vampire Count, Blood Knight, Necrarch, Grail Knight, Grail Damsel, Black Grail Knight)*
- [ ] S14 — linhas 4053–4534 *(Descrições de Carreira: Waywatcher, Spellsinger, Warden, Grey Lord, Ironbreaker, Slayer, Runelord, Orc Boss, Orc Shaman)*
- [ ] S15 — linhas 4534–4998 *(Desbloqueios de Carreira, Recompensas, Purity Seal, Spell Damage Display, Damage Types, Career Perks, Recursos Customizados, Chivalry, Oath Gold, Forest Harmony)*
- [x] S16 — linhas 4998–5395 (Eventos Narrativos: Battlefield, Cabin, Fair, Duel, Overturned Cart; Sistema Hireling) -> **100%**
- [x] S17 — linhas 5395–5625 (Prestige Noble, Construções, Mecânicas Peles-verdes, Blood Keep) -> **100%**
- [x] S18 — linhas 5625–5865 (Diálogos de Blood Kiss, Spell Trainers, Quests de Classe) -> **100%**
- [x] S19 — linhas 5865–6257 (Powerstones, Runas de Unidade, Enciclopédia, Personagem, Diplomacia) -> **100%**

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
- [ ] CC03 — linhas 801–1200
- [ ] CC04 — linhas 1201–1563

---

#### 2.3 tor_itemtraits.xml — Traços e Encantos de Itens
**Arquivo:** `ModuleData/tor_custom_xmls/tor_itemtraits.xml` | 4.672 linhas
**Editar diretamente:** `<ItemTraitName>` e `<ItemTraitDescription>`

- [x] T01 - Traços Gerais (Linhas 1-100)
- [x] T02 - Traços de Combate I (Linhas 101-200)
- [x] T03 - Traços de Combate II (Linhas 201-300)
- [x] T04 - Encantamentos Hysh (Linhas 301-443)
- [x] T05 - Encantamentos Ghyran/Aqshy (Linhas 444-600)
- [x] T06 - Encantamentos Chamon/Azyr (Linhas 601-720)
- [x] T07 - Encantamentos Shyish/Sigmar (Linhas 721-801)
- [x] T08 - Bênçãos de Ulric/Shallya (Linhas 802-963)
- [x] T09 - Bênçãos da Bretônia (Linhas 964-1039)
- [x] T10 - Encantamentos de Vampiros (Linhas 1040-1200)
- [x] T11 - Elfos Silvestres, Altos Elfos e Peles-verdes (Linhas 1201-1600)
- [x] T12 - Runas Anãs e Livros de Skill (Linhas 1601-2000)
- [ ] T13 - Bloco 13 de Traços (Linhas 2001-2400)
- [ ] T14 - Bloco 14 de Traços (Linhas 2401-2800)
- [ ] T15 - Bloco 15 de Traços (Linhas 2801-3200)
- [ ] T16 - Bloco 16 de Traços (Linhas 3201-3600)
- [ ] T17 - Bloco 17 de Traços (Linhas 3601-4000)
- [ ] T18 - Bloco 18 de Traços (Linhas 4001-4400)
- [ ] T19 - Bloco 19 de Traços (Linhas 4401-4672)

---

### FASE 3 — Eventos Narrativos (Ink, edição direta)

**Diretório:** `3025574678/InkStories/` | ~128 linhas por arquivo
**Cada arquivo = uma chamada.**
**Não traduzir:** `include.ink` (funções técnicas) e `Template.ink` (template vazio).

> **Nota Técnica:** Os eventos abaixo, originalmente listados como arquivos `.ink`, foram integrados ao `tor_strings.xml` (Blocos S16-S18). Traduzir via sistema GameText.
> Battlefield, BlessingsOfMen, CabinInTheWoodsLocked, CampFireLearning, CultistInOurMidst, DawiAndRuneMagic, Duel, EnchantingAndArtifacts, Fair, FozzriksFortress, Meadow, Minstrel, Miracle, MorrsliebWaxes, NurgleCultists, OrcBossQuest1, OrcBossQuest2, OrcEnchantmentStone, OrcShamanPrayerPrompt, OrcShamanQuest1InitialVision, OrcShamanQuest2InitialVision, OverturnedCart, Pond, ProtectOurDead, TheHangedMen, TravelingMerchant.

---

## ARQUIVOS EXCLUÍDOS

| Arquivo | Motivo |
| :--- | :--- |
| `tor_extendeditemproperties.xml` | Quase vazio; ~31 entradas com texto são extratos de livros in-universe (lore enciclopédico) |
| `Languages/VoicedLines/EN/PC/*.xml` | Dados de lip-sync (rhubarbResult), sem texto |
| `tor_extendedunitproperties.xml` | Dados de stats de unidades, sem texto |
| `tor_statuseffects.xml` | Dados de efeitos de status, sem texto |
| `tor_factionbanneroverrides.xml`, `tor_animation_triggers.xml`, `tor_config.xml` | Dados técnicos, sem texto |

---

## WORKFLOW PÓS-UPDATE DO MOD (Steam)

O Steam sobrescreve os arquivos originais → execute `git status` para ver o que mudou.

1. **Arquivos de linguagem (`tor_strings_ptbr.xml`, etc.):** Não precisa fazer nada. O Steam nunca criou esses arquivos, então nunca os sobrescreve.
2. **Arquivos editados inline (`tor_cc_options.xml`, `tor_itemtraits.xml`, etc.):**
   - Ver o que o Steam mudou: `git diff "3025574678/ModuleData/tor_custom_xmls/tor_cc_options.xml"`
   - Restaurar sua tradução (sobrescreve a versão nova do Steam): `git checkout "arquivo"`
   - Após restaurar, identifique entradas novas em inglês que ainda não existiam e adicione a tradução manualmente.

## REGRA GERAL POR SESSÃO

Ao finalizar cada sessão de tradução, execute os comandos:
1. `git add [arquivos modificados]`
2. `git commit -m "traducao: [o que foi feito, ex: CC02 Bretonia+Wood Elves]"`
