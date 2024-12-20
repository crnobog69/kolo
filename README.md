# <p align="center">📻 | Коло - Arch Package Finder</p>

</div>

<div align="center">

---

[Српски (🇷🇸)](README.md) | [English (🇬🇧)](README-en.md)

---

</div>

> [!WARNING]
> `kolo-en.sh` - се не одржава активно.

Интерактивни претраживач пакета за Arch Linux који користи [`fzf`](https://github.com/junegunn/fzf) за претрагу званичних репозиторијума и AUR-а.

---

## Употреба

```bash
chmod +x kolo.sh
```

---

### Претрага званичних репозиторијума

```bash
./kolo.sh
```

![Коло](assets/kolo.png)

### Претрага са AUR подршком

```bash
./kolo.sh --aur
```

![Коло AUR](assets/kolo-aur.png)

### Синхронизација базе пакета

```bash
./kolo.sh --sync
```

### Пример коришћења

```bash
./kolo.sh --aur --sync
```

## Захтеви

- fzf
- AUR помођник (`yay`/`paru`/`pikaur`/`trizen`/`aura`) за AUR подршку

```bash
sudo pacman -S --needed git base-devel fzf
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

---

<details>
<summary>Коло - Значење</summary>

- Коло (игра): Српски традиционални плес у кругу са ритмичким покретима, обично у друштву.

- Електрично коло: Пут за проток електричне струје, који укључује извор напајања и електронске компоненте.

</details>

---

## Остало

- [`crnobog/dotfiles`](https://github.com/crnobog69/dotfiles)

---
