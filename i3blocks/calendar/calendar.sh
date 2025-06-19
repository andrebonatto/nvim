#!/bin/bash

# Se clicou com o botão esquerdo
if [ "$BLOCK_BUTTON" -eq 1 ]; then
  # Obtém resolução da tela (largura x altura)
  screen_width=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d 'x' -f 1)

  # Define largura da janela do calendário
  width=250
  height=200
  top_margin=25 # Altura da barra de status i3 (ajuste se necessário)

  # Calcula a posição x (direita menos largura da janela - margem extra)
  pos_x=$((screen_width - width - 10))
  pos_y=$top_margin

  # Atraso leve para evitar perder o foco imediatamente
  (sleep 0.5 && yad --calendar \
    --title="Calendário" \
    --undecorated \
    --width=$width \
    --height=$height \
    --posx=$pos_x \
    --posy=$pos_y \
    --no-buttons \
    --close-on-unfocus) &
fi

# Mostra o texto do bloco (ícone + data)
date '+  %a, %d %b - %H:%M    '
