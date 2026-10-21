#!/usr/bin/env bash
set -Eeuo pipefail
if [[ $EUID -ne 0 ]]; then echo "Ejecutá con sudo/root." >&2; exit 1; fi
if ! command -v firewall-cmd >/dev/null 2>&1; then echo "firewalld no está instalado." >&2; exit 1; fi
if ! command -v sshd >/dev/null 2>&1; then echo "No se encontró sshd; abortando para evitar perder acceso remoto." >&2; exit 1; fi
SSH_PORT="$(sshd -T 2>/dev/null | awk '$1=="port"{print $2; exit}')"
if [[ -z "$SSH_PORT" ]]; then SSH_PORT=22; fi
echo "Puerto SSH detectado: $SSH_PORT"
echo "Se preservan reglas existentes y se agregan SSH/HTTP/HTTPS; no se abre MySQL."
read -r -p "Escribí APLICAR para continuar (cualquier otra cosa cancela): " confirm
[[ $confirm == "APLICAR" ]] || { echo "Cancelado sin cambios."; exit 0; }
systemctl enable --now firewalld
firewall-cmd --permanent --add-service=ssh
if [[ $SSH_PORT != "22" ]]; then firewall-cmd --permanent --add-port="$SSH_PORT/tcp"; fi
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload
firewall-cmd --list-all
echo "Probá una segunda sesión SSH antes de cerrar la sesión actual."
