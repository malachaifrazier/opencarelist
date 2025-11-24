# 🟭 OpenCareList

**OpenCareList** is an open-source, community-maintained directory of physicians who perform tubal sterilization and other permanent birth-control procedures without unnecessary barriers.
It began as an open data effort to preserve and expand the original crowd-sourced list compiled by **[Dr. Franziska Haydanek (Paging Dr. Fran)](https://linktr.ee/DrFran)** — a project dedicated to medical autonomy and transparent access to reproductive care.

## 🌍 Mission

Millions of people seeking permanent contraception face outdated gatekeeping, misinformation, and inconsistent provider access.
OpenCareList exists to:

- Provide a **searchable, verified database** of providers who respect patient autonomy.
- Empower patients with **accurate, transparent information**.
- Offer an **open API and data standard** for researchers, advocates, and developers.
- Uphold **credit to the original creators** and all community contributors.

## 🛡️ Tech Stack

| Component | Details |
|------------|----------|
| **Framework** | Ruby 3.4.5 + Rails 8.1.1 |
| **Auth** | Devise |
| **UI** | Bootstrap 5.3+ |
| **Database** | PostgreSQL |
| **Background Jobs** | Solid Queue / Sidekiq (configurable) |
| **Search** | PostgreSQL + pg_trgm |
| **Testing** | RSpec, FactoryBot, Faker, Shoulda-Matchers |

## 🧎🏼‍♂️ Core Features

- 🌐 Browse by **country → state/province → city**
- 🕵️‍♀️ **Filter by tags** (LGBTQ+ friendly, accepts Medicaid, language support, etc.)
- 🗓 **Submit or edit listings** (moderated queue)
- ✅ **Verification dashboard** for maintainers
- 🗜 **Geolocation search** (PostGIS optional)
- 📨 **Email verification reminders**
- 🔍 **Public API** for external tools
- 📻 **Attribution preserved** from the original Paging Dr Fran list

## 🥌 Setup (development)

```bash
git clone https://github.com/opencarelist/opencarelist.git
cd opencarelist
bundle install
rails db:create db:migrate
bin/dev
```

### Import sample data

```bash
rails import:master CSV=data/Gynecologists_with_links_MASTER.csv
```

*(see `/doc/DATA_IMPORT.md` for full schema notes)*

## 📚 Documentation

Comprehensive documentation lives in the [`/doc`](./doc) directory:

- [`ARCHITECTURE.md`](./doc/ARCHITECTURE.md) — system overview
- [`DATA_MODEL.md`](./doc/DATA_MODEL.md) — schema & relationships
- [`CONTRIBUTING.md`](./doc/CONTRIBUTING.md) — contributor onboarding
- [`ROADMAP.md`](./doc/ROADMAP.md) — planned milestones
- [`GOVERNANCE.md`](./doc/GOVERNANCE.md) — project decision structure

## 👩‍⚕️ Credits

- **Original dataset:** [Dr. Franziska Haydanek (Paging Dr. Fran)](https://linktr.ee/DrFran)
- **Project founder:** [@Malachai Frazier](https://github.com/malachai)
- **Contributors:** see [GitHub Contributors](../../graphs/contributors)

OpenCareList expands Dr. Fran’s work by maintaining a verifiable, open, and forkable codebase.
We remain deeply grateful for her leadership in making reproductive-health data public and accessible.

## 🤝 Contributing

We welcome contributions of code, data, docs, and design.

- Fork → branch → PR workflow (`feature/`, `fix/`, `docs/` naming).
- All PRs must include tests and documentation updates.
- Please read [`CONTRIBUTING.md`](./doc/CONTRIBUTING.md) before your first PR.
- Be kind. We follow the [Contributor Covenant](./CODE_OF_CONDUCT.md).

## ⚖️ License

MIT License © 2025 OpenCareList Contributors
Data under Creative Commons BY-SA 4.0.

> *OpenCareList is a volunteer project and does not provide medical advice. Always confirm information directly with providers.*

## 🌐 Links

- Website: [opencarelist.org](https://opencarelist.org)
- Alternate: [opencarelist.com](https://opencarelist.com)
- Original project: [Dr. Fran (Paging Dr. Fran)](https://linktr.ee/DrFran)
- GitHub: [github.com/opencarelist](https://github.com/opencarelist)

> _“Information is autonomy. Autonomy is care.”_
> — OpenCareList Motto
