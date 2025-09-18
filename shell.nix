{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "laravel-dev-php83";

  buildInputs = with pkgs; [
    # PHP 8.3 (versão principal)
    php83

    # Extensões PHP necessárias para Laravel
    php83.packages.mysql
    php83.packages.redis
    php83.packages.intl
    php83.packages.mbstring
    php83.packages.zlib
    php83.packages.openssl
    php83.packages.curl
    php83.packages.json
    php83.packages.pdo
    php83.packages.pdo_mysql

    # Serviços de backend
    mysql
    redis
    nginx

    # Ferramentas de desenvolvimento
    composer
    nodejs
    yarn
    git
    sqlite
  ];

  # Configura PATH e variáveis de ambiente
  shellHook = ''
    export PATH="${php83}/bin:${nginx}/bin:${mysql}/bin:${redis}/bin:${composer}/bin:$PATH"

    # Cria diretório para socket do MySQL (evita erros de permissão)
    mkdir -p $HOME/.tmp/mysql
    export MYSQL_SOCKET="$HOME/.tmp/mysql/mysql.sock"
    mkdir -p $(dirname "$MYSQL_SOCKET")

    # Dica: se quiser usar o socket padrão do Herd, descomente abaixo:
    # ln -sf "$MYSQL_SOCKET" /tmp/mysql.sock 2>/dev/null || true
  '';

  # Garante que o PHP encontre as extensões corretamente
  # (Nix já faz isso automaticamente, mas é bom ter explícito)
  LD_LIBRARY_PATH = "${php83}/lib/php/extensions:${LD_LIBRARY_PATH}";
}