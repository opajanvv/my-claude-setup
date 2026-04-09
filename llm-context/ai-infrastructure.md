# AI infrastructure

## Ollama on homelab server

Ollama runs on Proxmox CT 124 (192.168.144.62) with 12 vCPU and 24 GB RAM (CPU-only, no GPU).

**Stack:** Ollama + Caddy auth proxy + Open WebUI (Docker Compose in `~/dev/homelab-docker/ai/`)

**Access:**
- API: `https://ollama.janvv.nl` (requires Bearer token from `~/.config/ollama-api-key`)
- Web UI: `https://ai.janvv.nl` (Open WebUI with its own login)
- Internal path: Pi-hole DNS -> Caddy (192.168.144.31) -> auth proxy (192.168.144.62:11435) -> Ollama
- External path: Cloudflare tunnel -> auth proxy -> Ollama

**Anthropic API compatibility:** Ollama v0.14.0+ natively speaks the Anthropic Messages API at `/v1/messages`. Claude Code connects directly via `ANTHROPIC_BASE_URL` -- no litellm or other translation layer needed.

**Models installed:** qwen3-coder (30b MoE, code/agentic), qwen3:32b (general, best quality), qwen3:14b (general, faster), llama3, deepseek-r1

**Model selection notes:**
- Always verify a model tag exists before using it (`ollama list` or check ollama.com/library/MODEL/tags). Not all models have small variants (e.g. qwen3-coder only has 30b and 480b).
- Claude Code requires tool calling support. Models without it (e.g. llama3) will fail. qwen3 and qwen3-coder support tools; llama3.1+ supports tools but llama3 does not.

## Claude Code wrappers

Shell functions in `~/dev/mystrap/dotfiles/shell/.config/claude-wrappers.sh`:

| Command | Backend | Default model |
|---------|---------|---------------|
| `claude` | Anthropic API (subscription) | (account default) |
| `claude-glm` | Z.ai proxy | glm-4.7 |
| `claude-local` | Ollama on laptop (localhost:11434) | qwen3:8b |
| `claude-ollama` | Ollama on server (ollama.janvv.nl) | qwen3-coder |

## Ollama on laptop (local)

**Hardware:** Intel i7-11850H (8 cores/16 threads), 32 GB RAM, NVIDIA RTX A2000 Mobile (4 GB VRAM). The 4 GB VRAM is too small for most models -- Ollama offloads to CPU, so performance is similar to the server.

Ollama runs as a systemd service (`ollama.service`). Models installed: qwen3-coder (30b MoE, 3.3b active), llama3, phi. qwen3-coder only comes in 30b and 480b -- no smaller variant exists.

## Privacy and model choice

**Decision:** Use `claude` (Anthropic API) for all real work, including penningmeester. Local Ollama is for experimentation only.

**Why not local inference:** Both the server (CPU-only) and laptop (4 GB VRAM) produce multi-minute response times with capable models. A GPU upgrade (16+ GB VRAM) would cost more than years of API subscription.

**Privacy approach:** Sensitive data (bank IDs, amounts) is stripped before sending to the API. The codering commands only need descriptions and counterparty names (business names, generic text) -- no personal financial details. With training opt-out disabled at [claude.ai/settings/data-privacy-controls](https://claude.ai/settings/data-privacy-controls), Anthropic does not train on the data and retains it for only 30 days.
