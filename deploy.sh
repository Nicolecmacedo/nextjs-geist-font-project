#!/bin/bash

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Função para exibir mensagens de status
print_status() {
    echo -e "${YELLOW}>>> $1${NC}"
}

# Função para exibir mensagens de sucesso
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Função para exibir mensagens de erro
print_error() {
    echo -e "${RED}✗ $1${NC}"
    exit 1
}

# Verifica se a porta está em uso
check_port() {
    if lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null ; then
        print_status "Porta 3000 está em uso. Tentando liberar..."
        lsof -ti:3000 | xargs kill -9
        sleep 2
    fi
}

# Principal
main() {
    print_status "Iniciando deploy do EducaCUCA..."
    
    # Verifica e libera a porta 3000 se necessário
    check_port
    
    # Instala dependências
    print_status "Instalando dependências..."
    npm install || print_error "Falha ao instalar dependências"
    print_success "Dependências instaladas"
    
    # Build do projeto
    print_status "Construindo o projeto..."
    npm run build || print_error "Falha no build"
    print_success "Build concluído"
    
    # Inicia o servidor
    print_status "Iniciando servidor na porta 3000..."
    PORT=3000 npm run start || print_error "Falha ao iniciar servidor"
    
    print_success "Servidor iniciado com sucesso!"
    echo ""
    print_status "O EducaCUCA está rodando em: http://localhost:3000"
    echo ""
    print_status "Comandos úteis:"
    echo "- Parar servidor: Ctrl + C"
    echo "- Reiniciar: ./deploy.sh"
    echo ""
}

# Executa script
main
