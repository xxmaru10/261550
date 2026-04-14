# Gerente de Tradução — Warhammer: The Old Realms (PT-BR)

Objetivo: traduzir apenas o conteúdo com o qual o jogador interage diretamente (diálogos, explicações de mecânicas, eventos narrativos, escolhas de personagem). Lore enciclopédico e dados técnicos são excluídos.

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
- [ ] Criar `3025574678/ModuleData/Languages/BR/tor_concept_strings_ptbr.xml` ← primeiro a fazer
- [ ] Criar `3025574678/ModuleData/Languages/BR/tor_voiced_strings_ptbr.xml`
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

- [x] S01 — linhas 1–265 *(UI, Skills, Skill Effects, Traits, Perks, Ability System, SpellBook/PrayerBook UI, notificações, mensagens de combate)*
- [x] S02 — linhas 266–550 *(PULADA: já traduzida por outra IA)*
- [x] S03 — linhas 551–817 *(Sistema de Encantamento: UI geral, títulos, descrições, restrições, diálogos por cultura: Império, Bretônia, Sylvania, Mousillon, Anões, Peles-verdes, Elfos da Floresta, Eonir)*
- [ ] S04 — linhas 817–1136 *(Oath Gold, Rune Lord Guild, Guild info, Expedições, Cervejeiro, Warrior Guild, Engineer Guild, Tooltips)*
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
- [ ] S16 — linhas 4998–5395 *(Textos Ink/Eventos: Meadow, Battlefield, Cabin, Fair, Duel; Sistema Hireling/Mercenário)*
- [ ] S17 — linhas 5395–5625 *(Prestígio Nobre, Projetos de Construção/Políticos, Mecânicas Peles-verdes: Brawl, Goblin Recruitment, Bullying, Duel System, Blood Keep)*
- [ ] S18 — linhas 5625–5865 *(Quests: Orc Boss 1&2, Orc Shaman 1&2, Runesmith, Runelord, Engineer; Menus: Cursed Sites, Shrines, Oak of Ages, Chaos Portal, Troll Cave; Blood Kiss / Blood Dragon / Necrarch / Black Grail; Spell Trainer Dialogs)*
- [ ] S19 — linhas 5865–6257 *(Powerstones Lesser/Greater/Mighty, Unit Rune Texts, Career Choices, Attributes, Encyclopedia, Character Creation, Quartermaster, Skill Trainer, Priest Dialog, Artisan District, Hireling, Blood Kiss, Eonir Envoy Dialogs, Engineer Quest, Spelltrainer, Graveyard, Diplomacy)*

---

### FASE 2 — Arquivos Inline (edição direta)

#### 2.1 tor_specialization_options.xml — Escolas de Magia & Especializações
**Arquivo:** `ModuleData/tor_custom_xmls/tor_specialization_options.xml` | 410 linhas
**Editar diretamente:** `<Name>`, `<Description>`, `<PositiveEffect>`, `<NegativeEffect>`

- [x] E01 — linhas 1–210 *(Escolas de Magia: Ghyran/Vida, Aqshy/Fogo, Shyish/Morte, Chamon/Metal, Hysh/Luz, Azyr/Céus, Ghur/Feras, Ulgu/Sombras)*
- [ ] E02 — linhas 211–410 *(Especializações: Vampiros, Sacerdotes, Cavaleiros e demais)*

---

#### 2.2 tor_cc_options.xml — Criação de Personagem
**Arquivo:** `ModuleData/tor_custom_xmls/tor_cc_options.xml` | 1.563 linhas
**Editar diretamente:** `<OptionText>` e `<OptionFlavourText>`

- [x] CC01 — linhas 1–400
- [x] CC02 — linhas 401–800
- [x] CC03 — linhas 801–1200
- [x] CC04 — linhas 1201–1563

---

#### 2.3 tor_itemtraits.xml — Traços e Encantos de Itens
**Arquivo:** `ModuleData/tor_custom_xmls/tor_itemtraits.xml` | 4.672 linhas
**Editar diretamente:** `<ItemTraitName>` e `<ItemTraitDescription>`

- [ ] T01 — linhas 1–400
- [ ] T02 — linhas 401–800
- [ ] T03 — linhas 801–1200
- [ ] T04 — linhas 1201–1600
- [ ] T05 — linhas 1601–2000
- [ ] T06 — linhas 2001–2400
- [ ] T07 — linhas 2401–2800
- [ ] T08 — linhas 2801–3200
- [ ] T09 — linhas 3201–3600
- [ ] T10 — linhas 3601–4000
- [ ] T11 — linhas 4001–4400
- [ ] T12 — linhas 4401–4672

---

### FASE 3 — Eventos Narrativos (Ink, edição direta)

**Diretório:** `3025574678/InkStories/` | ~128 linhas por arquivo
**Cada arquivo = uma chamada.**
**Não traduzir:** `include.ink` (funções técnicas) e `Template.ink` (template vazio).

- [ ] Battlefield.ink
- [ ] BlessingsOfMen.ink
- [ ] CabinInTheWoodsLocked.ink
- [ ] CampFireLearning.ink
- [ ] CultistInOurMidst.ink
- [ ] DawiAndRuneMagic.ink
- [ ] Duel.ink
- [ ] EnchantingAndArtifacts.ink
- [ ] Fair.ink
- [ ] FozzriksFortress.ink
- [ ] Meadow.ink
- [ ] Minstrel.ink
- [ ] Miracle.ink
- [ ] MorrsliebWaxes.ink
- [ ] NurgleCultists.ink
- [ ] OrcBossQuest1.ink
- [ ] OrcBossQuest2.ink
- [ ] OrcEnchantmentStone.ink
- [ ] OrcShamanPrayerPrompt.ink
- [ ] OrcShamanQuest1InitialVision.ink
- [ ] OrcShamanQuest2InitialVision.ink
- [ ] OverturnedCart.ink
- [ ] Pond.ink
- [ ] ProtectOurDead.ink
- [ ] TheHangedMen.ink
- [ ] TravelingMerchant.ink

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
