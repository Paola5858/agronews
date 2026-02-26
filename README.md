# Raiz

> "quem planta sem visão, colhe sorte. quem planta com sistema, colhe legado."

Plataforma editorial de inteligência estratégica para o agronegócio brasileiro.  
Não é um portal agrícola. É uma mente analítica aplicada ao campo.

---

## conceito

O maior problema do agro não é o clima. É a falta de visão.

Raiz é um app de notícias que trata o agronegócio como xadrez, não como plantio.  
Cada decisão é uma jogada. Cada safra é uma partida. Quem não percebe as eras, vira figurante.

---

## stack

- **Flutter 3.x** — multiplataforma nativa
- **Provider** — gerenciamento de estado reativo
- **Google Fonts** — Cormorant Garamond (títulos) + Lora (corpo) + Montserrat (UI)
- **Cached Network Image + Shimmer** — carregamento elegante
- **Material 3** — design system moderno

---

## arquitetura

```
lib/
├── core/
│   ├── theme/         → ThemeData light/dark com tipografia editorial
│   └── constants/     → paleta de cores com intenção
├── features/
│   ├── home/          → feed principal com filtros e destaque
│   ├── market/        → cotações (em desenvolvimento)
│   ├── strategy/      → xadrez do agro (decisões estratégicas)
│   └── profile/       → perfil do usuário
└── shared/
    ├── models/        → NewsModel com tempo de leitura
    └── data/          → mock de notícias temáticas
```

Responsabilidade única. Sem lógica de UI misturada com dados.

---

## como rodar

```bash
git clone https://github.com/Paola5858/agronews.git
cd agronews
flutter pub get
flutter run
```

**Requisitos:**
- Flutter 3.x ou superior
- Dart SDK 3.0+

---

## diferenciais

- **Tipografia editorial** — serif nos títulos, sans na UI (contraste intencional)
- **Glassmorphism no dark mode** — cards com transparência e borda sutil
- **Hero animations** — transição fluida entre lista e detalhe
- **Barra de progresso de leitura** — feedback visual na tela de detalhe
- **Clip path diagonal** — card de destaque com corte assimétrico
- **Categorias com identidade** — cada uma tem cor e propósito
- **Empty state com personalidade** — sem mensagens genéricas
- **Sol animado** — rotação infinita no widget de clima

---

## próximos passos

- [ ] integração com API de notícias
- [ ] sistema de favoritos com persistência local
- [ ] cotações de mercado em tempo real
- [ ] modo "campo" (tema terroso alternativo)
- [ ] notificações push para alertas estratégicos
- [ ] compartilhamento de notícias

---

## identidade

**Nome:** Raiz  
**Posicionamento:** gestão inteligente do agro, não folclore rural  
**Tom de voz:** direto, provocativo, estratégico  

Frases que definem:
- "o campo também tem eras. quem não percebe, vira figurante."
- "timing do plantio é o primeiro peão do tabuleiro."
- "uma fazenda sem dado é como um xadrez sem rainha."

---

**Desenvolvido com obsessão por arquitetura limpa e identidade visual.**
