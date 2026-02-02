SolarPunk Memvid

Video-based AI memory storage with built-in ethics.

## Why?
- **10x smaller** than vector databases
- **Portable MP4 files** work anywhere
- **Ethical scoring** in every frame
- **No servers, no cloud, no fees**

## Install:
```bash
pip install -r requirements.txt
Usage:
python
from solarpunk_memvid import SolarPunkMemvid

# Create ethical memory store
memory = SolarPunkMemvid("memories.mp4")

# Store with ethics
memory.store(
    data="Donated 50% to crisis.org",
    context="Redistribution",
    ethical_score=0.9
)

# Save as MP4
memory.save_video()

Features:
QR-encoded frames for data

Ethical score tracking

Portable video files

Search and retrieval

Seed creation for distribution

SolarPunk Principles:
Open Sovereignty: Run anywhere, no dependencies

Anti-Extraction: No vendor lock-in, no fees

Transparency: View memories in any video player

Regeneration: Ethical memories can seed new instances
