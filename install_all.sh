#!/bin/bash
set -e

SCRIPTS=(
  "00_install_dependencies.sh"
  "01_install_docker.sh"
  "02_install_docker_compose.sh"
  "03_clone_magma_repo.sh"
  "04_run_orchestrator.sh"
  "05_run_metrics.sh"
  "06_copy_certs.sh"
  "07_run_nms.sh"
)

display_menu() {
  echo "?? Select scripts to run:"
  for i in "${!SCRIPTS[@]}"; do
    printf "  [%d] %s\n" "$i" "${SCRIPTS[$i]}"
  done
  echo "  [a] Run all scripts"
  echo "  [q] Quit"
}

run_script() {
  script="${SCRIPTS[$1]}"
  if [ -f "$script" ]; then
    chmod +x "$script"
    echo "?? Running $script ..."
    ./"$script"
    echo ""
  else
    echo "? Script $script not found!"
  fi
}

main() {
  while true; do
    display_menu
    read -rp "Enter choice (e.g., 0 1 6 or a): " -a choices
    echo ""

    if [[ " ${choices[*]} " =~ " q " ]]; then
      echo "?? Exiting."
      exit 0
    elif [[ " ${choices[*]} " =~ " a " ]]; then
      for i in "${!SCRIPTS[@]}"; do
        run_script "$i"
      done
      break
    else
      for choice in "${choices[@]}"; do
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 0 ] && [ "$choice" -lt "${#SCRIPTS[@]}" ]; then
          run_script "$choice"
        else
          echo "?? Invalid choice: $choice"
        fi
      done
    fi
  done
}

main
