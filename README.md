# Tradução PT-BR — Warhammer: The Old Realms

Tradução não-oficial do mod **The Old Realms** para Mount & Blade II: Bannerlord em **Português Brasileiro**.

Cobre conteúdo com o qual o jogador interage diretamente: criação de personagem, descrições de facção, eventos narrativos, diálogos e mecânicas. Lore enciclopédico não é traduzido.

---

## Como instalar

### 1. Encontre a pasta do mod

O mod fica dentro da pasta do Steam Workshop. O caminho padrão é:

```
C:\Program Files (x86)\Steam\steamapps\workshop\content\261550\3025574678\
```

Se o seu Steam está em outro disco ou pasta, o caminho muda o prefixo mas a estrutura `\steamapps\workshop\content\261550\3025574678\` é sempre igual.

> **Dica:** no Steam, clique com o botão direito no jogo → Propriedades → Ficheiros locais → Procurar ficheiros locais. A pasta do jogo estará em `...\Bannerlord\`. A pasta do mod fica em `...\steamapps\workshop\content\261550\3025574678\`.

### 2. Clone ou baixe os arquivos deste repositório

**Opção A — Git (recomendado, facilita receber atualizações):**
```bash
git clone <URL-deste-repo> traducao-tor
```

**Opção B — Download manual:**
Clique em **Code → Download ZIP** no GitHub e extraia.

### 3. Copie os arquivos para a pasta do mod

Copie os seguintes arquivos do repositório para dentro de `3025574678\`, respeitando os caminhos:

#### Arquivos novos (criar pastas se não existirem)

| Arquivo no repositório | O que faz |
|---|---|
| `3025574678\ModuleData\Languages\BR\language_data.xml` | Registra o PT-BR no jogo |
| `3025574678\ModuleData\Languages\BR\tor_strings_ptbr.xml` | Descrições de facção, UI geral |
| `3025574678\ModuleData\Languages\BR\tor_voiced_strings_ptbr.xml` | Linhas de voz (quando traduzido) |
| `3025574678\ModuleData\Languages\BR\tor_concept_strings_ptbr.xml` | Conceitos do jogo (quando traduzido) |

#### Arquivos substituídos (sobrescrever o original)

| Arquivo no repositório | O que faz |
|---|---|
| `3025574678\ModuleData\tor_custom_xmls\tor_cc_options.xml` | Textos de criação de personagem |
| `3025574678\ModuleData\tor_custom_xmls\tor_itemtraits.xml` | Traços e descrições de itens (quando traduzido) |
| `3025574678\ModuleData\tor_custom_xmls\tor_specialization_options.xml` | Opções de especialização (quando traduzido) |
| `3025574678\InkStories\*.ink` | Eventos narrativos interativos (quando traduzido) |

> Arquivos marcados como "quando traduzido" já estão no repositório como fonte original em inglês — copie-os apenas quando a tradução deles estiver concluída (verifique a tabela de progresso abaixo).

A estrutura final dentro de `3025574678\ModuleData\Languages\` deve ficar assim:

```
ModuleData/
└── Languages/
    ├── language_data.xml          ← original em inglês (não mexer)
    └── BR/
        ├── language_data.xml      ← NOVO — registra PT-BR no jogo
        ├── tor_strings_ptbr.xml   ← NOVO — descrições de facção, UI
        ├── tor_voiced_strings_ptbr.xml   ← quando disponível
        └── tor_concept_strings_ptbr.xml  ← quando disponível
```

### 4. Configure o idioma no jogo

Para que as traduções de descrições de facção e UI apareçam em português:

1. Abra o Bannerlord
2. Vá em **Opções → Idioma → Português (BR)**
3. Reinicie o jogo se pedido

> **Nota:** os textos de criação de personagem (origem da família, vida anterior, carreira) e eventos narrativos aparecem em português independentemente do idioma configurado, pois são edição direta dos arquivos XML.

---

## O que já está traduzido

| Arquivo | Conteúdo | Status |
|---|---|---|
| `tor_cc_options.xml` | Criação de personagem — etapas 1, 2 e 3 | Parcial — Empire, VC, Bretônia, Mousillon, início Asrai |
| `tor_strings_ptbr.xml` | Nomes e descrições de todas as facções | Completo para seleção de facção |
| `tor_itemtraits.xml` | Traços e descrições de itens | Não iniciado |
| `tor_specialization_options.xml` | Opções de especialização de carreira | Não iniciado |
| `InkStories/*.ink` | Eventos narrativos (encontros, duelos, feiras…) | Não iniciado |

---

## Recebendo atualizações da tradução

Se você clonou com git, basta rodar:

```bash
cd traducao-tor
git pull
```

E copiar novamente os arquivos alterados para a pasta do mod.

---

## Atualizações do mod pelo Steam

Se o Steam atualizar o mod:

- Arquivos em `Languages\BR\` **não são apagados** — o Steam não os criou.
- Arquivos substituídos (`tor_cc_options.xml`, `.ink`, etc.) **podem ser sobrescritos** — basta copiar novamente do repositório.

---

## Contribuindo

Abra uma issue ou PR. A tradução é gerenciada pelo arquivo `AI.md` na raiz do repositório — qualquer IA consegue continuar o trabalho lendo esse arquivo.
