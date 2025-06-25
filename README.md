# Magma v1.9 Orchestrator & NMS Installer (GCP-ready)

This script bundle automates the setup of Magma Orchestrator v1.9 and NMS on an Ubuntu server (tested on GCP VM).

## 📦 Contents

- **00–07 scripts**: Modular scripts to install dependencies, Docker, clone Magma, start Orchestrator, run metrics, copy certs, and start NMS
- **install_all.sh**: Master script that runs everything in order

## 🛠️ Usage

```bash
chmod +x install_all.sh
./install_all.sh
```

After installation:

- Log out and back in (or run `newgrp docker`)
- Access NMS via: `http://<YOUR_VM_IP>:8081/`

## 🔐 Notes

- Certs copied from `~/.cache/test_certs/` to `/var/opt/magma/certs/` with 777 for easy dev access
- You can modify individual scripts for custom behavior

Enjoy! 🚀
