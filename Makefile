all: fmt switch

switch:
	@echo "Rebuilding NixOS..."
	@nixos-rebuild switch --flake . --use-remote-sudo

boot:
	@echo "Rebuilding NixOS..."
	@nixos-rebuild boot --flake . --use-remote-sudo

vm:
	@echo "Building NixOS VM..."
	@nixos-rebuild build-vm --flake .

update:
	@echo "Updating flakes..."
	@nix flake update

history:
	@nix profile history --profile /nix/var/nix/profiles/system

replpkgs:
	@nix repl -f flake:nixpkgs

repl:
	@nixos-rebuild repl --flake .

cleandry:
	@echo "Listing all generations older than 15 days..."
	@sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --dry-run --older-than 15d
	@nix run home-manager#home-manager -- expire-generations -15days --dry-run

clean:
	@echo "Removing all generations older than 15 days..."
	@sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 15d
	@nix run home-manager#home-manager -- expire-generations -15days

gc:
	@nix store gc --debug

fmt:
	@echo "Formatting nix files..."
	@nix fmt

encrypt:
	@echo "🔒 Encrypting secrets..."
	@find secrets/origin -type f -print0 | while IFS= read -r -d '' file; do \
		rel_path="$${file#secrets/origin/}"; \
		out_file="secrets/$$rel_path"; \
		mkdir -p "$$(dirname "$$out_file")"; \
		\
		case "$$file" in \
			*.yaml|*.yml) input_type="yaml" ;; \
			*.json)       input_type="json" ;; \
			*.env|*.dotenv|*.ini) input_type="dotenv" ;; \
			*)            input_type="binary" ;; \
		esac; \
		\
		echo "Encrypting ($$input_type): $$file → $$out_file"; \
		sops --encrypt --input-type "$$input_type" --output-type "$$input_type" "$$file" > "$$out_file.tmp" && \
		mv -f "$$out_file.tmp" "$$out_file" || (rm -f "$$out_file.tmp"; exit 1); \
	done
	@echo "✅ Done."

.PHONY: os home news update history repl clean gc fmt
