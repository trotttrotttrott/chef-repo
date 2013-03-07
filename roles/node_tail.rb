name 'node_tail'
description 'Nginx/Unicorn for node-tail app'
run_list(
  'recipe[apt]',
  'recipe[build-essential]',
  'recipe[ruby_build]',
  'recipe[rbenv::system]',
  'recipe[ruby_shadow]', # needed for updating users::sysadmins
  'recipe[users::sysadmins]',
  'recipe[sudo]',
  'recipe[application_node-tail]',
  'recipe[nginx]'
)

default_attributes(
  'build-essential' => {
    'compiletime' => true
  },
  :authorization => {
    :sudo => {
      :groups => ['sysadmin'],
      :users => ['trotttrotttrott', 'travis'],
      :passwordless => true
    }
  },
  :rbenv => {
    :rubies => [
      '2.0.0-p0'
    ],
    :global => '2.0.0-p0',
    :gems => {
      '2.0.0-p0' => [
        :name => 'bundler'
      ]
    }
  }
)
