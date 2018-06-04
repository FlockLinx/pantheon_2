Apipie.configure do |config|
  config.app_name                = "Pantheon2"
  config.api_base_url            = "/v1"
  config.doc_base_url            = "/api-documentation"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.validate                = false
  config.default_locale = nil

  config.app_info ="
  == Descricao API
  TODOS os endpoints disponiveis DEVEM ser acessados por um usuario valido
  e autenticado, para efetuar login se deve seguir o seguinte passo a passo.:

  1 - Acessar POST /auth/sign_in

  2 - Passar como parametro um json contendo os parametros email e password

  Exemplo.:
  { 'email': 'usuario@email.com.br', 'password': 'meu_password_secreto' }

  3 - Se o usuario for autenticado, a api retorna codigo 200 e alguns headers
  os que devem ser utilizados são.:
    Access-Token
    Client
    Uid

  Os requests subsequentes seguem a RFC6750

  Para finalizar a sessao se deve fazer o seguinte passo a passo.:

  1 - Acessar DELETE auth/sign_out

  2 - Os Headers obrigatorios são.:
    Access-Token
    Client
    Uid
  3 - Se a sessao for finalizada com sucesso, a api retorna codigo 200 e o json
    { 'success': true }

    Fluxo para recuperação de senha

  1 - Se deve utilizar o endpoint POST /auth/password passando os parametros
    { 'email': 'email_que_esqueceu_asenha@exemplo.com.br', 'redirect_url': 'url_do_integrador/redefinir_senha_do_usuario' }

  1.1 - A redirect_url será uma url que o integrador disponibiliza que deve conter os campos
  password e password_confirmation.

  2 - Se a request for realizada corretamente o usuário receberá um email contendo um link
  com um token gerado pela API essa url deve conter o redirect_url, com isso o link
  irá redirecionar o usuario para a tela de redefinição de senha.

  3 - Essa tela de redefinição de senha deve fazer uma request para PUT /auth/password
  passando como parametro
    {'password': 'meu_password_secreto', 'password_confirmation': 'meu_password_secreto' }
  juntamente com os headers que são fornecidos pela API uid, client e access-token.

  4 - Documentação original https://github.com/lynndylanhurley/devise_token_auth/wiki/Reset-Password-Flow
  "

end
