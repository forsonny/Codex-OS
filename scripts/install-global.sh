#!/usr/bin/env bash

# Codex-OS Installation Script
# This script moves global files to the home directory and cleans up placeholders

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Header
echo ""
echo "======================================"
echo "   Codex-OS Global Files Installer"
echo "======================================"
echo ""

# Check if we're in the right directory
if [ ! -d "move to HOME/.codex-os" ] || [ ! -f "move to HOME/.codex/AGENTS.md" ]; then
    print_error "This script must be run from the root of the Codex-OS repository."
    print_error "Please ensure you're in the correct directory and the 'move to HOME' folder exists."
    exit 1
fi

print_info "Starting Codex-OS global files installation..."
echo ""

# Step 1: Create target directories
print_info "Creating target directories..."
mkdir -p ~/.codex-os
mkdir -p ~/.codex
print_success "Directories created"
echo ""

# Step 2: Move global Codex-OS files
print_info "Moving Codex-OS global files to ~/.codex-os..."
if [ -d ~/.codex-os ] && [ "$(ls -A ~/.codex-os 2>/dev/null)" ]; then
    print_warning "~/.codex-os already contains files. They will be overwritten."
    read -p "Continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled by user"
        exit 0
    fi
fi

# Move all contents from the placeholder directory to ~/.codex-os
cp -r "move to HOME/.codex-os"/* ~/.codex-os/
print_success "Codex-OS files moved to ~/.codex-os"
echo ""

# Step 3: Handle AGENTS.md
print_info "Processing AGENTS.md..."

# Check if AGENTS.md already exists and create backup
if [ -f ~/.codex/AGENTS.md ]; then
    BACKUP_NAME="AGENTS.md.backup.$(date +%Y%m%d_%H%M%S)"
    cp ~/.codex/AGENTS.md ~/.codex/$BACKUP_NAME
    print_success "Existing AGENTS.md backed up to ~/.codex/$BACKUP_NAME"
fi

# Move new AGENTS.md
mv "move to HOME/.codex/AGENTS.md" ~/.codex/AGENTS.md
print_success "AGENTS.md installed to ~/.codex/"
echo ""

# Step 4: Clean up placeholder directories
print_info "Cleaning up placeholder directories..."

# Remove directories in reverse order (deepest first)
rmdir "move to HOME/.codex-os/instructions/core" 2>/dev/null || true
rmdir "move to HOME/.codex-os/instructions" 2>/dev/null || true
rmdir "move to HOME/.codex-os/standards/code-style" 2>/dev/null || true
rmdir "move to HOME/.codex-os/standards" 2>/dev/null || true
rmdir "move to HOME/.codex-os/product" 2>/dev/null || true
rmdir "move to HOME/.codex-os" 2>/dev/null || true
rmdir "move to HOME/.codex" 2>/dev/null || true
rmdir "move to HOME" 2>/dev/null || true

print_success "Placeholder directories removed"
echo ""

# Step 5: Verify installation
print_info "Verifying installation..."

ERRORS=0

# Check if key directories exist
if [ ! -d ~/.codex-os/instructions/core ]; then
    print_error "~/.codex-os/instructions/core not found"
    ERRORS=$((ERRORS + 1))
fi

if [ ! -d ~/.codex-os/standards ]; then
    print_error "~/.codex-os/standards not found"
    ERRORS=$((ERRORS + 1))
fi

if [ ! -f ~/.codex/AGENTS.md ]; then
    print_error "~/.codex/AGENTS.md not found"
    ERRORS=$((ERRORS + 1))
fi

# Check for key files
KEY_FILES=(
    ~/.codex-os/instructions/core/plan-product.md
    ~/.codex-os/instructions/core/create-spec.md
    ~/.codex-os/instructions/core/execute-tasks.md
    ~/.codex-os/instructions/core/execute-task.md
    ~/.codex-os/instructions/core/analyze-product.md
    ~/.codex-os/standards/tech-stack.md
    ~/.codex-os/standards/code-style.md
    ~/.codex-os/standards/best-practices.md
)

for file in "${KEY_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        print_error "Missing file: $file"
        ERRORS=$((ERRORS + 1))
    fi
done

echo ""
if [ $ERRORS -eq 0 ]; then
    print_success "✅ Installation completed successfully!"
    echo ""
    echo "Global files have been installed to:"
    echo "  • ~/.codex-os/     (Codex-OS standards and instructions)"
    echo "  • ~/.codex/        (AGENTS.md for AI assistants)"
    echo ""
    echo "Next steps:"
    echo "  1. Make helper scripts executable: chmod +x bin/co-*"
    echo "  2. Install dependencies (if needed): npm install"
    echo "  3. Start using Codex-OS: bin/co-plan"
else
    print_error "❌ Installation completed with $ERRORS errors"
    print_error "Please check the error messages above and try again"
    exit 1
fi

echo ""
echo "======================================"
echo "   Installation Complete"
echo "======================================"
echo ""
