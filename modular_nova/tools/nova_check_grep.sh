#!/bin/bash

#ANSI Escape Codes for colors to increase contrast of errors
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

echo -e "${BLUE}Re-running grep checks, but looking in modular_nova...${NC}"

# Run the linters again, but modular Nova Sector code.
sed "s|code/\*\*/\*\.dm|modular_nova/\*\*/\*\.dm|g" <tools/ci/check_grep.sh | bash

# Run the linters again again but for our special funny code - THIS AND THE TWO LINES BELOW ARE LETHALSTATION EDITS BY THE WAY
echo -e "${BLUE}Re-running grep checks, but looking in modular_np_lethal...${NC}"
sed "s|code/\*\*/\*\.dm|modular_np_lethal/\*\*/\*\.dm|g" <tools/ci/check_grep.sh | bash
