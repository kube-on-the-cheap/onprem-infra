#!/bin/bash
# Script to find RouterOS resource IDs for import
# Usage: ./find_ids.sh

ROUTER="edge"

echo "==> Finding resource IDs on RouterOS device: $ROUTER"
echo ""

echo "=== Bridge Ports ==="
ssh $ROUTER -- '/interface/bridge/port print detail' | grep -E '(interface|^\s+[0-9])'

echo ""
echo "=== Interface Lists ==="
ssh $ROUTER -- '/interface/list print detail'

echo ""
echo "=== Interface List Members ==="
ssh $ROUTER -- '/interface/list/member print detail'

echo ""
echo "=== PPPoE Client ==="
ssh $ROUTER -- '/interface/pppoe-client print detail'

echo ""
echo "=== DHCP Server ==="
ssh $ROUTER -- '/ip/dhcp-server print detail'

echo ""
echo "=== DHCP Server Leases ==="
ssh $ROUTER -- '/ip/dhcp-server/lease print detail' | grep -E '(address|mac-address|comment|^\s+[0-9])'

echo ""
echo "=== DHCP Server Network ==="
ssh $ROUTER -- '/ip/dhcp-server/network print detail'

echo ""
echo "=== DHCP Server Options ==="
ssh $ROUTER -- '/ip/dhcp-server/option print detail'

echo ""
echo "=== DNS Static Records ==="
ssh $ROUTER -- '/ip/dns/static print detail'

echo ""
echo "=== Firewall Filter Rules ==="
ssh $ROUTER -- '/ip/firewall/filter print detail' | grep -E '(chain|action|comment|^\s+[0-9])'

echo ""
echo "=== Firewall NAT Rules ==="
ssh $ROUTER -- '/ip/firewall/nat print detail'

echo ""
echo "Done! Use these IDs in the import commands."
