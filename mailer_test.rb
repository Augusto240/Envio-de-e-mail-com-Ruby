require 'action_mailer'
require 'dotenv/load' # Carrega as variáveis de ambiente do arquivo .env

# Configura o Action Mailer para usar o servidor SMTP do Gmail
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp

# Configuração do SMTP do Gmail usando variáveis de ambiente
ActionMailer::Base.smtp_settings = {
  address: ENV['HOST'],       # Usando a variável de ambiente HOST
  port: 587,
  domain: ENV['DOMINIO'],     # Usando a variável de ambiente DOMINIO
  user_name: ENV['EMAILDEENVIO'], # Usando a variável de ambiente EMAILDEENVIO
  password: ENV['SENHA'],         # Usando a variável de ambiente SENHA
  authentication: 'plain',
  enable_starttls_auto: true
}

# Define o Mailer
class TestMailer < ActionMailer::Base
  default from: ENV['EMAILDEENVIO'] # Usando a variável de ambiente EMAILDEENVIO

  def test_email(to)
    mail(
      to: to,
      subject: 'Teste de E-mail com Ruby on Rails usando Action Mailer',
      body: 'Este é um e-mail de teste enviado usando Action Mailer do Ruby on Rails.'
    )
  end
end

# Envia um e-mail de teste
if __FILE__ == $0
  destinatario = 'destinatario' # Substitua pelo e-mail que deseja testar
  TestMailer.test_email(destinatario).deliver_now
  puts "E-mail enviado para #{destinatario} com sucesso!"
end
