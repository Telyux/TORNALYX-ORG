#!/usr/bin/env bash
set -Eeuo pipefail
TARGET=/var/www
if [[ $# -ge 1 ]]; then TARGET=$1; fi
LOG_DIR=/var/log/tornalyx-security
if [[ $EUID -ne 0 ]]; then echo "Ejecutá con sudo/root." >&2; exit 1; fi
mkdir -p "$LOG_DIR"; chmod 0750 "$LOG_DIR"
STAMP="$(date +%Y%m%d-%H%M%S)"; LOG="$LOG_DIR/clamav-$STAMP.log"
command -v freshclam >/dev/null 2>&1 || { echo "ClamAV/freshclam no está instalado." >&2; exit 1; }
command -v clamscan >/dev/null 2>&1 || { echo "clamscan no está instalado." >&2; exit 1; }
freshclam >>"$LOG" 2>&1
set +e
clamscan -r --infected --no-summary "$TARGET" >>"$LOG" 2>&1
SCAN_STATUS=$?
set -e
if [[ $SCAN_STATUS -eq 0 ]]; then echo "Sin detecciones. Log: $LOG"
elif [[ $SCAN_STATUS -eq 1 ]]; then echo "ATENCIÓN: detecciones; no se borró nada. Revisá $LOG." >&2
else echo "ClamAV terminó con error $SCAN_STATUS. Revisá $LOG." >&2; fi
exit "$SCAN_STATUS"
