#!/bin/bash

echo "  __  __         ____        _    __ _ _            "
echo " |  \/  |_   _  |  _ \  ___ | |_ / _(_) | ___  ___  "
echo " | |\/| | | | | | | | |/ _ \| __| |_| | |/ _ \/ __| "
echo " | |  | | |_| | | |_| | (_) | |_|  _| | |  __/\__ \ "
echo " |_|  |_|\__, | |____/ \___/ \__|_| |_|_|\___||___/ "
echo "         |___/                                      "
echo 

bash prepare.sh
echo
bash ide/main.sh
echo
bash terminal/main.sh
