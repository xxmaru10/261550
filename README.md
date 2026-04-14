# Tradução PT-BR — Warhammer: The Old Realms

Tradução não-oficial do mod **The Old Realms** para Mount & Blade II: Bannerlord em **Português Brasileiro**.

Cobre conteúdo com o qual o jogador interage diretamente: criação de personagem, descrições de facção, diálogos e mecânicas. Lore enciclopédico não é traduzido.

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

**Opção A — Git (recomendado):**
```bash
git clone <URL-deste-repo> traducao-tor
```

**Opção B — Download manual:**  
Clique em **Code → Download ZIP** no GitHub e extraia.

### 3. Copie os arquivos para a pasta do mod

Copie os seguintes arquivos/pastas do repositório para dentro de `3025574678\`:

| Arquivo no repositório | Destino na pasta do mod |
|---|---|
| `3025574678\ModuleData\tor_custom_xmls\tor_cc_options.xml` | Substitui o arquivo existente |
| `3025574678\ModuleData\Languages\BR\language_data.xml` | Criar pasta `BR\` se não existir |
| `3025574678\ModuleData\Languages\BR\tor_strings_ptbr.xml` | Mesma pasta `BR\` |

A estrutura final dentro de `3025574678\ModuleData\Languages\` deve ficar assim:

```
ModuleData/
└── Languages/
    ├── language_data.xml        ← arquivo original (inglês, não mexer)
    └── BR/
        ├── language_data.xml    ← NOVO (registra o PT-BR no jogo)
        ├── tor_strings_ptbr.xml ← NOVO (descrições de facção, UI)
```

### 4. Configure o idioma no jogo

Para que as traduções de descrições de facção e UI apareçam em português:

1. Abra o Bannerlord
2. Vá em **Opções → Idioma → Português (BR)**
3. Reinicie o jogo se pedido

> **Nota:** os textos de criação de personagem (origem da família, vida anterior, carreira) aparecem em português independentemente do idioma configurado, pois são edição direta do arquivo XML.

---

## O que já está traduzido

| Arquivo | Conteúdo | Status |
|---|---|---|
| `tor_cc_options.xml` | Tela de criação de personagem — todas as facções (etapas 1, 2 e 3) | Parcial — Empire, VC, Bretônia, Mousillon, início Asrai |
| `tor_strings_ptbr.xml` | Nomes e descrições das facções na sela de seleção | Todas as facções jogáveis |

---

## Atualizações do mod pelo Steam

Se o Steam atualizar o mod, os arquivos da pasta `BR\` **não são apagados** (o Steam não os criou). Apenas `tor_cc_options.xml` pode ser sobrescrito — nesse caso, basta copiar novamente o arquivo deste repositório.

---

## Contribuindo

Abra uma issue ou PR. A tradução é gerenciada pelo arquivo `AI.md` na raiz do repositório.
