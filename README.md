# magic-seedbox
✨ One-Click, Cloud-Powered Seedbox Magic ✨
# What you do:
1. Fork this repo  
2. Add cloud credentials as secrets  
3. Click "Run workflow"  

# What you get:
- 🚀 Auto-provisioned Kubernetes cluster (free-tier VM)  
- 🔒 WireGuard VPN + Traefik with Let's Encrypt HTTPS  
- 📊 Monitoring (Prometheus + Grafana)  
- 🧲 Torrent clients (qBittorrent/Transmission)  
- 🌐 Automatic DNS setup (Cloudflare)  

---

**Features**  
✅ **Zero Local Tools** – Entirely GitHub-driven  
✅ **Preconfigured Apps** – Traefik, WireGuard, qBittorrent, Prometheus  
✅ **Free-Tier Friendly** – Optimized for GCP/AWS/Oracle free tiers  
✅ **Auto-HTTPS** – Wildcard certs via Let's Encrypt  
✅ **Extensible** – Easily add Plex, Sonarr, Radarr via Helm  

---

**Quick Start**  
```markdown
1. � **Fork this repo**  
2. 🔑 **Add secrets**:  
   - `GCP_SA_KEY` (GCP Service Account JSON)  
   - `CLOUDFLARE_API_TOKEN`  
   - `DOMAIN` (e.g., `yourdomain.com`)  
3. 🚨 **Run the workflow**:  
   Actions → `magic-seedbox` → Run workflow  