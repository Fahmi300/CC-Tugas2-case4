#!/bin/sh

apt-get update
apt-get install -y wget
apt-get install -y jq
apt-get install -y default-mysql-client

URL="https://gold.g.apised.com/v1/latest?metals=XAU&base_currency=USD&currencies=IDR&weight_unit=gram"
LOKASI="/data"

MYSQL_HOST="mysql1"
MYSQL_USER="myuser"
MYSQL_PASSWORD="mydb6789tyui"
MYSQL_DATABASE="mydb"

echo "Script will run every $DELAY seconds."

while true; do
    date=$(date '+%Y-%m-%d_%H:%M:%S')
    echo "Processing at $date"
    fname="output_$date.json"

    wget --no-check-certificate --quiet \
        --method GET \
        --timeout=0 \
        --header "x-api-key: sk_23aA06117bCB9DD3A75b5f399b51be527347d28523243d98" \
        "$URL" -O "$fname"

    price=$(cat "$fname" | jq '.data.metal_prices.XAU.price')

    echo "Price: $price"

    mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE <<EOF
    INSERT INTO gold_price (price) VALUES ($price);
EOF

    sleep "$DELAY"
done
