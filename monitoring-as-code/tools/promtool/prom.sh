VERSION=$(curl -Ls https://api.github.com/repos/prometheus/prometheus/releases/latest | jq ".tag_name" | xargs | cut -c2-)
