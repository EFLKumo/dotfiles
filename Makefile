all: fmt switch

ls:
	@echo "🍽️ Available commands"
	@echo "- switch"
	@echo "- switch-remote"
	@echo "- switch-offline"
	@echo "- switch-nobuild"
	@echo "- switch-slow"
	@echo "- boot"
	@echo "- vm"
	@echo "- update"
	@echo "- history"
	@echo "- replpkgs"
	@echo "- repl"
	@echo "- cleandry"
	@echo "- clean"
	@echo "- gc"
	@echo "- fmt"
	@echo "- encrypt"

switch:
	@echo "🔨 Rebuilding NixOS..."
	@nh os switch .
	@echo "🎉 Done."

switch-remote:
	@echo "🔗 Rebuilding NixOS using remote server..."
	@nh os switch . -- --option builders ssh-ng://nixremote@10.10.10.1
	@echo "🎉 Done."

switch-offline:
	@echo "🔨 Rebuilding NixOS without Internet..."
	@nh os switch . -- --no-net
	@echo "🎉 Done."

switch-nobuild:
	@echo "🔨⚡ Rebuilding NixOS without building packages..."
	@nixos-rebuild switch --flake  . --fast --sudo --json |& nom
	@echo "🎉 Done."

switch-slow:
	@echo "🔨 Rebuilding NixOS with limited cores..."
	@nh os switch . -- -j 2

boot:
	@echo "🔨 Rebuilding NixOS..."
	@nh os build .

test:
	@echo "❓ Test configuration..."
	@nh os test .

vm:
	@echo "🖥️ Building NixOS VM..."
	@nh os build-vm .

update:
	@echo "↗️ Updating flakes..."
	@nix flake update
	@echo "🎉 Done."

history:
	@nix profile history --profile /nix/var/nix/profiles/system

replpkgs:
	@nix repl -f flake:nixpkgs

repl:
	@nixos-rebuild repl --flake .

cleandry:
	@echo "🗑️ Listing all generations older than 15 days..."
	@sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --dry-run --older-than 15d
	@nix profile wipe-history --profile ~/.local/state/nix/profiles/home-manager --dry-run --older-than 15d
	@echo "🎉 Done."

clean:
	@echo "🧹 Removing all generations older than 15 days..."
	@sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 15d
	@nix profile wipe-history --profile ~/.local/state/nix/profiles/home-manager --older-than 15d
	@echo "🎉 Done."

gc:
	@nix store gc --debug
	@echo "🎉 Done."

fmt:
	@echo "✒️ Formatting nix files..."
	@nix fmt
	@echo "🎉 Done."

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
	@echo "🎉 Done."

.PHONY: os home news update history repl clean gc fmt
