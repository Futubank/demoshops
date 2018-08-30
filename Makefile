all:
	@echo "No default rule"


hosts:
	cat docker-compose.yml | grep -E '(^  \w+:)|(ipv4_address)' | perl -e '$$_ = join("", <STDIN>); while (/(\w+):\s*\n.*?:\s*([\d.]+)/gs) { print "$$2 $$1.local\n"; };'
