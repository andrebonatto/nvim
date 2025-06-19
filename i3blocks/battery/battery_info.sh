#!/bin/sh

# If ACPI was not installed, this probably is a battery-less computer.
ACPI_RES=$(acpi -b)
ACPI_CODE=$?

if [ $ACPI_CODE -eq 0 ]; then
  # Filter out unavailable entries
  BAT_LEVEL_ALL=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9][0-9]?[0-9]?%")
  BAT_LEVEL=$(echo "$BAT_LEVEL_ALL" | awk -F"%" 'BEGIN{tot=0;i=0} {i++; tot+=$1} END{printf("%d%%\n", tot/i)}')
  BAT_PERCENT=${BAT_LEVEL%\%}
  TIME_LEFT=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9]{2}:[0-9]{2}:[0-9]{2}")
  IS_CHARGING=$(echo "$ACPI_RES" | grep -v "unavailable" | awk '{ printf("%s\n", substr($3, 0, length($3)-1) ) }')

  [ -z "$TIME_LEFT" ] && TIME_LEFT="00:00:00"
  TIME_LEFT=$(echo $TIME_LEFT | awk '{ printf("%s\n", substr($1, 0, 5)) }')

  # Escolhe o ícone apropriado
  if [ "$IS_CHARGING" = "Charging" ]; then
    BAT_ICON="󰂄"
  elif [ "$BAT_PERCENT" -ge 90 ]; then
    BAT_ICON="󰂂"
  elif [ "$BAT_PERCENT" -ge 45 ]; then
    BAT_ICON="󰁾"
  elif [ "$BAT_PERCENT" -le 15 ]; then
    BAT_ICON="󱃍"
  else
    BAT_ICON="󰁹"
  fi

  # Print full text (for i3blocks, waybar, etc.)
  echo "$BAT_ICON  $BAT_LEVEL 󱦟 $TIME_LEFT"

  # Print short text
  echo "BAT: $BAT_LEVEL"

  # Font color
  if [ "$IS_CHARGING" = "Charging" ]; then
    echo "#D0D000" # Amarelo
  elif [ "$BAT_PERCENT" -le 15 ]; then
    echo "#FA1E44" # Vermelho
  else
    echo "#007872" # Verde
  fi
fi
## If ACPI was not installed, this probably is a battery-less computer.
#ACPI_RES=$(acpi -b)
#ACPI_CODE=$?
#if [ $ACPI_CODE -eq 0 ]
#then
#    # Get essential information. Due to som bug with some versions of acpi it is
#    # worth filtering the ACPI result from all lines containing "unavailable".
#    BAT_LEVEL_ALL=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9][0-9]?[0-9]?%")
#    BAT_LEVEL=$(echo "$BAT_LEVEL_ALL" | awk -F"%" 'BEGIN{tot=0;i=0} {i++; tot+=$1} END{printf("%d%%\n", tot/i)}')
#    TIME_LEFT=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9]{2}:[0-9]{2}:[0-9]{2}")
#    IS_CHARGING=$(echo "$ACPI_RES" | grep -v "unavailable" | awk '{ printf("%s\n", substr($3, 0, length($3)-1) ) }')
#
#    # If there is no 'time left' information (when almost fully charged) we
#    # provide information ourselvs.
#    if [ -z "$TIME_LEFT" ]
#    then
#        TIME_LEFT="00:00:00"
#    fi
#
#    # Print full text. The charging data.
#    TIME_LEFT=$(echo $TIME_LEFT | awk '{ printf("%s\n", substr($1, 0, 5)) }')
#    echo "🔋$BAT_LEVEL ⏳$TIME_LEFT "
#
#    # Print the short text.
#    echo "BAT: $BAT_LEVEL"
#
#    # Change the font color, depending on the situation.
#    if [ "$IS_CHARGING" = "Charging" ]
#    then
#        # Charging yellow color.
#        echo "#D0D000"
#    else
##        if [ "${BAT_LEVEL%?}" -le 15 ]
#        then
#            # Battery very low. Red color.
#            echo "#FA1E44"
#        else
#            # Battery not charging but at decent level. Green color.
#            echo "#007872"
#        fi
#    fi
#fi
#
##!/bin/sh
